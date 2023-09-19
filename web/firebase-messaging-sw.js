importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;

firebase.initializeApp({
    apiKey: "AIzaSyDxVttLGaAuq57VMTWR_6UrL0yIiZadwcY",
    authDomain: "cropi-399723.firebaseapp.com",
    projectId: "cropi-399723",
    storageBucket: "cropi-399723.appspot.com",
    messagingSenderId: "799474908487",
    appId: "1:799474908487:web:6fe3852249b51e98a96062",
    measurementId: "G-XSCH3VRE51"
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});

self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
