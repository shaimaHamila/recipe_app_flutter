import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app_flutter/Utils/constants.dart';
import 'package:recipe_app_flutter/Widget/banner.dart';
import 'package:recipe_app_flutter/Widget/my_icon_button.dart';

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  State<MyAppHomeScreen> createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State<MyAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  headerParts(),
                  mySearchBar(),
                  //For banner
                  const BannerToExplore(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Iconsax.search_normal),
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "Search any recipe",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        const Text(
          "What are \ncooking todey?",
          style:
              TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1),
        ),
        const Spacer(),
        //notification btn
        MyIconButton(icon: Iconsax.notification, pressed: () {})
      ],
    );
  }
}
