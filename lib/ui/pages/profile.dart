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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: userCollection.where('uid', isEqualTo: uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ActivityServices.loadings();
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot doc) {
                    Users users;
                    users = new Users(
                      doc.data()['uid'],
                      doc.data()['name'],
                      doc.data()['phone'],
                      doc.data()['email'],
                      doc.data()['password'],
                      doc.data()['createdAt'],
                      doc.data()['updatedAt'],
                    );

                    return Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Name: " + users.name,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Email: " + users.email,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Phone: " + users.phone,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileMenu(
                            press: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await AuthServices.signOut().then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value == true) {
                                  ActivityServices.showToast(
                                      "Logout Success", Color(0xFFf96060));
                                  Navigator.pushReplacementNamed(
                                      context, Login.routeName);
                                } else {
                                  ActivityServices.showToast(
                                      "Log Out Failed", Color(0xFFFF7751));
                                }
                              });
                            },
                            text: "Log Out",
                            icon: Icons.logout),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
          isLoading == true ? ActivityServices.loadings() : Container()
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    this.press,
    this.icon,
    this.text,
  }) : super(key: key);

  final Function press;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF5F6F9),
            padding: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.deepOrange[600],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          )),
    );
  }
}
