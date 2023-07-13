import 'package:flutter/material.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';

class HomeViewSearchBar extends StatelessWidget {
  const HomeViewSearchBar({
    super.key,
    required this.onChanged,
  });

  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => onChanged,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search Product',
          prefixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
            vertical: getScreenWidth(9),
          ),
        ),
      ),
    );
  }
}
