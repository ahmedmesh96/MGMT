import 'package:flutter/cupertino.dart';
import 'package:mgmt/firebase_services/auth.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
}

// class PostProvider with ChangeNotifier {
//   PostData? _postDataa;
//   PostData? get getPost => _postDataa;

//   refreshUser() async {
//     PostData postDataa = await AuthMethods().getUserDetails();
//     _postDataa = postDataa;
//     notifyListeners();
//   }
// }
