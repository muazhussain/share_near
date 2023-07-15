import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/all-products/all_products_view.dart';
import 'package:share_near/src/views/home-view/components/cash_back_offer.dart';
import 'package:share_near/src/views/home-view/components/home_view_search_bar.dart';
import 'package:share_near/src/views/home-view/components/product_card.dart';
import 'package:share_near/src/views/home-view/components/section_title.dart';
import 'package:share_near/src/views/home-view/components/special_offers.dart';
import 'package:share_near/src/views/product-details/product_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _inProcess = false;
  List<Product> products = [];
  List<Product> reverseAllProduct = [];

  Future<List<Product>> getAllProducts() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Products').get();

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

  Future<void> fetchProducts() async {
    setState(() {});
    final data = await getAllProducts();
    print('length: $data.length');
    setState(() {
      products = data;
      reverseAllProduct = data.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return _inProcess
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: primaryColor,
              valueColor: AlwaysStoppedAnimation(
                Colors.green,
              ),
              strokeWidth: 5,
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              _inProcess = true;
              setState(() {});
              await fetchProducts();
              _inProcess = false;
              setState(() {});
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getScreenWidth(20),
                    ),
                    child: Column(
                      children: <Widget>[
                        littleGap,
                        HomeViewSearchBar(
                          onChanged: () {},
                        ),
                        littleGap,
                        const CashBackOffer(),
                        littleGap,
                        SectionTitle(
                          text: 'Trending Now',
                          press: () {},
                        ),
                        littleGap,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SpecialOffers(
                                category: 'Smartphone',
                                image: 'assets/images/phone banner.png',
                                press: () {},
                              ),
                              SpecialOffers(
                                category: 'Smartphone',
                                image: 'assets/images/phone banner.png',
                                press: () {},
                              ),
                            ],
                          ),
                        ),
                        littleGap,
                        SectionTitle(
                          text: 'Popular Products',
                          press: () {
                            allProductPage = products;
                            Get.to(
                              () => const AllProductsView(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.zoom,
                            );
                          },
                        ),
                        littleGap,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: products.isEmpty
                              ? const SizedBox(
                                  height: 0,
                                )
                              : Row(
                                  children: [
                                    ...List.generate(
                                      2,
                                      (index) => ProductCard(
                                        product: reverseAllProduct[index],
                                        onTap: () {
                                          curProduct = reverseAllProduct[index];
                                          Get.to(
                                            () => ProductDetailsView(
                                                product: curProduct),
                                            duration: const Duration(
                                                milliseconds: 700),
                                            transition: Transition.zoom,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        littleGap,
                        SectionTitle(
                          text: 'New Arrival',
                          press: () {
                            allProductPage = reverseAllProduct;
                            Get.to(
                              () => const AllProductsView(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.zoom,
                            );
                          },
                        ),
                        littleGap,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: products.isEmpty
                              ? const SizedBox(
                                  height: 0,
                                )
                              : Row(
                                  children: [
                                    ...List.generate(
                                      2,
                                      (index) => ProductCard(
                                        product: reverseAllProduct[index],
                                        onTap: () {
                                          curProduct = reverseAllProduct[index];
                                          Get.to(
                                            () => ProductDetailsView(
                                                product: curProduct),
                                            duration: const Duration(
                                                milliseconds: 700),
                                            transition: Transition.zoom,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
