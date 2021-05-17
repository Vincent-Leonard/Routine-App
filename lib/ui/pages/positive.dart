part of 'pages.dart';

class Positive extends StatefulWidget {
  @override
  _PositiveState createState() => _PositiveState();
}

class _PositiveState extends State<Positive> {
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
            ListView(
              padding: EdgeInsets.all(8),
              children: [],
            ),
            IconButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, AddHabit.routeName);
              },
              icon: Icon(Icons.add_circle_outline),
            )
          ],
        ),
      ),
    );
  }
}
