import 'package:flutter/material.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Products',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            ListTile(
              // leading: CircleAvatar(
              //   backgroundColor: secondaryColor,
              //   child: Image.asset('assets/images/ps4_console_white_1.png'),
              // ),
              title: Text(demoProducts[0].title),
              subtitle: const Text(
                'Rented on: 2023-12-12',
                style: TextStyle(color: primaryColor),
              ),
              trailing: const Text('4\nDays'),
            );
            return null;
          },
        ),
      ),
    );
  }
}
