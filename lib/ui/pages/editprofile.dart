part of 'pages.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  static const String routeName = "/editprofile";
}

class _EditProfileState extends State<EditProfile> {
  bool isVisible = true;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Color(0xFFf96060),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
