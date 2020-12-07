import 'package:flutter/material.dart';

enum SearchBy{PRODUCTS, RESTAURANTS}

class AppProvider with ChangeNotifier{
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filterBy  = "Products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

}