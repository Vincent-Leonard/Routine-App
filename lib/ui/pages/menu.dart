part of 'pages.dart';

class Menu extends StatefulWidget {
  static const String routeName = "/Menu";
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Positive(),
    Negative(),
    History(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.check_circle_outline,
//               color: Colors.black,
//             ),
//             label: 'Positive Habit',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.cancel_outlined,
//               color: Colors.black,
//             ),
//             label: 'Negative Habit',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.article_outlined,
//               color: Colors.black,
//             ),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.account_circle_outlined,
//               color: Colors.black,
//             ),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         elevation: 0,
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: [
          Icons.check_circle_outline,
          Icons.cancel_outlined,
          Icons.article_outlined,
          Icons.account_circle_outlined,
        ],
        onChange: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
        defaultSelectedIndex: 0,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
      @required this.iconList,
      @required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        decoration: index == _selectedIndex
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4, color: Color(0xFF3E3E3E)),
                ),
                gradient: LinearGradient(colors: [
                  Color(0xFFBFBFBF).withOpacity(0.3),
                  Color(0xFFBFBFBF).withOpacity(0.015),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                )
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedIndex ? Color(0xFF3E3E3E) : Colors.grey,
        ),
      ),
    );
  }
}
