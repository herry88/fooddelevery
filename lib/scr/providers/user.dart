import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddelevery/scr/helpers/orders.dart';
import 'package:fooddelevery/scr/helpers/user.dart';
import 'package:fooddelevery/scr/models/order.dart';
import 'package:fooddelevery/scr/models/products.dart';
import 'package:fooddelevery/scr/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  //public variable
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          "likedFood": [],
          "likedRestaurants": []
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async {
    print("Productnya adalah : ${product.toString()}");
    print("Quantity adalah: ${quantity.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      print("Cart Item Adalah: ${cart.toString()}");
      _userServicse.addToCart(userId: _user.uid, cartItem: cartItem);

      return true;
    } catch (e) {
      print("The error ${e.toString()}");
      return false;
    }
  }

  //get oRder
  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    print("Productnya adalah: ${cartItem.toString()}");
    try {
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("The error ${e.toString()}");
      return false;
    }
  }
}
