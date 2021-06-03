part of 'pages.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text('Name: '),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit Data"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 0,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AuthServices.signOut().then((value) {
                      if (value == true) {
                        setState(() {
                          isLoading = false;
                        });
                        ActivityServices.showToast(
                            "Logout Success", Colors.green);
                        Navigator.pushReplacementNamed(
                            context, Login.routeName);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ActivityServices.showToast("Logout Failed", Colors.red);
                      }
                    });
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
