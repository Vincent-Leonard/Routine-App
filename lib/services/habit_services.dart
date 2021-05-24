part of 'services.dart';

class HabitServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("habits");
  static DocumentReference habitDocument;
  static CollectionReference timeCollection = FirebaseFirestore.instance
      .collection("habits")
      .doc(habitDocument.id)
      .collection("date");
  static CollectionReference userCollection = FirebaseFirestore.instance
      .collection("habits")
      .doc(habitDocument.id)
      .collection("users");

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addHabit(Habits habits) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    habitDocument = await habitCollection.add({
      'habitId': habits.habitId,
      'habitName': habits.habitName,
      'habitType': habits.habitType,
      'typeValue': habits.typeValue,
      'defaultHabit': habits.defaultHabit,
      'positiveHabit': habits.positiveHabit,
      'addBy': habits.addBy,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });

    if (habitDocument != null) {
      habitCollection.doc(habitDocument.id).update({
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
    await habitCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

  static Future<bool> addDefaultHabit(String uid, String habitId) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    userCollection = FirebaseFirestore.instance
        .collection("habits")
        .doc(habitId)
        .collection("users");
    await userCollection.doc(uid).set({
      'user': uid,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });

    return true;
  }
}
