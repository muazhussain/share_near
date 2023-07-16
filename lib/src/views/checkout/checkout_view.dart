import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/models/notifications.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/services/data.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/bottom-nav-bar/bottom_nav_bar_view.dart';
import 'package:share_near/src/views/global-components/default_button.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Future<void> updateProductCurrentRenter(
      String title, String currentRenter) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Products')
        .where('title', isEqualTo: title)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(docId)
          .update({'currentRenter': currentRenter});
    }
  }

  Future<void> sendNotifications() async {
    final User? user = Auth().currentUser;
    await updateProductCurrentRenter(curProduct!.title, user!.email ?? '');
    final time = DateTime.now();
    final notification = Notifications(
      user: user.email ?? '',
      productName: curProduct!.title,
      date: '${time.day}-${time.month}-${time.year}',
      receiver: curProduct!.owner,
    );
    await Data().uploadNotification(notification);
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            smallerGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: getScreenWidth(88),
                  child: AspectRatio(
                    aspectRatio: .88,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(curProduct!.images![0]),
                    ),
                  ),
                ),
                SizedBox(
                  width: getScreenWidth(20),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      curProduct!.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '\n${curProduct!.rentCost}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            biggerGap,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rent Cost: ${curProduct!.rentCost}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                smallerGap,
                Text(
                  'Insurance Fee: ${curProduct!.productPrice * 0.1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                smallerGap,
                Text(
                  'Total: ${curProduct!.productPrice * 0.1 + curProduct!.rentCost}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                biggerGap,
                DefaultButton(
                  press: () async {
                    _isProcessing = true;
                    setState(() {});
                    await sendNotifications().whenComplete(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product is on your way'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    });
                    _isProcessing = false;
                    setState(() {});
                    Get.off(
                      () => const BottomNavBarView(),
                      duration: const Duration(milliseconds: 700),
                      transition: Transition.zoom,
                    );
                  },
                  widget: _isProcessing
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: getScreenWidth(3),
                        )
                      : const Text('Proceed to pay'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
