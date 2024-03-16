importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyAbeZu4Czyf_Ux84S7FftzPgsmpKA9aWw4",
      authDomain: "konya-restaurant-reservation.firebaseapp.com",
      projectId: "konya-restaurant-reservation",
      storageBucket: "konya-restaurant-reservation.appspot.com",
      messagingSenderId: "601384697415",
      appId: "1:601384697415:web:93e5babf59c7694d743b62",
      measurementId: "G-KJXKCMM4EQ"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
