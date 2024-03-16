

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:mgmt/contantt.dart';
// import 'package:mgmt/firebase_services/firestore.dart';
// import 'package:mgmt/generated/l10n.dart';
// import 'package:mgmt/provider/push_notifications.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;



// class ReserveNowScreen extends StatefulWidget {
//   // final String rightLift;
//   // final String filsonProBold;
//   // final String filsonProRegular;
//   // final String brandoRegular;
//   // final String brandoBold;
//   // final String reservationOccasion;
//   // final String dropDownValue;
//   // final Color textLabelColor;
//   // final Color textColor;

//   const ReserveNowScreen({
//     super.key,
//   //   required this.rightLift,
//   //   required this.filsonProBold,
//   //   required this.filsonProRegular,
//   //   required this.brandoRegular,
//   //   required this.brandoBold,
//   //   required this.reservationOccasion,
//   //   required this.dropDownValue,
//   //   required this.textLabelColor,
//   //   required this.textColor,
// });

//   @override
//   State<ReserveNowScreen> createState() => _ReserveNowScreenState();
// }

// class _ReserveNowScreenState extends State<ReserveNowScreen> {
//   PushNotifications pushNotifications = PushNotifications();

//   final _formKey = GlobalKey<FormState>();
//   final fullNameController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final emailController = TextEditingController();
//   final occasionController = TextEditingController();
//   final dateController = TextEditingController();
//   final timeController = TextEditingController();
//   final guestsController = TextEditingController();
//   final anyRequestController = TextEditingController();

//   var hour = 0;
//   var minute = 0;

//   var timeFormat = "AM";

//   DateTime date = DateTime.now();
//   TimeOfDay time = const TimeOfDay(hour: 8, minute: 30);

//   bool isLoading = false;

//   //----------- to Send Info ti DB --------??
//   clickOnBoolATable() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });
//       String newId = const Uuid().v1();
//       await FireStoreMethods()
//           .uploadReservation(
//               fullName: fullNameController.text,
//               phoneNumber: phoneNumberController.text,
//               email: emailController.text,
//               reservationOccasion: occasionController.text,
//               reservationDate: dateController.text,
//               reservationTime: timeController.text,
//               guestsCount: guestsController.text,
//               requests: anyRequestController.text,
//               context: context,
//               tableNo: '***',
//               reservationID: newId,
//               collectionReference: 'reservations',
//               newReservation: "Yes",
//               confirme: 'No',
//               archive: "No", uid: "Fj8TuEb2S3hXh3hmoispMhod0Ca2")
//           .whenComplete(() {
//         pushNotificationsSpecificDevice(
//             body: S.of(context).a_reservation_request_was_made_for_a_table,
//             title: fullNameController.text);
//       });
//       setState(() {
//         isLoading = false;
//       });
//       if (!mounted) return;
//     } else {
//       showGeneralDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel: "",
//         transitionDuration: const Duration(milliseconds: 400),
//         pageBuilder: (context, animation1, animation2) {
//           return Container();
//         },
//         transitionBuilder: (context, a1, a2, widget) {
//           return ScaleTransition(
//             scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
//             child: FadeTransition(
//               opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
//               child: AlertDialog(
//                 content: Text(
//                   S.of(context).fill_all_feild,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontFamily: "Brando-Regular"),
//                 ),
//                 shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: BorderSide.none),
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }

//   Map userData = {};
//   bool isLoadingg = true;

//   getData() async {
//     setState(() {
//       isLoadingg = true;
//     });
//     // get Data from DB
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('userSSS')
//           .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
//           .get();

//       userData = snapshot.data()!;
//       tokkk = userData['followers'];
       

//       //
//     } catch (e) {
//       // print(e.toString());
//     }

//     setState(() {
//       isLoadingg = false;
//     });
//   }

//   late List tokkk = [];
//   addTokens() async {
    
//   }
//   late String nameeee;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//     pushNotifications.isTokenRefresh();
//     pushNotifications.getDeviceToken().then(
      
//      (value)   async{


      
//       tokkk.contains(value) ? 
//       print(value) :
    

//       await FirebaseFirestore.instance
//                                               .collection("userSSS")
//                                               .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
//                                               .update({
//                                             "followers": FieldValue.arrayUnion([
//                                               "\"$value\""
//                                             ])
//                                           });


     
//       print("device token: $value");
//     });

//     time = TimeOfDay.now();
//     timeController.text =
//         "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} $timeFormat";
//   }

//   @override
//   void dispose() {
//     phoneNumberController.dispose();
//     fullNameController.dispose();
//     emailController.dispose();
//     occasionController.dispose();
//     dateController.dispose();
//     timeController.dispose();
//     guestsController.dispose();
//     anyRequestController.dispose();

//     super.dispose();
//   }

//   late String dropDownValue = S.of(context).reservation_occasion;
//   String generateQRData() {
//     return "${fullNameController.text}\n${phoneNumberController.text}\n${dateController.text}\n${timeController.text}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final heightAppbar = AppBar().preferredSize.height;
//     //  String dropDownValue  = widget.reservationOccasion;

//     timeController.text =
//         "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} $timeFormat";


//     return 
    
//     Container(
//       // padding: EdgeInsets.only(bottom: 20),
//       height: heightScreen - heightAppbar,
//       width: widthScreen,
//       // color: const Color.fromARGB(255, 14, 13, 40),
//       color: const Color.fromRGBO(7, 51, 72, 1),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               //-------------------  Personal Information  -----------------------//
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(width: 2, color: Colors.white
//                         // color: const Color.fromARGB(255, 250, 200, 119),
//                         )),
//                 padding: const EdgeInsets.all(10),
//                 child: Column(children: [
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     child: Text(
//                       S.of(context).personal_information,
//                       style: TextStyle(
//                           fontSize: 30,
//                           // fontFamily: widget.filsonProRegular,
//                           color: Colors.white),
//                     ),
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       return value!.isEmpty ? "Can Not be empty" : null;
//                     },
//                     // textInputAction: TextInputAction.newline,
//                     onChanged: (namee) {
//                       nameeee =fullNameController.text;
//                     },

//                     maxLines: 5,
//                     minLines: 1,
//                     controller: fullNameController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).write_your_fullname,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         // hintText: 'ادخل اسمك',

//                         labelStyle: TextStyle(
//                           // fontFamily: widget.filsonProRegular,
//                           color: Colors.white,
//                         )),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   IntlPhoneField(
//                     showDropdownIcon: true,
//                     dropdownTextStyle: const TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),

//                     pickerDialogStyle: PickerDialogStyle(
//                       countryCodeStyle: const TextStyle(
//                         color: Color.fromARGB(255, 250, 200, 119),
//                       ),
//                       countryNameStyle: const TextStyle(
//                         color: Color.fromARGB(255, 250, 200, 119),
//                       ),
//                       backgroundColor: const Color.fromARGB(255, 3, 2, 45),
//                     ),
//                     onChanged: (phone) {
//                       phoneNumberController.text = phone.completeNumber;
//                       // print(phone.completeNumber);
//                     },
//                     // controller: phoneNumberController,
//                     initialCountryCode: "IQ",
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                         prefixIconColor: Colors.white,
//                         counterStyle: TextStyle(
//                           color: Colors.white,
//                         ),
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).write_your_phonenumber,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         suffixIconColor: Colors.white,
//                         hoverColor: Colors.white,
//                         labelStyle: TextStyle(
                            
//                             color: Colors.white)),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     // validator: (value) {
//                     //   return value!.isEmpty ? "Can Not be empty" : null;
//                     // },
//                     // textInputAction: TextInputAction.newline,

//                     maxLines: 5,
//                     minLines: 1,
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).write_your_email,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         // hintText: 'ادخل اسمك',

//                         labelStyle: TextStyle(
               
//                             color: Colors.white)),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ]),
//               ),

//               //--------------------   Reservation Information  ----------------------------//

//               Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(width: 2, color: Colors.white)),
//                 padding: const EdgeInsets.all(10),
//                 child: Column(children: [
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     child: Text(
//                       S.of(context).reservation_information,
//                       style: TextStyle(
//                           fontSize: 30,
                         
//                           color: Colors.white),
//                     ),
//                   ),

//                   //------------ try -------------------------//
//                   TextFormField(
//                     validator: (value) {
//                       return value!.isEmpty ? "Can Not be empty" : null;
//                     },
//                     // textInputAction: TextInputAction.newline,

//                     maxLines: 5,
//                     minLines: 1,
//                     controller: occasionController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).reservation_occasion,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         hintText:
//                             "${S.of(context).birthday},  ${S.of(context).graduation_event},  ${S.of(context).marriage} ...",
//                         hintStyle: TextStyle(
                           
//                             color: const Color.fromARGB(132, 250, 200, 119)),
//                         labelStyle: TextStyle(
                        
//                             color: Colors.white)),
//                     style: TextStyle(color: Colors.white),
//                   ),

//                   //---------------  Pick  Reservation Occasion -----------------//

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   //----------------- Pick Date.  ----------------------//

//                   TextFormField(
//                     onTap: () async {
//                       DateTime? newDate = await showDatePicker(
//                           context: context,
//                           initialDate: date,
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(3000));

//                       // if "CANCEL" => null
//                       if (newDate == null) return;

//                       // if "OK" => DateTime
//                       setState(() {
//                         date = newDate;
//                         dateController.text =
//                             DateFormat.MMMMEEEEd().format(date);
//                       });
//                     },
//                     validator: (value) {
//                       return value!.isEmpty ? "Can Not be empty" : null;
//                     },
//                     // textInputAction: TextInputAction.newline,

//                     maxLines: 1,
//                     minLines: 1,
//                     controller: dateController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).date_of_reservation,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         hintText: "DD/MM/dd",
//                         hintStyle: TextStyle(
//                             color: const Color.fromARGB(132, 250, 200, 119)),
//                         labelStyle: TextStyle(
//                             color: Colors.white)),
//                     style: TextStyle(color:Colors.white),
//                   ),

//                   //---------------   Pick Time.  ------------//

//                   SizedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Text(
//                           //     "${S.of(context).pick_your_time} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} $timeFormat",
//                           //     style: const TextStyle(
//                           //         fontWeight: FontWeight.bold,
//                           //         fontSize: 18,
//                           //         color: Color.fromARGB(255, 250, 200, 119))),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("${S.of(context).pick_your_time} ",
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color:
//                                           Color.fromARGB(255, 250, 200, 119))),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               SizedBox(
//                                 width: 120,
//                                 // height: 40,
//                                 child: TextFormField(
//                                   validator: (value) {
//                                     return value!.isEmpty || value == "00:00 AM"
//                                         ? "Can Not be empty"
//                                         : null;
//                                   },
//                                   // textInputAction: TextInputAction.newline,
//                                   textAlign: TextAlign.center,

//                                   controller: timeController,
//                                   keyboardType: TextInputType.text,
//                                   obscureText: false,

//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.only(
//                                           left: 8, right: 8),
//                                       border: const OutlineInputBorder(),
//                                       // labelText: S.of(context).reservation_occasion,
//                                       floatingLabelAlignment:
//                                           FloatingLabelAlignment.center,
//                                       // hintText:
//                                       //     "${S.of(context).birthday},  ${S.of(context).graduation_event},  ${S.of(context).marriage} ...",
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromARGB(
//                                               132, 250, 200, 119)),
//                                       labelStyle: TextStyle(
//                                           color: Colors.white)),
//                                   style: TextStyle(
//                                     color:Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 5, vertical: 5),
//                             decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 36, 34, 88),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 NumberPicker(
//                                   minValue: 0,
//                                   maxValue: 12,
//                                   value: hour,
//                                   zeroPad: true,
//                                   infiniteLoop: true,
//                                   itemWidth: 50,
//                                   itemHeight: 30,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       hour = value;
//                                     });
//                                   },
//                                   textStyle: const TextStyle(
//                                     color: Colors.grey,
//                                   ),
//                                   selectedTextStyle: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                   decoration: const BoxDecoration(
//                                     border: Border(
//                                         top: BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         bottom:
//                                             BorderSide(color: Colors.white)),
//                                   ),
//                                 ),
//                                 NumberPicker(
//                                   minValue: 0,
//                                   maxValue: 59,
//                                   value: minute,
//                                   zeroPad: true,
//                                   infiniteLoop: true,
//                                   itemWidth: 50,
//                                   itemHeight: 30,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       minute = value;
//                                     });
//                                   },
//                                   textStyle: const TextStyle(
//                                     color: Colors.grey,
//                                   ),
//                                   selectedTextStyle: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                   decoration: const BoxDecoration(
//                                     border: Border(
//                                         top: BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         bottom:
//                                             BorderSide(color: Colors.white)),
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           timeFormat = S.of(context).am;
//                                         });
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 5, vertical: 5),
//                                         decoration: BoxDecoration(
//                                             color:
//                                                 timeFormat == S.of(context).am
//                                                     ? Colors.grey.shade800
//                                                     : Colors.grey.shade700,
//                                             border: Border.all(
//                                               color:
//                                                   timeFormat == S.of(context).am
//                                                       ? Colors.grey
//                                                       : Colors.grey.shade700,
//                                             )),
//                                         child: Text(
//                                           S.of(context).am,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           timeFormat = S.of(context).pm;
//                                         });
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 5, vertical: 5),
//                                         decoration: BoxDecoration(
//                                           color: timeFormat == S.of(context).pm
//                                               ? Colors.grey.shade800
//                                               : Colors.grey.shade700,
//                                           border: Border.all(
//                                             color:
//                                                 timeFormat == S.of(context).pm
//                                                     ? Colors.grey
//                                                     : Colors.grey.shade700,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           S.of(context).pm,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),

//                   //-------------- How Many People ------------//

//                   TextFormField(
//                     validator: (value) {
//                       return value!.isEmpty ? "Can Not be empty" : null;
//                     },
//                     onTap: () {},
//                     // textInputAction: TextInputAction.newline,

//                     maxLines: 5,
//                     minLines: 1,
//                     controller: guestsController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).how_many_guests,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         labelStyle: TextStyle(
//                             color: Colors.white)),
//                     style: TextStyle(color: Colors.white),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   //-------------- Any  ------------//

//                   TextFormField(
//                     validator: (value) {
//                       return value!.isEmpty ? "Can Not be empty" : null;
//                     },
//                     onTap: () {},
//                     // textInputAction: TextInputAction.newline,

//                     maxLines: 6,
//                     minLines: 3,
//                     controller: anyRequestController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: S.of(context).any_special_requests,
//                         floatingLabelAlignment: FloatingLabelAlignment.center,
//                         labelStyle: TextStyle(
//                             color: Colors.white)),
//                     style: TextStyle(color: Colors.white),
//                   ),

//                   const SizedBox(
//                     height: 15,
//                   ),

//                   ElevatedButton(
//                     onPressed: () async {
//                       // clickToSend();
//                       setState(() {
//                         print(" phone: ${phoneNumberController.text}");
//                       });
//                       userData['isReservationWebWork'] == "Yes"
//                           ? clickOnBoolATable()
//                           : showGeneralDialog(
//                               context: context,
//                               barrierDismissible: true,
//                               barrierLabel: "",
//                               transitionDuration:
//                                   const Duration(milliseconds: 400),
//                               pageBuilder: (context, animation1, animation2) {
//                                 return Container();
//                               },
//                               transitionBuilder: (context, a1, a2, widget) {
//                                 return ScaleTransition(
//                                   scale: Tween<double>(begin: 0.5, end: 1.0)
//                                       .animate(a1),
//                                   child: FadeTransition(
//                                     opacity: Tween<double>(begin: 0.5, end: 1.0)
//                                         .animate(a1),
//                                     child: AlertDialog(
//                                       content: const Text(
//                                         "تم حجز جميع الطاولات",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontFamily: "Brando-Regular"),
//                                       ),
//                                       shape: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(16),
//                                           borderSide: BorderSide.none),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ).whenComplete(() {
//                               pushNotificationsSpecificDevice(
//                                   body:
//                                       "${S.of(context).sorry}  $nameeee \n${S.of(context).sorry_all_tables_have_been_reserved}",
//                                   title:
//                                       S.of(context).the_table_has_not_been_reserved);
//                             });
//                     },
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                             const Color.fromARGB(255, 20, 19, 75))),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(S.of(context).book_a_table,
//                           style: const TextStyle(
//                               fontSize: 22,
//                               color: Color.fromARGB(255, 250, 200, 119))),
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),
                 

//                   Container(
//                     padding: const EdgeInsets.all(5),
//                     child: Text(S.of(context).late,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.white)),
//                   )
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> pushNotificationsGroupDevice({
//     required String title,
//     required String body,
//   }) async {
//     print("first");

//     String dataNotifications = '{'
//         '"operation": "create",'
//         '"notification_key_name": "appUser-testUser",'
//         '"registration_ids":["dBy2EBvkQXavx6oW27vexa:APA91bGHDo0-pJf_HIry7nXXKuTN9eJsE7am-T1glysm7G6yzcluDM7W8H1O44fMT5vqH6GJsKziO_JcoTNADYeb5JQ1co8N0EL5tAoyus1Ru_1AoTTnlT0Re4CoIJ1hAI7wjC0pFMYq","d1Kudv_ERRSY4ELxKjss-c:APA91bFMm-S56N35a6u8WAMiV88I3fNXKvhcLa8KbMrbjG7CdiVVCikJd3dyc0SgBkqlm3bsAJpU7rueX5esTYjOhILAUUNI8JXXZXDNXfWzi-wOWerYBfHFNR1JgL2N6c41iNJi8vaB"],'
//         '"notification" : {'
//         '"title":"$title",'
//         '"body":"$body"'
//         ' }'
//         ' }';
//     print("secund");

//     final response = await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization':
//             'key=AAAAjAVSPkc:APA91bGFp7RvAzcYiirdA9VGg91b_niTuq4YtFUV5wFrn5_wZozdISy45C1rqNTZt-OaZwso9Jw55GYrYOnDVvc7x3KaeYu2thrx4GA1b7Piz5yD3NYuhAehSWBcnfpraYvwivLyXHtR',
//         'project_id': "601384697415"
//       },
//       body: dataNotifications,
//     );
//     print("thee");

//     print(response.body.toString());
//     print(tokkk.toString());

//     return true;
//   }

//   Future<bool> pushNotificationsAllUsers({
//     required String title,
//     required String body,
//   }) async {
//     FirebaseMessaging.instance.subscribeToTopic("myTopic1");

//     // String dataNotifications = '{ '
//     //     ' "to" : "/topics/myTopic1" , '
//     //     ' "notification" : {'
//     //     ' "title":"$title" , '
//     //     ' "body":"$body" '
//     //     ' } '
//     //     ' } ';
//     String dataNotifications = '{ "to" : "/topics/myTopic1",'
//         ' "notification" : {'
//         ' "title":"$title",'
//         '"body":"$body"'
//         ' }'
//         ' }';

//     var response = await http.post(
//       Uri.parse(Constants.BASE_URL),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key= ${Constants.KEY_SERVER}',
//       },
//       body: dataNotifications,
//     );
//     print(response.body.toString());
//     return true;
//   }

//   Future<bool> pushNotificationsSpecificDevice({
//     // required String token,
//     required String title,
//     required String body,
//   }) async {
//     final ttt = tokkk.toString();
//     String dataNotifications = '{'
//         '"operation": "create",'
//         '"notification_key_name": "appUser-testUser",'
//         '"registration_ids":$ttt,'
//         '"notification" : {'
//         '"title":"$title",'
//         '"body":"$body"'
//         ' }'
//         ' }';

//     await http.post(
//       Uri.parse(Constants.BASE_URL),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key= ${Constants.KEY_SERVER}',
//       },
//       body: dataNotifications,
//     );
//     return true;
//   }

//   //  Future<bool> pushNotificationsSpecificDevice({
//   //   required String token,
//   //   required String title,
//   //   required String body,
//   // }) async {

//   //   String dataNotifications = '{'
//   //       '"operation": "create",'
//   //       '"notification_key_name": "appUser-testUser",'
//   //       '"registration_ids":["dBy2EBvkQXavx6oW27vexa:APA91bGHDo0-pJf_HIry7nXXKuTN9eJsE7am-T1glysm7G6yzcluDM7W8H1O44fMT5vqH6GJsKziO_JcoTNADYeb5JQ1co8N0EL5tAoyus1Ru_1AoTTnlT0Re4CoIJ1hAI7wjC0pFMYq","d1Kudv_ERRSY4ELxKjss-c:APA91bFMm-S56N35a6u8WAMiV88I3fNXKvhcLa8KbMrbjG7CdiVVCikJd3dyc0SgBkqlm3bsAJpU7rueX5esTYjOhILAUUNI8JXXZXDNXfWzi-wOWerYBfHFNR1JgL2N6c41iNJi8vaB"],'
//   //       '"notification" : {'
//   //       '"title":"$title",'
//   //       '"body":"$body"'
//   //       ' }'
//   //       ' }';

//   //   await http.post(
//   //     Uri.parse(Constants.BASE_URL),
//   //     headers: <String, String>{
//   //       'Content-Type': 'application/json',
//   //       'Authorization': 'key= ${Constants.KEY_SERVER}',
//   //     },
//   //     body: dataNotifications,
//   //   );
//   //   return true;
// }
