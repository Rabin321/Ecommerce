class UserDetailsModel {
  final String name;
  // final String email;
  final String address;
  UserDetailsModel({
    required this.name,
    // required this.email,
    required this.address,
  });

  Map<String, dynamic> getJson() => {
        "name": name,
        // "email": email,
        "address": address,
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], address: json["address"]);
  }
}
