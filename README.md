# TimViecLam — Demo web + mobile skeleton

This workspace contains a small demo for a job-finding app (TimViecLam):

- `web/` — A responsive static web app with a homepage that includes a login form. The login is simulated client-side (no backend). Open `web/index.html` in your browser.
- `mobile/` — A minimal Expo React Native skeleton with a login screen. This is a starting point to build a mobile app.

Quick start — web:

1. Open `web/index.html` in your browser (double-click or use Live Server).
2. Enter any valid email and a password with at least 4 characters to simulate login. The app stores a fake token in `localStorage`.

Quick start — mobile (Expo):

1. Install Node.js and npm.
2. From `mobile/` run:

   npm install
   npm run start

3. Use Expo Go on your phone or an emulator to view the app.

Next steps you might want:

- Add a real backend (Express, Firebase, etc.) and replace the simulated login with API calls.
- Make the web app a PWA and/or package it with Capacitor/Cordova.
- Extend the mobile app with navigation, protected routes, and API integration.

If you'd like, I can:
- Wire a tiny Express backend and implement real login endpoints (demo users).
- Convert the web app into a PWA and show how to build a native wrapper with Capacitor.
- Expand the mobile app with React Navigation and a jobs list screen.

Tell me which of those you want next and I can continue. 
