part of 'pages.dart';

class AddHabit extends StatefulWidget {
  static const String routeName = "AddHabit";
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("defaultHabits");

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              habitCollection.where('defaultHabit', isEqualTo: "1").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Failed to load data!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ActivityServices.loadings();
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                Habits habits = new Habits(
                  doc.data()['habitId'],
                  doc.data()['habitName'],
                  doc.data()['habitType'],
                  doc.data()['typeValue'],
                  doc.data()['defaultHabit'],
                  doc.data()['positiveHabit'],
                  doc.data()['habitcreatedAt'],
                  doc.data()['habitupdatedAt'],
                );
                return HabitCard(habits: habits);
              }).toList(),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Habit", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            buildBody(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                          context, NewHabit.routeName);
                    },
                    icon: Icon(Icons.add),
                    label: Text("New Habit"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
