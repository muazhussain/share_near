class UserModel {
  final String email;
  final String fullName;
  final String phoneNumber;
  final String nidNumber;
  final String districtName;
  final String membership;
  final double latitude;
  final double longitude;
  final String profileImage;

  const UserModel({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.nidNumber,
    required this.districtName,
    required this.membership,
    required this.latitude,
    required this.longitude,
    required this.profileImage,
  });

  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nidNumber': nidNumber,
      'districtName': districtName,
      'membership': membership,
      'latitude': latitude,
      'longitude': longitude,
      'profileImage': profileImage,
    };
  }
}
