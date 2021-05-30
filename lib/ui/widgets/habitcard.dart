part of 'widgets.dart';

class HabitCard extends StatefulWidget {
  final Habits habits;
  HabitCard({this.habits});

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  String user = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    Habits habit = widget.habits;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 24.0,
              ),
              title: Text(
                habit.habitName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 1,
                softWrap: true,
              ),
              subtitle: Text(
                habit.habitType,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.check_mark,
                        color: Colors.green[400],
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        await HabitServices.addDefaultHabit(
                                user,
                                habit.habitId,
                                habit.habitName,
                                habit.habitType,
                                habit.typeValue,
                                habit.defaultHabit,
                                habit.positiveHabit)
                            .then((value) {
                          if (value == true) {
                            ActivityServices.showToast(
                                "Add habit successful!", Colors.green);
                            setState(() {
                              // isLoading = false;
                            });
                          } else {
                            ActivityServices.showToast(
                                "Save Habit Failed", Colors.red);
                          }
                        });
                        Navigator.pushReplacementNamed(context, Menu.routeName);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
