import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/home-view/components/product_card.dart';
import 'package:share_near/src/views/product-details/product_details_view.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key});

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Products',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ...List.generate(
                  allProductPage.length,
                  (index) => ProductCard(
                    product: allProductPage[index],
                    onTap: () {
                      curProduct = allProductPage[index];
                      Get.to(
                        () =>  ProductDetailsView(product: curProduct!,),
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
      ),
    );
  }
}
