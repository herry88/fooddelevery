import 'package:flutter/material.dart';
import 'package:fooddelevery/scr/helpers/style.dart';
import 'package:fooddelevery/scr/models/order.dart';
import 'package:fooddelevery/scr/providers/app.dart';
import 'package:fooddelevery/scr/providers/user.dart';
import 'package:fooddelevery/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Orders",
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\Rp ${_order.total}",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description),
              subtitle: Text(
                DateTime.fromMillisecondsSinceEpoch(_order.createdAt)
                    .toString(),
              ),
              trailing: CustomText(
                text: _order.status,
                color: green,
              ),
            );
          }),
    );
  }
}
