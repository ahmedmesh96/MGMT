import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgmt/firebase_services/storage.dart';
import 'package:mgmt/models/user.dart';
import 'package:mgmt/widgets/snack_bar.dart';



class AuthMethods {
  register({
    required emailll,
    required passworddd,
    required context,
    required titleee,
    required nameee,
    required phoneNumber,
    required imgName,
    required imgPath,
    required salary,
    required birthday,
    required startedDate,
  }) async {
    String message = "ERROR => Not starting the code";
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
      message = "ERROR => Registered only";

      //_________________________________________________________________________

      String urlll = await getImgURL(
          imgName: imgName, imgPath: imgPath, folderName: 'UserProfileImg');

      //_________________________________________________________________________

      // firebase firestore (Database)
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection('userSSS');

      UserData userr = UserData(
          email: emailll,
          password: passworddd,
          title: titleee,
          name: nameee,
          phoneNumber: phoneNumber,
          profileImg: urlll,
          uid: credential.user!.uid,
          followers: [],
          following: [],
          pushToken: "",
          lastActive: time,
          isOnline: false,
          createdAt: time,
          about: "Hey, I'm using BLS!",
          admin: "No",
          birthday: birthday,
          salary: salary,
          startedDate: startedDate, 
          isReservationWebWork: 'Yes');

      users
          .doc(credential.user!.uid)
          .set(userr.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = 'Registered & User Added 2 DB';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }

  signIn({required emailll, required passworddd, required context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }
  }

  // functoin to get user details from Firestore (Database)
  Future<UserData> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('userSSS')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserData.convertSnap2Model(snap);
  }


  //---------********* Create New User ****--------------//

 






}
