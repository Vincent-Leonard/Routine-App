part of 'pages.dart';

class Positive extends StatefulWidget {
  @override
  _PositiveState createState() => _PositiveState();
}

class _PositiveState extends State<Positive> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("habits");
  CollectionReference defaulthabitCollection;

  Widget buildBody2() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              habitCollection.where('defaultHabit', isEqualTo: 1).snapshots(),
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
                  doc.data()['addBy'],
                  doc.data()['habitcreatedAt'],
                  doc.data()['habitupdatedAt'],
                );
                return PositiveCard(habits: habits);
              }).toList(),
            );
          },
        ));
  }

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: habitCollection.where('addBy', isEqualTo: uid).snapshots(),
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
                  doc.data()['addBy'],
                  doc.data()['habitcreatedAt'],
                  doc.data()['habitupdatedAt'],
                );
                return PositiveCard(habits: habits);
              }).toList(),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Positive Habit"),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // buildBody2(),
              buildBody(),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[400],
          onPressed: () async {
            Navigator.pushReplacementNamed(context, AddHabit.routeName);
          },
        ));
  }
}
