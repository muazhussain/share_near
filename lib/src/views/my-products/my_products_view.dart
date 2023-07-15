import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/home-view/components/product_card.dart';
import 'package:share_near/src/views/product-details/product_details_view.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> {
  Future<List<Product>> getProductsByEmail(String email) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Products')
        .where('owner', isEqualTo: email)
        .get();

    final List<Product> products = snapshot.docs.map((doc) {
      final data = doc.data();
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
        images: List<String>.from(data['images']),
        currentRenter: data['currentRenter'],
      );
    }).toList();

    return products;
  }

  List<Product> products = [];
  Future<void> fetchProduct() async {
    final User? nuser = Auth().currentUser;
    String email = nuser!.email ?? '';
    products = await getProductsByEmail(email);
    print(products.length);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              smallerGap,
              ...List.generate(
                products.length,
                (index) => ProductCard(
                  product: products[index],
                  onTap: () {
                    curProduct = products[index];
                    Get.to(
                      () => ProductDetailsView(product: curProduct!),
                      duration: const Duration(milliseconds: 700),
                      transition: Transition.zoom,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
