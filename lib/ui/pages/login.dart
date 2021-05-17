part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                              await AuthServices.signIn(
                                      ctrlEmail.text, ctrlPass.text)
                                  .then((value) {
                                if (value == "success") {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ActivityServices.showToast(
                                      "Login Success", Colors.green);
                                  Navigator.pushReplacementNamed(
                                      context, Menu.routeName);
                                } else {
                                  setState(() {
                                    isLoading == false;
                                  });
                                  ActivityServices.showToast(value, Colors.red);
                                }
                              });
                              //ke tahap berikutnya
                              Navigator.pushReplacementNamed(
                                  context, Menu.routeName);
                            } else {
                              //kosongkan aja
                              Fluttertoast.showToast(
                                msg: "Please check the Fields!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          },
                          icon: Icon(Icons.login_rounded),
                          label: Text("Login"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[200], elevation: 0),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Register.routeName);
                          },
                          child: Text(
                            "Not Registered yet? Join Now",
                            style: TextStyle(
                                color: Colors.green[400], fontSize: 16),
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
