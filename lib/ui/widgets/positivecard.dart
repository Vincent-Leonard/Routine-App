part of 'widgets.dart';

class PositiveCard extends StatefulWidget {
  final Habits habits;
  PositiveCard({this.habits});

  @override
  _PositiveCardState createState() => _PositiveCardState();
}

class _PositiveCardState extends State<PositiveCard> {
  String habitType = "Check";
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference habitCollection =
      FirebaseFirestore.instance.collection("users");
  String variable = "a";
  String value = "";

  buildBody() async {
    Habits habit = widget.habits;
    String dateNow = ActivityServices.dateNow();
    habitCollection
        .doc(uid)
        .collection("habits")
        .doc(habit.habitId)
        .collection("date")
        .doc(dateNow)
        .get()
        .then((value) => {
              if (value.exists) {variable = "True"} else {variable = ""}
            });
  }

  @override
  Widget build(BuildContext context) {
    Habits habit = widget.habits;
    buildBody();
    return Card(
      elevation: 1,
      shape: Border(
          left: BorderSide(
              color: variable.isNotEmpty ? Colors.green : Colors.grey,
              width: 10)),
      margin: EdgeInsets.only(bottom: 4),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                habit.habitName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text(habit.date.amount),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      icon: Icon(CupertinoIcons.book),
                      color: Colors.blue,
                      onPressed: () async {
                        if (habit.habitType == "Check") {
                          habitType = "Check";
                        } else {
                          habitType = "Cumulative";
                        }
                        value = habit.typeValue;
                        _showDialog();
                      }),
                  IconButton(
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                    icon: Icon(CupertinoIcons.delete),
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog() async {
    if (habitType == "Check") {
      await showDialog<String>(
          context: context,
          builder: (context) {
            return _SystemPadding(
              child: new AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Title(
                          color: Colors.black, child: new Text("Add Log")),
                    )
                  ],
                ),
                actions: <Widget>[
                  new TextButton(
                      child: const Text('REMOVE LOG'),
                      onPressed: () async {
                        Habits habit = widget.habits;
                        bool result =
                            await HabitServices.deleteLog(habit.habitId);
                        if (result) {
                          ActivityServices.showToast(
                              "Remove Log success.", Colors.green);
                        } else {
                          ActivityServices.showToast(
                              "Remove Log failed.", Colors.red);
                        }
                        Navigator.pop(context);
                      }),
                  new TextButton(
                      child: const Text('ADD LOG'),
                      onPressed: () async {
                        Habits habit = widget.habits;
                        bool result = await HabitServices.addLog(
                            habit.habitId,
                            habit.habitType,
                            habit.typeValue,
                            "0",
                            habit.habitName);
                        if (result) {
                          ActivityServices.showToast(
                              "Add Log success.", Colors.green);
                        } else {
                          ActivityServices.showToast(
                              "Add Log failed.", Colors.red);
                        }
                        Navigator.pop(context);
                      })
                ],
              ),
            );
          });
    } else if (habitType == "Cumulative") {
      TextEditingController inputValue = new TextEditingController();
      await showDialog<String>(
          context: context,
          builder: (context) {
            return _SystemPadding(
              child: new AlertDialog(
                contentPadding: const EdgeInsets.all(16.0),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        controller: inputValue,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Number of ' + value,
                            hintText: 'Example : 50'),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  new TextButton(
                      child: const Text('REMOVE LOG'),
                      onPressed: () async {
                        Habits habit = widget.habits;
                        bool result =
                            await HabitServices.deleteLog(habit.habitId);
                        if (result) {
                          ActivityServices.showToast(
                              "Remove Log success.", Colors.green);
                        } else {
                          ActivityServices.showToast(
                              "Remove Log failed.", Colors.red);
                        }
                        Navigator.pop(context);
                      }),
                  new TextButton(
                      child: const Text('ADD LOG'),
                      onPressed: () async {
                        Habits habit = widget.habits;
                        bool result = await HabitServices.addLog(
                          habit.habitId,
                          habit.habitType,
                          habit.typeValue,
                          inputValue.text,
                          habit.habitName,
                        );
                        if (result) {
                          ActivityServices.showToast(
                              "Add Log success.", Colors.green);
                        } else {
                          ActivityServices.showToast(
                              "Add Log failed.", Colors.red);
                        }
                        Navigator.of(context).pop;
                      })
                ],
              ),
            );
          });
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
      onPressed: () async {
        Habits habit = widget.habits;
        bool result = await HabitServices.deleteHabit(habit.habitId);
        if (result) {
          ActivityServices.showToast("Delete data success.", Colors.green);
        } else {
          ActivityServices.showToast("Delete data failed.", Colors.red);
        }
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Are You Sure to Delete?",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Deleting this habit will delete all of it's data and history",
        maxLines: 3,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        // padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
