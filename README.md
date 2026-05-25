# SparshAI 🌿

> **Sparsh** (स्पर्श) — Sanskrit for *touch*. An AI-powered dermatology assistant that brings intelligent skin care analysis to your fingertips.

SparshAI is a cross-platform mobile application built with Flutter that leverages machine learning to analyze skin conditions and provide AI-assisted dermatological insights. Whether you're looking for a preliminary assessment or simply tracking your skin health over time, SparshAI puts expert-level analysis in your pocket.

---

## ✨ Features

- **AI Skin Analysis** — Capture or upload a photo of a skin condition and get an instant AI-powered assessment via the DermAid module.
- **Cross-Platform** — Runs on both Android and iOS from a single Flutter codebase.
- **Firebase Integration** — Secure authentication, real-time data sync, and cloud storage powered by Firebase.
- **Clean, Intuitive UI** — A user-friendly interface designed to make complex dermatological insights accessible to everyone.

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Mobile Framework | Flutter (Dart) |
| Native Extensions | C / C++ (via Flutter FFI / CMake) |
| Backend & Auth | Firebase (google-services.json) |
| iOS Support | Swift |
| Build System | CMake |

---

## 📁 Project Structure

```
SparshAI/
├── derm_aid/               # Core Flutter application (DermAid module)
│   ├── lib/                # Dart source code
│   ├── android/            # Android-specific configuration
│   ├── ios/                # iOS-specific configuration
│   └── ...
├── google-services.json    # Firebase project configuration
├── .gitignore
└── .gitattributes
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel recommended)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter plugin
- Xcode (for iOS builds, macOS only)
- A Firebase project set up at [console.firebase.google.com](https://console.firebase.google.com)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/arin0008/SparshAI.git
   cd SparshAI/derm_aid
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   Replace the existing `google-services.json` (Android) and add your `GoogleService-Info.plist` (iOS) with credentials from your own Firebase project.

4. **Run the app**
   ```bash
   flutter run
   ```

   To run on a specific device:
   ```bash
   flutter run -d <device_id>
   ```

   List available devices with:
   ```bash
   flutter devices
   ```

---

## 📱 Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

---

## ⚠️ Disclaimer

SparshAI is intended for **informational purposes only** and is **not a substitute for professional medical advice, diagnosis, or treatment**. Always consult a qualified dermatologist or healthcare provider for any skin condition concerns.

---

## 🤝 Contributing

Contributions are welcome! To get started:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📄 License

This project is currently unlicensed. Please contact the repository owner for usage permissions.

---

## 👤 Author

**arin0008** — [GitHub Profile](https://github.com/arin0008)

---

*Made with ❤️ and Flutter*
