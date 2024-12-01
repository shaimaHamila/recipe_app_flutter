import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app_flutter/Utils/constants.dart';
import 'package:recipe_app_flutter/Views/my_app_home_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

// BuildContext provides information about the widget's position in the widget tree,
//enabling widgets to access inherited data and interact with the widget hierarchy.
class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  //late allows you to declare a variable without initializing it immediately.
  //The variable doesn’t occupy memory or get initialized until it's used
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      const MyAppHomeScreen(),
      navBarPage(Iconsax.heart5),
      navBarPage(Iconsax.calendar5),
      navBarPage(Iconsax.setting_21),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 24,
        currentIndex: selectedIndex,
        selectedItemColor: kprimaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: kprimaryColor),
        unselectedLabelStyle:
            (const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),
              label: 'Meal Plan'),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2),
              label: 'Setting'),
        ],
      ),
      body: page[selectedIndex],
    );
  }

  navBarPage(iconName) {
    return Center(child: Icon(iconName, size: 100, color: kprimaryColor));
  }
}
