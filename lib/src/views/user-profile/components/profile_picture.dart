import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_near/src/models/user_model.dart';
import 'package:share_near/src/services/auth.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
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

  String? profileImage;
  UserModel? user;
  Future<void> fetchUser() async {
    final User? nuser = Auth().currentUser;
    String email = nuser!.email ?? ''; // Specify the email to fetch the user
    user = await getUserByEmail(email);
    setState(() {});
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.profileImage),
                ),
                Positioned(
                  right: -12,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
