import 'package:flutter/material.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          right: getScreenWidth(10),
        ),
        child: Column(
          children: [
            SizedBox(
              width: getScreenWidth(140),
              child: AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(
                    getScreenWidth(20),
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(product.images![0]),
                ),
              ),
            ),
            SizedBox(
              width: getScreenWidth(140),
              child: Column(
                children: [
                  Text(
                    '${product.title}\n',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    '${product.rentCost}',
                    style: TextStyle(
                      fontSize: getScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
