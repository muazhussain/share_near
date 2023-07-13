import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/views/demo-view/card_product.dart';

class TestProductView extends StatefulWidget {
  const TestProductView({super.key});

  @override
  _TestProductViewState createState() => _TestProductViewState();
}

class _TestProductViewState extends State<TestProductView> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _productStream;

  @override
  void initState() {
    super.initState();
    _productStream =
        FirebaseFirestore.instance.collection('Products').snapshots();
  }

  final int itemsPerRow = 3;
  final int widgetCount = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _productStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: (widgetCount / itemsPerRow).ceil(),
            itemBuilder: (context, index) {
              final startIndex = index * itemsPerRow;
              final endIndex = (startIndex + itemsPerRow) < widgetCount
                  ? (startIndex + itemsPerRow)
                  : widgetCount;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ...List.generate(
                      endIndex - startIndex,
                      (subIndex) {
                        final data = products[0].data();
                        final product = Product(
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

                        return DemoCard(product: product);
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
