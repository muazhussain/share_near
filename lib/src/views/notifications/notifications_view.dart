import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_near/src/models/notifications.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  Future<List<Notifications>> getNotificationsByReceiver(
      String receiver) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Notifications')
        .where('receiver', isEqualTo: receiver)
        .get();

    final List<Notifications> notifications = snapshot.docs.map((doc) {
      final data = doc.data();
      return Notifications(
        user: data['user'],
        productName: data['productName'],
        date: data['date'],
        receiver: data['receiver'],
      );
    }).toList();

    return notifications;
  }

  List<Notifications> notifications = [];

  void fetchNotifications() async {
    final User? nuser = Auth().currentUser;
    final String receiver = nuser!.email ?? '';
    notifications = await getNotificationsByReceiver(receiver);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              smallerGap,
              ...List.generate(
                notifications.length,
                (index) => ListTile(
                  title: Text(
                      '${notifications[index].user} rented ${notifications[index].productName}'),
                  subtitle: Text(notifications[index].date),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
