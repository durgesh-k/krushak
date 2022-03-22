import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krushak/main_screens/agri_info.dart';
import 'package:krushak/main_screens/home_screen.dart';
import 'package:krushak/main_screens/market.dart';
import 'package:krushak/main_screens/schemes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [HomeScreen(), Market(), Schemes(), AgriInfo()];
  List<String> titles = ['Home', 'Market', 'Schemes', 'Agri Info'];
  int? _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          titles[_selectedIndex!],
          style: TextStyle(fontFamily: 'SemiBold', color: Colors.black),
        ),
      ),
      body: PageView.builder(itemBuilder: (cts, index) {
        return screens[_selectedIndex!];
      }),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: AnimatedContainer(
          duration: Duration(microseconds: 300),
          child: BottomNavigationBar(
            iconSize: 24,
            backgroundColor: Colors.grey.shade50,
            elevation: 0,
            selectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex!,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home.svg'),
                activeIcon: SvgPicture.asset('assets/home1.svg'),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: new SvgPicture.asset('assets/market.svg'),
                activeIcon: SvgPicture.asset('assets/market1.svg'),
                label: '   ',
              ),
              BottomNavigationBarItem(
                icon: new SvgPicture.asset('assets/schemes.svg'),
                activeIcon: SvgPicture.asset('assets/schemes1.svg'),
                label: '   ',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/buildings.svg'),
                activeIcon: SvgPicture.asset('assets/buildings1.svg'),
                label: ' ',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
