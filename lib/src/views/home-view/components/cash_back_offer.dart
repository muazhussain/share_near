import 'package:flutter/material.dart';
import 'package:share_near/src/utils/size_config.dart';

class CashBackOffer extends StatelessWidget {
  const CashBackOffer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getScreenWidth(20),
        vertical: getScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            const TextSpan(text: 'New Customer Surprise\n'),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: getScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
