import 'package:flutter/material.dart';
import 'package:share_near/src/utils/constants.dart';

class ImagePickereButton extends StatelessWidget {
  const ImagePickereButton({
    super.key,
    required this.text,
    required this.press,
  });

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: press,
      child: Text(text),
    );
  }
}
