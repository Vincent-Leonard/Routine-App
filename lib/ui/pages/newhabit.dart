part of 'pages.dart';

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

  void dispose() {
    ctrlName.dispose();
    ctrlType.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlType.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Habit"),
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
                      TextFormField(
                        controller: ctrlType,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Habit Type",
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
                      ElevatedButton.icon(
                        onPressed: () async {
                          Habits habits = Habits(
                              "",
                              ctrlName.text,
                              ctrlType.text,
                              "1",
                              "0",
                              FirebaseAuth.instance.currentUser.uid,
                              "",
                              "");
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
