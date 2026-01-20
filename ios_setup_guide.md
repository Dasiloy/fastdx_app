# 📱 Simple Guide to Test on iOS

Follow these steps to get **FastDx** running on your iPhone.

## 1. Prerequisites
- **Mac** with the latest **Xcode** installed.
- **Physical iPhone** and a USB cable.
- **Apple ID** (you don't need a paid developer account).

## 2. Connect & Trust
1. Plug your iPhone into your Mac.
2. If prompted on the iPhone, tap **"Trust This Computer"**.

## 3. Configure Xcode (One-time Setup)
1. Open the Xcode workspace. You can do this by running this command in your terminal (from the project root):
   ```bash
   open ios/Runner.xcworkspace
   ```
   *Alternatively, find the file in your Mac Finder and double-click it.*
2. In Xcode, select the **Runner** project in the left sidebar.
3. Select **Runner** under "Targets" in the middle panel.
4. Go to the **Signing & Capabilities** tab.
5. Click **Add Account** (or select your existing Apple ID).
6. Under **Team**, select your name (Personal Team).
7. Xcode might show a "Registering device" message. Let it finish.

## 4. Install Dependencies
Open your terminal in the project root and run:
```bash
cd ios
pod install
cd ..
```

## 5. Run the App
With your iPhone still connected:
1. In your terminal, run:
   ```bash
   flutter run
   ```
2. Select your iPhone from the list of devices (if prompted).

## 6. Permissions (First Run Only)
The first time you run the app, you will see an "Untrusted Developer" error on your iPhone.
1. Go to **Settings** > **General** > **VPN & Device Management**.
2. Tap on your **Apple ID**.
3. Tap **"Trust [Your Email]"**.
4. Now, open the app again!

---

> [!TIP]
> If you encounter a "CocoaPods out of date" error, run `brew upgrade cocoapods`.
