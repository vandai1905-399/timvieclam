# Flutter mobile app — TimViecLam (mẫu)

This folder contains a minimal Flutter app skeleton that simulates login and stores a fake token using SharedPreferences.

Prerequisites:
- Install Flutter SDK: https://flutter.dev/docs/get-started/install
- Make sure `flutter` is on your PATH and you have an emulator or device connected.

How to run:

1. Open a terminal and change to this folder:

   cd mobile_flutter

2. Get dependencies:

   flutter pub get

3. Run on a connected device or emulator:

   flutter run

Notes:
- Login is simulated: enter any valid email and password with at least 4 characters. A fake token is saved in SharedPreferences.
- To reset login, tap "Đăng xuất".
- If you want, I can add navigation, job-list screens, or wire a backend API.
