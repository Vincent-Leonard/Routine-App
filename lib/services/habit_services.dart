part of 'services.dart';

class HabitServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static DocumentReference userDocument;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static DocumentReference habitDocument;

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
      userCollection.doc(uid).collection("habit").doc(habitDocument.id).update({
        'habitId': habitDocument.id,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHabit(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await userCollection.doc(id).delete().then((value) {
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
    userCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("habits");
    await userCollection.doc(uid).set({
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
}
