part of 'pages.dart';

class AddNegative extends StatefulWidget {
  static const String routeName = "AddNegative";

  @override
  _AddNegativeState createState() => _AddNegativeState();
}

class _AddNegativeState extends State<AddNegative> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("defaultHabits");

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: habitCollection
              .where('positiveHabit', isEqualTo: "1")
              .where("defaultHabit", isEqualTo: "1")
              .snapshots(),
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                          context, NewNegative.routeName);
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
