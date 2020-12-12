import 'package:flutter/material.dart';
import 'package:fooddelevery/scr/helpers/screen_navigation.dart';
import 'package:fooddelevery/scr/helpers/style.dart';
import 'package:fooddelevery/scr/providers/app.dart';
import 'package:fooddelevery/scr/providers/product.dart';
import 'package:fooddelevery/scr/providers/restaurant.dart';
import 'package:fooddelevery/scr/screens/restaurant.dart';
import 'package:fooddelevery/scr/widgets/custom_text.dart';
import 'package:fooddelevery/scr/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomText(
          text: "Restaurants",
          size: 20.0,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: app.isLoading
          ? Container()
          : restaurantProvider.searchedRestaurants.length < 1
              ? new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Restaurant Tidak Ada",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 22.0,
                        ),
                      ],
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: restaurantProvider.searchedRestaurants.length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                      onTap: () async {
                        app.changeLoading();
                        await productProvider.loadProductsByRestaurant(
                            restaurantId: restaurantProvider
                                .searchedRestaurants[index].id);
                        app.changeLoading();
                        changeScreen(
                            context,
                            RestaurantScreen(
                              restaurantModel:
                                  restaurantProvider.searchedRestaurants[index],
                            ));
                      },
                      child: RestaurantWidget(
                        restaurant:
                            restaurantProvider.searchedRestaurants[index],
                      ),
                    );
                  }),
    );
  }
}
