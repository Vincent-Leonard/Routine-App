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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.black,
            ),
            label: 'Positive Habit',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.black,
            ),
            label: 'Negative Habit',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_outlined,
              color: Colors.black,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }
}
