import 'package:flutter/material.dart';
import 'package:share_near/src/utils/constants.dart';

class RentedProductView extends StatefulWidget {
  const RentedProductView({super.key});

  @override
  State<RentedProductView> createState() => _RentedProductViewState();
}

class _RentedProductViewState extends State<RentedProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rented Products',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: <Widget>[
          biggerGap,
          const ListTile(
            title: Text('Product Name'),
            leading: Icon(Icons.production_quantity_limits),
            subtitle: Text('2023-12-30'),
            trailing: Text('4 Days'),
          ),
        ],
      ),
    );
  }
}
