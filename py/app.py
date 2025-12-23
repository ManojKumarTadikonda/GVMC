from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
from datetime import datetime, timedelta

app = Flask(__name__)

# Load your pre-trained ML model (we don't need to compile for inference)
model = tf.keras.models.load_model('waste_management_relu_model.h5', compile=False)

# The model expects 19 features as input
MODEL_INPUT_DIM = 19


@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        if data is None:
            return jsonify({"message": "Invalid or missing JSON body"}), 400

        # Support both { "inputs": {...} } and flat JSON { ... }
        inputs = data.get("inputs", data)

        # 1) Read base date (the date of the current status)
        try:
            base_date_str = inputs["date"]  # "2024-07-20"
            base_date = datetime.strptime(base_date_str, "%Y-%m-%d").date()
        except KeyError:
            return jsonify({"message": "Missing 'date' field in inputs"}), 400
        except ValueError:
            return jsonify({"message": "Invalid date format. Use YYYY-MM-DD."}), 400

        # 2) Extract numeric features used by the model
        try:
            population_density = float(inputs["population_density"])
            threshold_frequency_percent = float(inputs["threshold_frequency_percent"])
            expected_event_waste_percent = float(inputs["expected_event_waste_percent"])
            permanent_source_waste_percent = float(inputs["permanent_source_waste_percent"])
            waste_already_present_percent = float(inputs["waste_already_present_percent"])
        except KeyError as e:
            return jsonify({
                "message": "Missing required input field",
                "missing_field": str(e)
            }), 400
        except ValueError as e:
            return jsonify({
                "message": "Input values must be numeric",
                "error": str(e)
            }), 400

        # 3) Build feature vector (5 real features + padding)
        base_features = [
            population_density,
            threshold_frequency_percent,
            expected_event_waste_percent,
            permanent_source_waste_percent,
            waste_already_present_percent,
        ]

        MODEL_INPUT_DIM = 19
        padding_len = MODEL_INPUT_DIM - len(base_features)
        if padding_len < 0:
            return jsonify({
                "message": "Too many features in base_features",
                "details": f"Model expects {MODEL_INPUT_DIM}, got {len(base_features)}"
            }), 500

        features = base_features + [0.0] * padding_len  # length == 19

        input_data = np.array([features], dtype=np.float32)

        # 4) Predict (assume output = days until overflow)
        prediction = model.predict(input_data)
        predicted_days = float(prediction[0][0])

        # round to nearest day
        days_offset = int(round(predicted_days))

        # 5) Compute next overflow date
        next_overflow_date = base_date + timedelta(days=days_offset)

        return jsonify({
            "inputs": inputs,
            "prediction_raw": predicted_days,
            "days_offset": days_offset,
            "nextOverflowDate": next_overflow_date.isoformat()
        }), 200

    except Exception as e:
        return jsonify({"message": "Error in prediction", "error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000, debug=True)
