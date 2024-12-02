import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app_flutter/Provider/favorite_provider.dart';
import 'package:recipe_app_flutter/Utils/constants.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteRecipes = provider.favorites;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Favorites",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: favoriteRecipes.isEmpty
            ? const Center(
                child: Text(
                "No Favorites yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ))
            : ListView.builder(
                itemCount: favoriteRecipes.length,
                itemBuilder: (context, index) {
                  String favorite = favoriteRecipes[index];
                  return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("Recipe")
                          .doc(favorite)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: Text("Error loading favorites"));
                        }
                        // Get the favorite recipe
                        var favoriteRecipe = snapshot.data!;
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            favoriteRecipe['image'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favoriteRecipe['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Iconsax.flash_1,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              "${favoriteRecipe['cal']} Cal",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Text(
                                              " · ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Icon(
                                              Iconsax.clock,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "${favoriteRecipe['time']} Min",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // for delete button
                            Positioned(
                              top: 50,
                              right: 35,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    provider.toggleFavorite(favoriteRecipe);
                                  });
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ));
  }
}
