// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class Image {
//   final Reference _storageRef = FirebaseStorage.instance.ref();

//   uploadProfileImage(String imageName, XFile image) async {
//     final imageRef = _storageRef.child('/profilePicture');
//     Reference imageToUpload = imageRef.child(imageName);
//     await imageToUpload.putFile(File(image.path));
//   }
// }
