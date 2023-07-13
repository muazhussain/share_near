import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_near/src/models/notifications.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/models/user_model.dart';

class Data {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile(UserModel user) async {
    await _db.collection('Users').add(user.toJSON());
  }

  Future<void> uploadNewProduct(Product product) async {
    await _db.collection('Products').add(product.toJSON());
  }

  Future<void> uploadNotification(Notifications notification) async {
    await _db.collection('Notifications').add(notification.toJSON());
  }
}
