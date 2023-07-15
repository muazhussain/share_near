import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> {
  Future<Product?> getProductByEmail(String email) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Products')
        .where('owner', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      return Product(
          title: data['title'],
          description: data['description'],
          rentCost: data['rentCost'],
          productPrice: data['productPrice'],
          rating: data['rating'],
          owner: data['owner'],
          latitude: data['latitude'],
          longitude: data['longitude'],
          rentDuration: data['rentDuration'],
          images: data['images']);
    }
    return null;
  }

  Product? product;
  Future<void> fetchProduct() async {
    final User? nuser = Auth().currentUser;
    String email = nuser!.email ?? '';
    product = await getProductByEmail(email);
    setState(() {});
  }

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
