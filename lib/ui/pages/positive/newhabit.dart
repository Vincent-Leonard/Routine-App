part of '../pages.dart';

class NewHabit extends StatefulWidget {
  static const String routeName = "NewHabit";
  @override
  _NewHabitState createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlType = TextEditingController();
  final ctrlValue = TextEditingController();
  String selectedValue;
  String selectedType;
  List<DropdownMenuItem<String>> listDropType = [];
  List<DropdownMenuItem<String>> listDropValue = [];

  void loadDataType() {
    listDropType = [];
    listDropType.add(new DropdownMenuItem(
      child: new Text('Check'),
      value: "Check",
    ));
    listDropType.add(new DropdownMenuItem(
      child: new Text('Cumulative'),
      value: "Cumulative",
    ));
  }

  void loadDataValue() {
    listDropValue = [];
    listDropValue.add(new DropdownMenuItem(
      child: new Text('None'),
      value: "None",
    ));
    listDropValue.add(new DropdownMenuItem(
      child: new Text('Hours'),
      value: "Hours",
    ));
    listDropValue.add(new DropdownMenuItem(
      child: new Text('Times'),
      value: "Times",
    ));
    listDropValue.add(new DropdownMenuItem(
      child: new Text('Reps'),
      value: "Reps",
    ));
    listDropValue.add(new DropdownMenuItem(
      child: new Text('Portion'),
      value: "Portion",
    ));
  }

  void loadNoneValue() {
    listDropValue = [];
    listDropValue.add(new DropdownMenuItem(
      child: new Text('None'),
      value: "None",
    ));
  }

  void itemValue() {
    if (selectedType == "Check") {
      return loadNoneValue();
    } else {
      return loadDataValue();
    }
  }

  void dispose() {
    ctrlName.dispose();
    ctrlType.dispose();
    ctrlValue.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlType.clear();
    ctrlValue.clear();
  }

  @override
  Widget build(BuildContext context) {
    loadDataType();
    // loadDataValue();
    return Scaffold(
      appBar: AppBar(
        title: Text("New Habit", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(4),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: ctrlName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Habit Name",
                          prefixIcon: Icon(Icons.label),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the Field";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      new DropdownButton(
                        value: selectedType,
                        items: listDropType,
                        hint: new Text('Select Type'),
                        onChanged: (value) {
                          selectedType = value;
                          setState(() {});
                          if (selectedValue != null) {
                            selectedValue = "None";
                          }
                          itemValue();
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      new DropdownButton(
                        value: selectedValue,
                        items: listDropValue,
                        hint: new Text('Select Value'),
                        onChanged: (value) {
                          selectedValue = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          Habits habits = Habits(
                            "",
                            ctrlName.text,
                            selectedType,
                            selectedValue,
                            "0",
                            "0",
                            "",
                            "",
                          );
                          await HabitServices.addHabit(habits).then((value) {
                            if (value == true) {
                              ActivityServices.showToast(
                                  "Add habit successful!", Colors.green);
                              clearForm();
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              ActivityServices.showToast(
                                  "Save Habit Failed", Colors.red);
                            }
                          });
                          Navigator.pushReplacementNamed(
                              context, Menu.routeName);
                        },
                        icon: Icon(Icons.save),
                        label: Text("Save Habit"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[400], elevation: 0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
