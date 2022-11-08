const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.toUpperCase = functions.https.onCall((data, _) => {
    return data.toString().toUpperCase();
});

//exports.toAverageRating = functions.firestore.document('userRatings/{documentId}').onCreate((snap, context) =>
// const newValue = snap.data();
// const resto_name = newValue.restoName;
// const rating = newValue.rate;
//
// return admin.firestore().collection('restaurants').doc(resto_name).get().then(queryResult => {
//
//    })
// )