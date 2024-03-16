import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  final String imgName;
  final String nameInArabic;
  final String nameInEnglish;
  final String nameInTurkish;
  final String nameInKurkish;
  final String price;
  final String sequence;
  final String code;
  final String descriptionInArabic;
  final String descriptionInEnglish;
  final String descriptionInTurkish;
  final String descriptionInKurkish;
  final String classs;
  final String imgPost;
  final String uid;
  final String postId;
  
  

  MenuItem(
     {
    required this.descriptionInKurkish,
    required this.nameInKurkish,
    required this.imgName,
    required this.nameInArabic,
    required this.nameInEnglish,
    required this.nameInTurkish,
    required this.price,
    required this.sequence,
    required this.code,
    required this.descriptionInArabic,
    required this.descriptionInEnglish,
    required this.descriptionInTurkish,
    required this.classs,
    required this.imgPost,
    required this.uid,
    required this.postId,

  });

// To convert the UserData(Data type) to Map<String, object>
  Map<String, dynamic> convert2Map() {
    return {
      "imgName": imgName,
      "nameInArabic": nameInArabic,
      "nameInEnglish": nameInEnglish,
      "nameInTurkish": nameInTurkish,
      "nameInKurkish": nameInKurkish,
      "price": price,
      "sequence": sequence,
      "code": code,
      "descriptionInArabic": descriptionInArabic,
      "descriptionInEnglish": descriptionInEnglish,
      "descriptionInTurkish":descriptionInTurkish,
      "descriptionInKurkish":descriptionInKurkish,
      "classs": classs,
      "imgPost": imgPost,
      "uid": uid,
      "postId": postId,
      
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MenuItem(
      imgName:snapshot['imgName'],
        nameInArabic: snapshot["nameInArabic"],
        nameInEnglish: snapshot["nameInEnglish"],
        nameInTurkish:snapshot['nameInTurkish'],
        nameInKurkish:snapshot['nameInKurkish'],
        price: snapshot["price"],
        sequence: snapshot["sequence"],
        code: snapshot["code"],
        descriptionInArabic: snapshot["descriptionInArabic"],
        descriptionInEnglish: snapshot["descriptionInEnglish"],
        descriptionInTurkish:snapshot['descriptionInTurkish'],
        descriptionInKurkish:snapshot['descriptionInKurkish'],
        
        classs: snapshot["classs"],
        imgPost: snapshot["imgPost"],
        uid: snapshot["uid"],
        postId: snapshot["postId"],
        
        );
  }
}
