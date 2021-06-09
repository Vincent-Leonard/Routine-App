part of 'pages.dart';

class Negative extends StatefulWidget {
  @override
  _NegativeState createState() => _NegativeState();
}

class _NegativeState extends State<Negative> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  static DocumentReference habitDocument;
  CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference defaulthabitCollection;

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: habitCollection
              .doc(uid)
              .collection("habits")
              .where('positiveHabit', isEqualTo: "1")
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
                return NegativeCard(habits: habits);
              }).toList(),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Negative Habit", style: TextStyle(color: Colors.white)),
          centerTitle: false,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              buildBody(),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[800],
          onPressed: () async {
            Navigator.pushReplacementNamed(context, AddNegative.routeName);
          },
        ));
  }
}
