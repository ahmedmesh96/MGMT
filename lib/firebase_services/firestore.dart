import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mgmt/firebase_services/storage.dart';
import 'package:mgmt/generated/l10n.dart';
import 'package:mgmt/models/menu_item.dart';
import 'package:mgmt/models/reservation.dart';
import 'package:mgmt/widgets/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';


import 'package:uuid/uuid.dart';
class FireStoreMethods {
  final ScreenshotController screenshotController = ScreenshotController();
  Future<void> captureAndSaveImage ()async{
    final Uint8List? uint8list = await screenshotController.capture();
    if(uint8list !=null){
      final PermissionStatus status = await Permission.storage.request();
      if(status.isGranted){
        final result = await ImageGallerySaver.saveImage(uint8list);
        if (result['isSuccess']) {
          print("Image Saved To Gallery");
          
        }
        else {
          print("Failed to save image: ${result}");
        }

      }
      else {
        print("Permission to access storage denied");
      }
    }
  }

Future<String> addMainCollection({required name,
required nameSubCollection,
required uid,

        required fullName,
      required phoneNumber,
      required email,
      required reservationOccasion,
      required reservationDate,
      required reservationTime,
      required guestsCount,
      required requests,
      required tableNo,
      required reservationID,
      required collectionReference,
      required newReservation, 
      required context, 
      required confirme, 
      required startTime,
      required archive,  })async{

  CollectionReference mainCollection = FirebaseFirestore.instance.collection("Reservations").doc().collection("ConfirmeReservations");
   var result =   await mainCollection.add({

    "name": name


  });
  await addSubCollection(

    fullName: fullName, 
        phoneNumber: phoneNumber, 
        email: email, 
        reservationOccasion: reservationOccasion, 
        uid: uid, 
        reservationDate: reservationDate,
        reservationTime: reservationTime, 
        guestsCount: guestsCount, 
        requests: requests, 
        tableNo: tableNo,
         reservationID: reservationID, 
         newReservation: newReservation, 
         confirme: confirme, 
         archive: archive,
     startTime: startTime, 
     id: result.id, 
     nameSubCollection: nameSubCollection, 
     context: context, 
  

  );
  return 'Created';

}

Future<String?> addSubCollection ({required id, 
required nameSubCollection,
required uid,
        required fullName,
      required phoneNumber,
      required email,
      required reservationOccasion,
      required reservationDate,
      required reservationTime,
      required guestsCount,
      required requests,
      required tableNo,
      required reservationID,
   
      required newReservation, 
      required context, 
      required confirme, 
      required startTime,
      required archive, 

})async{
  CollectionReference subCollection = FirebaseFirestore.instance.collection("Reservations");
  subCollection.doc(id).collection(nameSubCollection).add({
    "fullName": fullName, 
        "phoneNumber": phoneNumber, 
        "email": email, 
        "reservationOccasion": reservationOccasion, 
        "uid": uid, 
        "reservationDate": reservationDate,
        "reservationTime": reservationTime, 
        "guestsCount": guestsCount, 
        "requests": requests, 
        "isCame": 'No', 
        "isSendCart": 'Yes', 
        "isDontCame": 'No',
        "tableNo": tableNo,
         "reservationID": reservationID, 
         "newReservation": newReservation, 
         "confirme": confirme, 
         "archive": archive,
         "processTime": DateTime.now(), 
         "startTime": startTime,

  });



}
  


  //--------------upload subcollection-------------//
  uploadReservationSubCollection(
      {
        required uid,
        required fullName,
      required phoneNumber,
      required email,
      required reservationOccasion,
      required reservationDate,
      required reservationTime,
      required guestsCount,
      required requests,
      required tableNo,
      required reservationID,
      required collectionReference,
      required newReservation, 
      required context, 
      required confirme, 
      required startTime,
      required archive, 
   }) async {
    String message = "ERROR => Not starting the code";
    // print(imgName);
     

    try {
    
      CollectionReference posts =  FirebaseFirestore.instance.collection("Reservations").doc('22222').collection("ConfirmeReservations");
      
      String newId = const Uuid().v1();

      ReservationSubCollection postt = ReservationSubCollection(
 
        uid: uid, 
        reservationDate: reservationDate,

         reservationID: reservationID, 
    
         
          );

      posts
          .doc(reservationID)
          .set(postt.convert2Map())
          .then((value) => print("done...."))
          .catchError((error) => print("Failed to post: $error"));

      message = 'Posted successfully';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                content: Text(
                  S.of(context).thanks,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: "Brando-Regular"),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        },
      );

     
  
  }

  //-----------------------











  //-------------------


  
  
  
  uploadReservation(
      {
        required uid,
        required fullName,
      required phoneNumber,
      required email,
      required reservationOccasion,
      required reservationDate,
      required reservationTime,
      required guestsCount,
      required requests,
      required tableNo,
      required reservationID,
      required collectionReference,
      required collectionReferenceID,
      required newReservation, 
      required context, 
      required confirme, 
      required startTime,
      required archive, 
      required isCame, 
      required isDontCame
   }) async {
    String message = "ERROR => Not starting the code";
    // print(imgName);
     

    try {
    
      CollectionReference posts =  FirebaseFirestore.instance.collection("Reservations").doc(collectionReferenceID).collection(collectionReference);
      
      String newId = const Uuid().v1();

      ReservationData postt = ReservationData(
        fullName: fullName, 
        phoneNumber: phoneNumber, 
        email: email, 
        reservationOccasion: reservationOccasion, 
        uid: uid, 
        reservationDate: reservationDate,
        reservationTime: reservationTime, 
        guestsCount: guestsCount, 
        requests: requests, 
        isCame: isCame, 
        isSendCart: 'Yes', 
        isDontCame: isDontCame,
        tableNo: tableNo,
         reservationID: reservationID, 
         newReservation: newReservation, 
         confirme: confirme, 
         archive: archive,
         processTime: DateTime.now(), startTime: startTime, 
         
          );

      posts
          .doc(reservationID)
          .set(postt.convert2Map())
          .then((value) => print("done...."))
          .catchError((error) => print("Failed to post: $error"));

      message = 'Posted successfully';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                content: Text(
                  S.of(context).thanks,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: "Brando-Regular"),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        },
      );

     
  
  }




  //-------------Upload Menu -----------------//
  uploadMenu(
      {
        required imgName,
      required imgPath,
      required nameInArabic,
      required nameInEnglish,
      required nameInTurkish,
      required nameInKurkish,
      required price,
      required sequence,
      required code,
      required descriptionInArabic,
      required descriptionInEnglish,
      required descriptionInTurkish,
      required descriptionInKurkish,
      required classs,
   
      required context, 
   }) async {
    String message = "ERROR => Not starting the code";
    print(imgName);
    try {
      //_________________________________________________________________________

      String urlll =  await getImgURL(
              imgName: imgName,
              imgPath: imgPath,
              folderName: 'imgPosts/${FirebaseAuth.instance.currentUser!.uid}');

      //_________________________________________________________________________

      // firebase firestore (Database)
      CollectionReference posts =  FirebaseFirestore.instance.collection(classs);

      String newId = const Uuid().v1();

      MenuItem postt = MenuItem(
          // datePublished: DateTime.now(),
          
          imgPost: urlll,
          imgName:imgName,
          postId: newId,
          // profileImg: profileImg,
          uid: FirebaseAuth.instance.currentUser!.uid, 
          nameInArabic: nameInArabic, 
          nameInEnglish: nameInEnglish, 
          price: price, 
          sequence: sequence, 
          code: code, 
          descriptionInArabic: descriptionInArabic, 
          descriptionInEnglish: descriptionInEnglish, 
          classs: classs, 
          nameInTurkish: nameInTurkish, 
          descriptionInTurkish: descriptionInTurkish, 
          descriptionInKurkish: descriptionInKurkish, 
          nameInKurkish: nameInKurkish, 
          
          // phoneNumber: phoneNumber,
    );


    /////
    







      posts
          .doc(newId)
          .set(postt.convert2Map())
          .then((value) => print("done...."))
          .catchError((error) => print("Failed to post: $error"));

      message = 'Posted successfully';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }





  
}
