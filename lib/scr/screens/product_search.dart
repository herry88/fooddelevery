import 'package:flutter/material.dart';
import 'package:fooddelevery/scr/helpers/style.dart';
import 'package:fooddelevery/scr/providers/product.dart';
import 'package:fooddelevery/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<ProductProvider>(context);

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
      body: new Column(),
    );
  }
}
