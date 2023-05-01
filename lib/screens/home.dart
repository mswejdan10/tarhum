import 'package:flutter/material.dart';
import 'package:medicare/screens/NavBar.dart';
import 'package:medicare/styles/colors.dart';
import 'package:medicare/tabs/HomeTab.dart';
import 'package:medicare/tabs/Messages.dart';
import 'package:medicare/tabs/clinics_Appointment.dart';
import 'package:medicare/tabs/doctors_Appointment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
  {'icon': Icons.question_answer_outlined, 'index': 2},
  {'icon': Icons.message, 'index': 3},
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void goToClinics() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void goToDoctors() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToClinics,
        onPressedScheduleCard2: goToDoctors,
      ),
      ScheduleTabClinics(),
      ScheduleTabDoctors(),
      MessagesTab(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Color(MyColors.primary),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          selectedItemColor: Color(MyColors.primary),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            for (var navigationBarItem in navigationBarItems)
              BottomNavigationBarItem(
                icon: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border(
                      top: _selectedIndex == navigationBarItem['index']
                          ? BorderSide(color: Color(MyColors.bg01), width: 5)
                          : BorderSide.none,
                    ),
                  ),
                  child: Icon(
                    navigationBarItem['icon'],
                    color: _selectedIndex == 0
                        ? Color(MyColors.bg01)
                        : Color(MyColors.bg02),
                  ),
                ),
                label: '',
              ),
          ],
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
            _selectedIndex = value;
          }),
        ),
      ),
    );
  }
}
