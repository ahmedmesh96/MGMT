import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationData {
  // final String profileImg;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String reservationOccasion;
  final String uid;
  final String reservationDate;
  final String reservationTime;
  final String guestsCount;
  final String requests;
  final String isCame;
  final String isSendCart;
  final String isDontCame;
  final String tableNo;
  final String reservationID;
  final String newReservation;
  final String confirme;
  final String archive;
  final String startTime;

  final DateTime processTime;
 

  ReservationData({
    // required this.profileImg,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.reservationOccasion,
    required this.uid,
    required this.reservationDate,
    required this.reservationTime,
    required this.guestsCount,
    required this.requests,
    required this.isCame,
    required this.isSendCart,
    required this.isDontCame,
    required this.tableNo,
    required this.reservationID,
    required this.newReservation,
    required this.confirme,
    required this.archive,
    required this.startTime,

    required this.processTime,

  });

// To convert the UserData(Data type) to Map<String, object>
  Map<String, dynamic> convert2Map() {
    return {
      // "profileImg": profileImg,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "reservationOccasion": reservationOccasion,
      "uid": uid,
      "reservationDate": reservationDate,
      "reservationTime": reservationTime,
      "guestsCount": guestsCount,
      "requests": requests,
      "isCame": isCame,
      "isSendCart": isSendCart,
      "isDontCame": isDontCame,
      "tableNo":tableNo,
      "reservationID":reservationID,
      "newReservation":newReservation,
      "confirme":confirme,
      "archive":archive,
      "processTime":processTime,
      "startTime":startTime,

    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReservationData(
        // profileImg: snapshot["profileImg"],
        // phoneNumber: snapshot["phoneNumber"],
        fullName: snapshot["fullName"],
        phoneNumber: snapshot["phoneNumber"],
        email: snapshot["email"],
        reservationOccasion: snapshot["reservationOccasion"],
        uid: snapshot["uid"],
        reservationDate: snapshot["reservationDate"],
        reservationTime: snapshot["reservationTime"],
        guestsCount: snapshot['guestsCount'],
        requests: snapshot["requests"],
        isCame: snapshot["isCame"],
        isSendCart: snapshot["isSendCart"],
        isDontCame: snapshot["isDontCame"],
        tableNo: snapshot["tableNo"],
        reservationID: snapshot["reservationID"],
        newReservation: snapshot["newReservation"],
        confirme: snapshot["confirme"],
        archive: snapshot["archive"],
        processTime: snapshot["processTime"],
        startTime: snapshot["startTime"],
        );
  }
}


//----------------

class ReservationSubCollection {
  // final String profileImg;

  final String uid;
  final String reservationDate;
  
  final String reservationID;
  
 

  ReservationSubCollection({
    // required this.profileImg,

    required this.uid,
    required this.reservationDate,

    required this.reservationID,
 

  });

// To convert the UserData(Data type) to Map<String, object>
  Map<String, dynamic> convert2Map() {
    return {
      // "profileImg": profileImg,

      "uid": uid,
      "reservationDate": reservationDate,
     

      "reservationID":reservationID,


    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReservationSubCollection(
        // profileImg: snapshot["profileImg"],
        // phoneNumber: snapshot["phoneNumber"],
       
        uid: snapshot["uid"],
        reservationDate: snapshot["reservationDate"],

        reservationID: snapshot["reservationID"],

        );
  }
}