import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_near/src/utils/size_config.dart';

class TextFormSuffixIcon extends StatelessWidget {
  const TextFormSuffixIcon({
    super.key,
    required this.svgIcon,
  });

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getScreenWidth(20),
        getScreenWidth(20),
        getScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getScreenHeight(18),
      ),
    );
  }
}
