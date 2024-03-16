import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String password;
  String email;
  String title;
  String phoneNumber;
  String name;
  String profileImg;
  String uid;
  List followers;
  List following;
  String pushToken;
  String lastActive;
  bool isOnline;
  String createdAt;
  String about;
  String admin;
  String salary;
  String startedDate;
  String birthday;
  String isReservationWebWork;

  UserData(
      {required this.email,
      required this.password,
      required this.title,
      required this.phoneNumber,
      required this.profileImg,
      required this.uid,
      required this.followers,
      required this.following,
      required this.name,
      required this.pushToken,
      required this.lastActive,
      required this.isOnline,
      required this.createdAt,
      required this.about,
      required this.admin,
      required this.birthday,
      required this.salary,
      required this.startedDate,
      required this.isReservationWebWork
      });

// To convert the UserData(Data type) to Map<String, object>
  Map<String, dynamic> convert2Map() {
    return {
      "password": password,
      "email": email,
      "title": title,
      "phoneNumber": phoneNumber,
      "name": name,
      "profileImg": profileImg,
      "uid": uid,
      "followers": [],
      "following": [],
      "pushToken": pushToken,
      "lastActive": lastActive,
      "isOnline": isOnline,
      "createdAt": createdAt,
      "about": about,
      "admin": admin,
      "salary": salary,
      "startedDate": startedDate,
      "birthday": birthday,
      "isReservationWebWork":isReservationWebWork
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
        password: snapshot["password"],
        email: snapshot["email"],
        title: snapshot["title"],
        name: snapshot["name"],
        phoneNumber: snapshot["phoneNumber"],
        profileImg: snapshot["profileImg"],
        uid: snapshot["uid"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        pushToken: snapshot["pushToken"],
        lastActive: snapshot["lastActive"],
        isOnline: snapshot["isOnline"],
        createdAt: snapshot["createdAt"],
        about: snapshot["about"],
        admin: snapshot["admin"], 
        birthday: snapshot["birthday"],
        startedDate: snapshot["startedDate"],
        salary: snapshot["salary"],
        isReservationWebWork:snapshot["isReservationWebWork"],
        
        );
  }

  Map<String, dynamic> toJson() {
    final dataa = <String, dynamic>{};
    dataa['profileImg'] = profileImg;
    dataa['about'] = about;
    dataa['name'] = name;
    dataa['created_at'] = createdAt;
    dataa['is_online'] = isOnline;
    dataa['uid'] = uid;
    dataa['last_active'] = lastActive;
    dataa['email'] = email;
    dataa['push_token'] = pushToken;
    dataa['password'] = password;
    dataa['title'] = title;
    dataa['phoneNumber'] = phoneNumber;
    dataa['followers'] = followers;
    dataa['following'] = following;
    dataa['admin'] = admin;
    dataa["salary"] = salary;
    dataa['startedDate']= startedDate;
    dataa["birthday"] = birthday;
    dataa['isReservationWebWork']= isReservationWebWork;

    return dataa;
  }
}
