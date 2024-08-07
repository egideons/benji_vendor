importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyDGt1l9AJydpXKB-oa6mWpW1Or9WYQXmvU",
  authDomain: "benji-vendor.firebaseapp.com",
  projectId: "benji-vendor",
  storageBucket: "benji-vendor.appspot.com",
  messagingSenderId: "815674234051",
  appId: "1:815674234051:web:4217a68ccf153e1d07be76",
  measurementId: "G-BETN32R56H",
});

const messaging = firebase.messaging();
