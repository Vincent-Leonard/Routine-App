part of 'services.dart';

class HabitServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static DocumentReference userDocument;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference habitDocument;
  static CollectionReference logCollection =
      FirebaseFirestore.instance.collection("logs");

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addHabit(Habits habits) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    String uid = auth.currentUser.uid;
    habitDocument = await userCollection.doc(uid).collection("habits").add({
      'habitId': habits.habitId,
      'habitName': habits.habitName,
      'habitType': habits.habitType,
      'typeValue': habits.typeValue,
      'defaultHabit': habits.defaultHabit,
      'positiveHabit': habits.positiveHabit,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });

    if (habitDocument != null) {
      userCollection
          .doc(uid)
          .collection("habits")
          .doc(habitDocument.id)
          .update({
        'habitId': habitDocument.id,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHabit(String id) async {
    bool hsl = true;
    String uid = auth.currentUser.uid;
    await Firebase.initializeApp();
    await userCollection
        .doc(uid)
        .collection("habits")
        .doc(id)
        .delete()
        .then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

  static Future<bool> addDefaultHabit(
      String uid,
      String habitId,
      String habitName,
      String habitType,
      String typeValue,
      String defaultHabit,
      String positiveHabit) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    await userCollection.doc(uid).collection("habits").doc(habitId).set({
      'habitId': habitId,
      'habitName': habitName,
      'habitType': habitType,
      'typeValue': typeValue,
      'defaultHabit': defaultHabit,
      'positiveHabit': positiveHabit,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });
    return true;
  }

  static Future<bool> addLog(String habitId, String habitType, String typeValue,
      String amount, String habitName) async {
    await Firebase.initializeApp();
    String uid = auth.currentUser.uid;
    String dateNow = ActivityServices.dateNow();
    await userCollection
        .doc(uid)
        .collection("habits")
        .doc(habitId)
        .collection("date")
        .doc(dateNow)
        .set({
      'habitName': habitName,
      'habitType': habitType,
      'typeValue': typeValue,
      'date': dateNow,
      'amount': amount,
      'habitId': habitId,
      'userId': uid,
    });
    return true;
  }

  static Future<bool> deleteLog(String id) async {
    bool hsl = true;
    String uid = auth.currentUser.uid;
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    await userCollection
        .doc(uid)
        .collection("habits")
        .doc(id)
        .collection("date")
        .doc(dateNow)
        .delete()
        .then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }
}
