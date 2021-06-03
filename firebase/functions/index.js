const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// # CLOUD FUNCTIONS
const admin = require("firebase-admin");
admin.initializeApp(functions.config().functions);

exports.messageTrigger = functions.firestore
    .document("messages/{messageId}")
    .onCreate(_sendMessage);

/**
 * Used to send a message to a user's device
 * when a new document is created in the messages collection
 * @param {snapshot} snapshot The snapshot of the data received.
 */
async function _sendMessage(snapshot) {
    if (snapshot.empty) {
        console.log("No Devices");
        return;
    }

    const tokens = [
        "dZ9VULbhSlO_92ilk3CNXY:APA91bHKd6GTohJ9PQLZPoG_nOGl2nbrSp54JCkXKajFKlCFOAPZwN67snlYH1dJvD0F502ZRyeOcpbhw4cDB0ScnM8igrdDJe2CmEcost4L0SneZu3_BZFiEI4sv31iZRUhjusvW-7D",
    ];
    const newData = snapshot.data();
    const payload = {
        notification: {
            title: newData.title,
            body: newData.body,
            sound: "default",
        },
        data: {
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            title: newData.title,
            body: newData.body,
        },
    };
    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log("Notification Sent Successfully");
        console.log(`Response: ${response}`);
    } catch (error) {
        console.log("Error sending notification");
        console.log(`Error: ${error}`);
    }
}
