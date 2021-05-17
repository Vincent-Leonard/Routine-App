part of 'pages.dart';

class AddHabit extends StatefulWidget {
  static const String routeName = "AddHabit";
  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Habit"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(4),
              children: [],
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, NewHabit.routeName);
              },
              icon: Icon(Icons.add),
              label: Text("New Habit"),
            ),
          ],
        ),
      ),
    );
  }
}
