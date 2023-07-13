import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/checkout/checkout_view.dart';
import 'package:share_near/src/views/global-components/default_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int selectedImage = 0;
  String distance = '';

  Future<void> getDistance() async {
    distance = calculateDistance(
      appLatitude ?? widget.product.latitude - 0.1,
      appLongitude ?? widget.product.longitude - 0.1,
      widget.product.latitude,
      widget.product.longitude,
    );
  }

  @override
  void initState() {
    getDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: BackButton(
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(
                  widget.product.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset('assets/icons/Star Icon.svg'),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: getScreenWidth(238),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(widget.product.images![selectedImage]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      demoProducts[0].images?.length ?? 0,
                      (index) => smallPreviewBuild(index),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: getScreenWidth(20)),
                  padding: EdgeInsets.only(top: getScreenWidth(20)),
                  width: double.infinity,
                  height: getScreenHeight(400),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          widget.product.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        smallerGap,
                        SingleChildScrollView(
                          child: Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: getScreenHeight(80),
                                  child: Text(
                                    widget.product.description,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        littleGap,
                        Text('Rent Duration: ${widget.product.rentDuration}'),
                        littleGap,
                        Text('Rent Cost: ${widget.product.rentCost}'),
                        smallerGap,
                        Text('Distance: $distance km'),
                        smallerGap,
                        DefaultButton(
                          widget: const Text('Request to rent'),
                          press: () {
                            Get.to(
                              () => const CheckoutView(),
                              duration: const Duration(milliseconds: 700),
                              transition: Transition.rightToLeft,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector smallPreviewBuild(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(
          getScreenHeight(8),
        ),
        margin: EdgeInsets.only(right: getScreenWidth(15)),
        height: getScreenWidth(48),
        width: getScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImage == index ? primaryColor : Colors.transparent,
          ),
        ),
        child: Image.network(widget.product.images![index]),
      ),
    );
  }
}
