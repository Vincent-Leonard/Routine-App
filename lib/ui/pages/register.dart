part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "Register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(32),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: ctrlPhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill Phone Number";
                            } else {
                              if (value.length < 7 || value.length > 14) {
                                return "Phone number is not valid";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please fill Email Address";
                            } else {
                              if (!EmailValidator.validate(value)) {
                                return "Email is not valid";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: ctrlPass,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.vpn_key),
                              border: OutlineInputBorder(),
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value.length < 6
                                ? "Password must have at least 6 character"
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Users users = new Users(
                                  "",
                                  ctrlName.text,
                                  ctrlPhone.text,
                                  ctrlEmail.text,
                                  ctrlPass.text,
                                  "",
                                  "");
                              // String msg = await AuthServices.signUp(users);
                              await AuthServices.signUp(users).then((value) {
                                if (value == "success") {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToast(
                                      "Register Success", Colors.green);
                                  Navigator.pushReplacementNamed(
                                      context, Login.routeName);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToast(value, Colors.red);
                                }
                              });
                              //ke tahap berikutnya
                              // Navigator.pushReplacementNamed(
                              //     context, MainMenu.routeName);
                            } else {
                              //kosongkan aja
                              Fluttertoast.showToast(
                                msg: "Please check the Fields!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          },
                          icon: Icon(Icons.save),
                          label: Text("Register"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[200], elevation: 0),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Login.routeName);
                          },
                          child: Text(
                            "Already Register? Login",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
