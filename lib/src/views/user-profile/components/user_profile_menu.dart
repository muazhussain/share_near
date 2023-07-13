import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_near/src/utils/constants.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({
    super.key,
    required this.leadingIcon,
    required this.text,
    required this.press,
  });

  final String leadingIcon;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: const Color(0xFFE8EBF4),
        leading: SvgPicture.asset(
          leadingIcon,
          width: 22,
          // ignore: deprecated_member_use
          color: primaryColor,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
