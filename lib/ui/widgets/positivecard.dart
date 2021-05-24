part of 'widgets.dart';

class PositiveCard extends StatefulWidget {
  final Habits habits;
  PositiveCard({this.habits});

  @override
  _PositiveCardState createState() => _PositiveCardState();
}

class _PositiveCardState extends State<PositiveCard> {
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
                    icon: Icon(CupertinoIcons.ellipses_bubble_fill),
                    color: Colors.blue,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext ctx) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            padding: EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  icon: Icon(CupertinoIcons.eye_fill),
                                  label: Text("Show Data"),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey),
                                ),
                                ElevatedButton.icon(
                                  icon: Icon(CupertinoIcons.pencil),
                                  label: Text("Edit Data"),
                                  onPressed: () {},
                                ),
                                ElevatedButton.icon(
                                  icon: Icon(CupertinoIcons.trash_fill),
                                  label: Text("Delete Data"),
                                  onPressed: () async {
                                    bool result =
                                        await HabitServices.deleteHabit(
                                            habit.habitId);
                                    if (result) {
                                      ActivityServices.showToast(
                                          "Delete data success.", Colors.green);
                                    } else {
                                      ActivityServices.showToast(
                                          "Delete data failed.", Colors.red);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red[600]),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
