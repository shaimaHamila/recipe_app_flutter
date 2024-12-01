import 'package:cloud_firestore/cloud_firestore.dart';
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
  String category = 'All';
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection('Category');

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerParts(),
                    mySearchBar(),
                    //For banner
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // For categories
                    categoryList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> categoryList() {
    return StreamBuilder(
        stream: categoriesItems.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          // If snapshot has data then show it otherwise the progress bar
          if (streamSnapshot.hasData) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      streamSnapshot.data!.docs.length,
                      (index) => GestureDetector(
                            onTap: () {
                              //If the data is available it will works
                              setState(() {
                                category =
                                    streamSnapshot.data!.docs[index]['name'];
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: category ==
                                          streamSnapshot.data!.docs[index]
                                              ['name']
                                      ? kprimaryColor
                                      : Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                margin: const EdgeInsets.only(right: 18),
                                child: Text(
                                  streamSnapshot.data!.docs[index]['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: category ==
                                            streamSnapshot.data!.docs[index]
                                                ['name']
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                  ),
                                )),
                          )),
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "What are \ncooking todey?",
            style:
                TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1),
          ),
        ),
        const Spacer(),
        //notification btn
        MyIconButton(icon: Iconsax.notification, pressed: () {})
      ],
    );
  }
}
