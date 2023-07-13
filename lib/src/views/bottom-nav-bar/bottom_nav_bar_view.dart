import 'package:flutter/material.dart';
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
