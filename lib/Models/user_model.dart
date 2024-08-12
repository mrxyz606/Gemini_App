class UserModel {
  late String name;
  late String email;
  late String profilePicture;
  late String location;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.location,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    profilePicture = json["profilePicture"];
    location = json["location"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['location'] = location;
    return data;
  }

  UserModel clone() {
    return UserModel(name: name, email: email, profilePicture: profilePicture, location: location);
  }
}
