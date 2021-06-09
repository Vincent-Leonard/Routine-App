part of 'services.dart';

class ActivityServices {
  static String dateNow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String hasil = formatter.format(now);
    return hasil;
  }

  static void showToast(String msg, Color myColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: myColor,
        textColor: Colors.white,
        fontSize: 14);
  }

  static Container loadings() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: SpinKitSpinningCircle(
        size: 50,
        color: Colors.deepPurple[800],
      ),
    );
  }
}
