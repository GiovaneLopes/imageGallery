import 'package:firebase_database/firebase_database.dart';
import 'package:imageGallery/features/auth/domain/entities/user.dart';
import 'package:meta/meta.dart';

class UserModel extends User {
  UserModel({@required name, @required email})
      : super(name: name, email: email);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (name != null) json['name'] = name;
    if (email != null) json['email'] = email;

    return json;
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;
    return UserModel(name: json['name'], email: json['email']);
  }

  factory UserModel.fromEntity(User user) {
    if (user == null) return null;
    return UserModel(
      name: user.name,
      email: user.email,
    );
  }

  factory UserModel.fromDataSnapshot(DataSnapshot dataSnapshot) {
    if (dataSnapshot == null) return null;

    Map<dynamic, dynamic> userMap = dataSnapshot.value;
    userMap['id'] = dataSnapshot.key;

    return UserModel.fromJson(userMap);
  }
}
