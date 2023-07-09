class UserModel {
  final String email;
  final String fullName;
  final String phoneNumber;
  final String nidNumber;
  final String districtName;
  final String profileImage;

  const UserModel({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.nidNumber,
    required this.districtName,
    required this.profileImage,
  });

  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nidNumber': nidNumber,
      'districtName' : districtName,
      'profileImage' : profileImage,
    };
  }
}
