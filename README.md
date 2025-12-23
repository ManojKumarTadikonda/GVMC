GVMC – Smart Waste Management System

GVMC is a full-stack smart waste management system that integrates a Node.js backend, Flutter frontend, and Python-based ML models to enable efficient waste monitoring, authentication, and intelligent decision-making.

📁 Project Structure
GVMC/
├── Backend/        # Node.js + Express backend
├── Frontend/       # Flutter application
│   └── hackwave/
├── py/             # Python ML & data processing
├── .gitignore
└── README.md

🛠️ Tech Stack
Backend

Node.js

Express.js

MongoDB

JWT Authentication

Frontend

Flutter

Dart

Android / Windows / macOS / Linux support

Python

Python 3.x

TensorFlow / Keras (ML models)

JSON-based input/output

✅ Prerequisites

Make sure you have the following installed:

Node.js (v16+ recommended)

npm

Flutter SDK

Python 3.8+

MongoDB (local or cloud – MongoDB Atlas)

Verify installations:

node -v
npm -v
flutter --version
python --version

⚙️ Backend Setup (Node.js)
1️⃣ Navigate to Backend
cd Backend

2️⃣ Install dependencies
npm install

3️⃣ Create environment file

Create a .env file in Backend/:

PORT=5000
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key

4️⃣ Run backend server
npm start


OR (for development):

npm run dev


📍 Backend will run on:

http://localhost:5000

📱 Frontend Setup (Flutter)
1️⃣ Navigate to Flutter app
cd Frontend/hackwave

2️⃣ Get Flutter packages
flutter pub get

3️⃣ Run the app

For connected device / emulator:

flutter run


For specific platform:

flutter run -d chrome
flutter run -d windows
flutter run -d android

🧠 Python Module Setup (ML)
1️⃣ Navigate to Python folder
cd py

2️⃣ Create virtual environment (recommended)
python -m venv venv


Activate it:

Windows

venv\Scripts\activate


Linux / macOS

source venv/bin/activate

3️⃣ Install dependencies
pip install -r requirements.txt

4️⃣ Run Python app / scripts
python app.py


📌 ML models used:

waste_management_relu_model.h5

waste_management_relu_model_legacy.h5

🔗 How Components Work Together

Flutter frontend communicates with Node.js backend via REST APIs

Backend handles authentication, database operations, and logic

Python ML module processes data and predictions (can be integrated via API or scripts)

🔐 Security Notes

.env files are ignored and should never be committed

Use .env.example for sharing environment variables structure

Do not commit secrets or credentials

🚀 Running All Services Together (Order)

Start MongoDB

Run Backend

Run Python ML module (if required)

Run Flutter Frontend

🤝 Contribution

Fork the repository

Create a feature branch

Commit your changes

Open a Pull Request

📄 License

This project is for educational and development purposes.

👤 Author

Manoj Kumar Tadikonda
GitHub: https://github.com/ManojKumarTadikonda
