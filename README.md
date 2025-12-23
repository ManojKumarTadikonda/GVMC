# ♻️ GVMC – Smart Waste Management System

GVMC is a full-stack smart waste management platform designed to streamline waste monitoring and management using a **Flutter frontend**, **Node.js backend**, and **Python-based machine learning models**.

---

## 🛠 Tech Stack

* **Backend:** Node.js, Express.js, MongoDB, JWT
* **Frontend:** Flutter, Dart
* **ML / Data Processing:** Python, TensorFlow / Keras
* **Platforms:** Android, Windows, Linux, macOS

---

## 📁 Project Structure

```text
GVMC/
├── Backend/            # Node.js + Express backend
├── Frontend/
│   └── hackwave/       # Flutter application
├── py/                 # Python ML & data processing
├── .gitignore
└── README.md
```

---

## 🚀 Getting Started

Follow the instructions below to set up and run the project locally.

### 1. Clone the Repository

```bash
git clone https://github.com/ManojKumarTadikonda/GVMC.git
cd GVMC
```

---

## 🧪 Running Locally (Without Docker)

---

## 🔙 Backend Setup (Node.js + Express)

### Step 1: Navigate to Backend folder
```bash
cd Backend
```

### Step 2: Install dependencies
```bash
npm install
```

### Step 3: Configure Environment Variables
Create a `.env` file inside the `Backend` folder:

```env
PORT=5000
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key
```

> ⚠️ **Important:** Never commit `.env` files to GitHub.

### Step 4: Start Backend Server
```bash
npm start
```

OR (development mode):
```bash
npm run dev
```

*Backend will run at:*  
`http://localhost:5000`

---

## 🎨 Frontend Setup (Flutter)

Open a **new terminal window** and follow the steps below.

### Step 1: Navigate to Flutter app
```bash
cd Frontend/hackwave
```

### Step 2: Install Flutter dependencies
```bash
flutter pub get
```

### Step 3: Run the application
```bash
flutter run
```

Run on specific platforms:
```bash
flutter run -d android
flutter run -d windows
flutter run -d chrome
```

---

## 🧠 Python Module Setup (ML & Data Processing)

### Step 1: Navigate to Python folder
```bash
cd py
```

### Step 2: Create virtual environment (recommended)
```bash
python -m venv venv
```

Activate the environment:

**Windows**
```bash
venv\Scripts\activate
```

**Linux / macOS**
```bash
source venv/bin/activate
```

### Step 3: Install dependencies
```bash
pip install -r requirements.txt
```

### Step 4: Run Python application
```bash
python app.py
```

### 📌 ML Models Used
* `waste_management_relu_model.h5`
* `waste_management_relu_model_legacy.h5`

---

## 🔗 Application Flow

* Flutter frontend communicates with the Node.js backend via REST APIs
* Backend handles authentication, database operations, and business logic
* Python module processes ML predictions and waste classification logic

---

## 🔐 Security Notes

* `.env` files are ignored using `.gitignore`
* Use `.env.example` to share environment variable structure
* Never commit credentials or secrets

---

## ▶️ Running Order (Recommended)

1. Start **MongoDB**
2. Run **Backend server**
3. Run **Python ML module** (if required)
4. Run **Flutter Frontend**

---

## 🤝 Contribution

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

---

## 📄 License

This project is intended for educational and development purposes.

---

## 👤 Author

**Manoj Kumar Tadikonda**  
GitHub: https://github.com/ManojKumarTadikonda
