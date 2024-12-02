import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app_flutter/Utils/constants.dart';
import 'package:recipe_app_flutter/Widget/food_items_display.dart';
import 'package:recipe_app_flutter/Widget/my_icon_button.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  //Get categories from firebase
  final CollectionReference recipes =
      FirebaseFirestore.instance.collection('Recipe');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          backgroundColor: kBackgroundColor,
          automaticallyImplyLeading: false, // It removes the appbar back btn
          elevation: 0,
          actions: [
            const SizedBox(width: 15),
            MyIconButton(
              icon: Icons.arrow_back_ios_new,
              pressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            const Text(
              "Quick & Easy",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            MyIconButton(icon: Iconsax.notification, pressed: () {}),
            const SizedBox(width: 15),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
                stream: recipes.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  // If snapshot has data then show it otherwise the progress bar
                  if (streamSnapshot.hasData) {
                    return GridView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.78),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot recipe =
                            streamSnapshot.data!.docs[index];
                        return Column(
                          children: [
                            FoodItemsDisplay(recipe: recipe),
                            Row(
                              children: [
                                const Icon(Iconsax.star1,
                                    color: Colors.amberAccent),
                                const SizedBox(width: 5),
                                Text(
                                  recipe['rating'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text("/5"),
                                const SizedBox(width: 5),
                                Text(
                                  "${recipe['review'.toString()]} Reviews",
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
