import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/ui/screens/home/symptoms/symptoms_tab.dart';
import '../../../theme/my_theme.dart';
import 'home_tab/home_tab.dart';
import 'list_of_patients/patients_tab.dart';
import 'my_account/account_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.lightBlue,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newlySelectedIndex) {
          setState(() {
            selectedIndex = newlySelectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Color(0xFF97CADB),
              icon: ImageIcon(AssetImage('assets/images/home_tab.png')),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/symptoms_tab.png')),
              label: 'Symptoms'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/patients_tab.png')),
              label: 'Patients'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/account_tab.png')),
              label: 'account'),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    const HomeTab(),
    const SymptomsTab(),
    const PatientsTab(),
    const AccountTab(),
  ];
}
