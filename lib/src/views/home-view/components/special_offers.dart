import 'package:flutter/material.dart';
import 'package:share_near/src/utils/size_config.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key,
    required this.category,
    required this.image,
    required this.press,
  });

  final String category;
  final String image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: getScreenWidth(20),
      ),
      child: SizedBox(
        height: getScreenWidth(100),
        width: getScreenWidth(242),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF343434).withOpacity(0.4),
                      const Color(0xFF343434).withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getScreenWidth(15),
                  vertical: getScreenWidth(10),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getScreenWidth(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
