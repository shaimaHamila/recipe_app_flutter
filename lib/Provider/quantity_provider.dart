import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  int _quantity = 1;
  List<double> _baseIngredientAmounts = [];

  int get quantity => _quantity;

  //Set initial ingredient amounts
  void setBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts = amounts;
  }

  //Update ingredient amounts based on the quantity
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map((amount) => (amount * _quantity).toStringAsFixed(1))
        .toList();
  }

//Increment quantity
  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

// Decrement quantity
  void decreaseQuanity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}
