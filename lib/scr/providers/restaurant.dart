import 'package:flutter/material.dart';
import '../helpers/restaurant.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier{
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider.initialize(){
    _loadRestaurants();
    // search(name : "bandung");
  }

  _loadRestaurants()async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantId}) async{
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();

  }

  Future search({String name}) async{
    searchedRestaurants = await _restaurantServices.searchRestaurants(restaurantName: name);
    print("Restoran ada : ${searchedRestaurants.length}");
    notifyListeners();
  }


}