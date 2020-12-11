import 'package:flutter/material.dart';
import '../helpers/restaurant.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier{
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider.initialize(){
    _loadRestaurants();
  }

  _loadRestaurants()async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantId}) async{
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();

  }


}