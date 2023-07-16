import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_near/src/models/user_model.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/views/categories/categories_view.dart';
import 'package:share_near/src/views/home-view/home_view.dart';
import 'package:share_near/src/views/notifications/notifications_view.dart';
import 'package:share_near/src/views/user-profile/user_profile_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  Future<UserModel?> getUserByEmail(String email) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      return UserModel(
        email: data['email'],
        fullName: data['fullName'],
        phoneNumber: data['phoneNumber'],
        nidNumber: data['nidNumber'],
        districtName: data['districtName'],
        membership: data['membership'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        profileImage: data['profileImage'],
      );
    }
    return null;
  }

  Future<void> setLocationAndEmail() async {
    final User? user = Auth().currentUser;
    String email = user!.email ?? '';
    appUserEmail = email;
    UserModel? curUser = await getUserByEmail(email);
    appLatitude = curUser!.latitude;
    appLongitude = curUser.longitude;
    setState(() {});
  }

  @override
  void initState() {
    setLocationAndEmail();
    super.initState();
  }

  int _currentTab = 0;
  final List<Widget> _screens = const [
    HomeView(),
    CategoriesView(),
    NotificationsView(),
    UserProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: _screens[_currentTab],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        elevation: 2,
        selectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        unselectedItemColor: secondaryColor,
        showUnselectedLabels: true,
        currentIndex: _currentTab,
        onTap: (value) {
          _currentTab = value;
          setState(() {});
        },
      ),
    );
  }
}
