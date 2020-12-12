import 'package:flutter/material.dart';
import 'package:fooddelevery/scr/helpers/screen_navigation.dart';
import 'package:fooddelevery/scr/helpers/style.dart';
import 'package:fooddelevery/scr/providers/product.dart';
import 'package:fooddelevery/scr/screens/details.dart';
import 'package:fooddelevery/scr/widgets/custom_text.dart';
import 'package:fooddelevery/scr/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
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
          text: "Product",
          size: 20.0,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: grey, size: 30.0),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Product tidak ada",
                      color: grey,
                      weight: FontWeight.w300,
                      size: 22.0,
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () async {
                    changeScreen(
                      context,
                      Details(
                        product: productProvider.productsSearched[index],
                      ),
                    );
                  },
                  child: ProductWidget(
                    product: productProvider.productsSearched[index],
                  ),
                );
              },
            ),
    );
  }
}
