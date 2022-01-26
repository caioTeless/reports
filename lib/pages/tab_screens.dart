import 'package:flutter/material.dart';
import 'package:reports/pages/home_page.dart';
import 'package:reports/pages/read_data.dart';

class TabScreens extends StatefulWidget {
  const TabScreens({Key? key}) : super(key: key);

  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    HomePage(),
    ReadDataPage(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        backgroundColor: Colors.red[400],
        elevation: 2,
        currentIndex: _currentIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Resultados',
            backgroundColor: Colors.black
          ),
        ],
      ),
    );
  }
}
