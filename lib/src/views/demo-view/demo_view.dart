// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:share_near/src/models/product_model.dart';

// class TestProductView extends StatefulWidget {
//   const TestProductView({super.key});

//   @override
//   _TestProductViewState createState() => _TestProductViewState();
// }

// class _TestProductViewState extends State<TestProductView> {
//   late Stream<QuerySnapshot<Map<String, dynamic>>> _productStream;

//   @override
//   void initState() {
//     super.initState();
//     getAllProducts();
//   }

//   final int itemsPerRow = 3;
//   final int widgetCount = 9;

//   Future<List<Product>> getAllProducts() async {
//     final QuerySnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection('Products').get();

//     final List<Product> products = snapshot.docs.map((doc) {
//       final data = doc.data();
//       return Product(
//         title: data['title'],
//         description: data['description'],
//         rentCost: data['rentCost'],
//         productPrice: data['productPrice'],
//         rating: data['rating'],
//         owner: data['owner'],
//         latitude: data['latitude'],
//         longitude: data['longitude'],
//         rentDuration: data['rentDuration'],
//         images: List<String>.from(data['images']),
//         currentRenter: data['currentRenter'],
//       );
//     }).toList();

//     return products;
//   }

//   List<Product> products = [];

//   Future<void> fetchProducts() async {
//     final data = await getAllProducts();
//     print('length: $products.length');
//     setState(() {
//       products = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (BuildContext context, int index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.title),
//             subtitle: Text(product.description),
//             trailing: Text('Price: \$${product.productPrice}'),
//             onTap: () {
//               // Handle product selection
//               // For example, navigate to a product detail screen
//               // using Navigator.push()
//             },
//           );
//         },
//       ),
//     );
//   }
// }
