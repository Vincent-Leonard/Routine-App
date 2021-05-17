part of 'services.dart';

class HabitServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("habits");
  static DocumentReference habitDocument;

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
      'defaultHabit': habits.defaultHabit,
      'positiveHabit': habits.positiveHabit,
      'addBy': habits.addBy,
      'createdAt': dateNow,
      'updatedAt': dateNow,
    });
    return true;
  }
}
