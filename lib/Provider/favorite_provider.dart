import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

//Toggele favorites status
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFromFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      await _addToFavorite(productId);
    }
    notifyListeners();
  }

//Check if the product is in favorites
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  // Add favorites to firestore
  Future<void> _addToFavorite(String productId) async {
    // Add to favorite
    try {
      await _firestore.collection('Favorite').doc(productId).set({
        'isFavorite':
            true, //Create new Favorite colection and add recipe as favorit in firestore
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //Remove Favorites from firestore
  Future<void> _removeFromFavorite(String productId) async {
    // Add to favorite
    try {
      await _firestore.collection('Favorite').doc(productId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //Load favoris from firestore
  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Favorite').get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  // Static method to access the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
