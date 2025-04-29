# SpeedPilot 🚗📶  
**SpeedPilot** is a Flutter-based iOS app designed to control an RC car over WiFi using a direct Access Point connection. This guide walks you through installing Flutter, preparing your environment, and running the app on a real iPhone.

---

## 🛠 Prerequisites

### ✅ Install Flutter SDK

Follow the official installation steps for macOS:  
🔗 https://docs.flutter.dev/get-started/install/macos

Then verify everything with:

```bash
flutter doctor
```

Make sure the following items are listed as complete (✓):

- Flutter
- Xcode
- CocoaPods
- iOS toolchain

### ✅ Install Xcode & Command Line Tools

1. Install Xcode from the Mac App Store.
2. Open it once to accept the license terms.
3. Install CLI tools:

```bash
xcode-select --install
```

### ✅ Install CocoaPods (for iOS dependencies)

```bash
sudo gem install cocoapods
```

### ✅ Sign in with Apple ID in Xcode

- Open **Xcode** → **Settings** → **Accounts**
- Add your Apple ID
- Create or use an existing Development Team

---

## 📲 Running SpeedPilot on a Real iOS Device

### 1. Connect Your iPhone

- Use a USB cable.
- Unlock your phone and tap “Trust This Computer” if prompted.

### 2. Trust Your Developer Certificate (first time only)

On the iPhone:

- Go to `Settings > General > VPN & Device Management`
- Tap your Apple ID under *Developer App* and trust it

### 3. Clone the Repository

```bash
git clone https://github.com/tobiassng/speedpilot.git
cd speedpilot
flutter pub get
```

### 4. Configure iOS Project (one-time setup in Xcode)

Open the iOS workspace:

```bash
open ios/Runner.xcworkspace
```

In Xcode:

- Click on the "Runner" project in the left sidebar
- Go to the "Signing & Capabilities" tab
- Select your Apple Developer Team

Then close Xcode.

### 5. Run the App on Your iPhone

With your iPhone still connected:

```bash
flutter run
```

If you have more than one device connected:

```bash
flutter devices
flutter run -d <device-id>
```

---

## 🌐 WiFi Setup (Access Point Mode)

1. Power on your RC car. It should create a local WiFi hotspot (Access Point).
2. On your iPhone, go to **Settings > Wi-Fi**
3. Connect to the RC car’s WiFi network (e.g. `RC-CAR-AP` or similar)
4. Start the **SpeedPilot** app – it communicates directly with the car via the local WiFi link.

> 📶 Internet is not required, since all communication happens over the local access point.

---

## 🧪 Troubleshooting

- Ensure you're connected to the RC car’s WiFi before launching the app.
- If you encounter iOS build issues:
  ```bash
  flutter clean
  flutter pub get
  ```
- Check that your Flutter and Xcode setup is complete:
  ```bash
  flutter doctor
  ```

---

## 📦 Useful Commands

```bash
flutter doctor       # Diagnose Flutter installation
flutter devices      # List available devices
flutter pub get      # Install dependencies
flutter run          # Build and run the app
flutter clean        # Clean build artifacts
```

---

## 📁 Project Structure

```
speedpilot/
├── lib/              # Dart source code
├── ios/              # iOS-specific setup
├── android/          # Android-specific setup (optional)
├── pubspec.yaml      # Project metadata and dependencies
└── README.md         # This file
```

---

## 📄 License

MIT License © [Your Name or Company]
