// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class UserImage extends StatefulWidget {
//   final Function(String imageURL) onFileChanged;

//   const UserImage({super.key, required this.onFileChanged});

//   @override
//   State<UserImage> createState() => _UserImageState();
// }

// class _UserImageState extends State<UserImage> {
//   String? imageURL;
//   final String userName;

//   final ImagePicker _picker = ImagePicker();

//   _UserImageState(this.userName);

//   Future<void> _pickImage() async {
//     final pickedImage = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//     if (pickedImage == null) {
//       return;
//     }

//     var image = File(pickedImage.path);

//     var file = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//     );
//     if (file == null) {
//       return;
//     }
//     // file = await compressImage(file.path, 35, userName);
//   }

//   // Future<File> compressImage(String path, int quality, String userName) async {
//   //   final String newPath = p.join(userName, p.extension(path));
//   //   final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
//   //       quality: quality);

//   //   return File(result);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
