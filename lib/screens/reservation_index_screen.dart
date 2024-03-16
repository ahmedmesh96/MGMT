// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mgmt/Screens/reservation_info_screen.dart';
// import 'package:mgmt/provider/push_notifications.dart';
// import 'package:mgmt/screens/main_screens/search.dart';


// class ReservationIndexScreen extends StatefulWidget {
//   const ReservationIndexScreen({super.key});

//   @override
//   State<ReservationIndexScreen> createState() => _ReservationIndexScreenState();
// }

// class _ReservationIndexScreenState extends State<ReservationIndexScreen> {
//   PushNotifications pushNotifications = PushNotifications();
//   late List tokkk = [];
  


//   @override
//   void initState() {
//     super.initState();
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
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final heightAppbar = AppBar().preferredSize.height;
//     Future<void> isReservationWebWork() async {
//     return await FirebaseFirestore.instance
//         .collection('userSSS')
//         .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
//         .update({
//           'isReservationWebWork': "Yes",
          
//         })
//         .then((value) => setState(() {}))
//         .catchError((error) => print("Failed to update user: $error"));
//   }
//   Future<void> isReservationWebWorkk() async {
//     return await FirebaseFirestore.instance
//         .collection('userSSS')
//         .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
//         .update({
//           'isReservationWebWork': "No",
          
//         })
//         .then((value) => setState(() {}))
//         .catchError((error) => print("Failed to update user: $error"));
//   }
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
        
//         appBar: AppBar(
          
          
           
//               actions: [
//                 IconButton(onPressed: ()async{
//                 setState(() {
//                   isReservationWebWorkk();
//                 });
                
              
//               }, icon: const Icon(Icons.web_asset_off_outlined, color: Colors.red,)),
//               IconButton(onPressed: ()async{
//                 setState(() {
//                   isReservationWebWork();
//                 });
                
              
//               }, icon: const Icon(Icons.web, color: Colors.green,)),
                
//               ],

//               leading: IconButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (c) => const SearchScreen()));
//                     },
//                     icon: const Icon(Icons.search)),
//               centerTitle: true,
//               iconTheme:
//                   const IconThemeData(color: Color.fromRGBO(228, 198, 144, 1)),
//               title: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 child: Image.asset(
//                   "assets/img/konya_logo.png",
//                   height: 40,
//                 ),
//               ),
//               backgroundColor: const Color.fromRGBO(21, 8, 88, 1),
//             ),
//             backgroundColor: const Color.fromARGB(255, 67, 20, 35),
            
//         body:  const Column(
//           children: [
//             TabBar(
//               indicatorColor: Color.fromRGBO(228, 198, 144, 1),
//               // overlayColor: MaterialStatePropertyAll(Color.fromRGBO(228, 198, 144, 1)),
              
//               labelColor: Color.fromRGBO(228, 198, 144, 1),
//               tabs: [
//               Tab(text: "الحجوزات الجديده",),
//               Tab(text: "الحجوزات المثبته",),
//               Tab(text: "ارشيف",),
//             ]),

//            Expanded(child: TabBarView(children: [
//             NewReservations(),
//             //---------------------------------------//
//             ConfirmedReservationScree(),
//             ArchiveScree(),
            
//            ]))
        
            
              
//         ],),
//       ),
//     );
//   }
// }












// //-------------- new Reservation --------------//
// class NewReservations extends StatefulWidget {
//   const NewReservations({super.key});

//   @override
//   State<NewReservations> createState() => _NewReservationsState();
// }

// class _NewReservationsState extends State<NewReservations> {
//   Future<void> refesh() {
//     return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
//       setState(() {});
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final heightAppbar = AppBar().preferredSize.height;
//     return Container(
//         height: heightScreen,
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('reservations')
//               .where('newReservation',
//                isEqualTo: 'Yes')
//               // .orderBy("processTime", descending: true)
//               .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }
            
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 color: Colors.white,
//               ));
//             }
            
//             return Container(
//               height: heightScreen ,
//               child: RefreshIndicator(
//                 onRefresh: refesh,
//                 child: ListView(
//                   children:
//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                     Map<String, dynamic> data =
//                         document.data()! as Map<String, dynamic>;
//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (c) => ReservationInfoScreen(
//                                       uiddd: data['reservationID'])));
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(top: 10, left: 3, right: 3),
//                         padding: const EdgeInsets.only(left: 3, right: 3),
//                         // height: 60,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             border: const Border(bottom: BorderSide(width: 1,color: Colors.white)
//                               // width: 1,
//                               // color: data['isDontCame'] == "Yes"
//                               //     ? Colors.red
//                               //     : data['isCame'] == "Yes"
//                               //         ? Colors.green
//                               //         : Colors.blue,
//                             )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: data['isDontCame'] == "Yes"
//                                   ? Colors.red
//                                   : data['isCame'] == "Yes"
//                                       ? Colors.green
//                                       : Colors.blue,
//                               radius: 20,
//                               child: Text((data['fullName'][0]).toString()),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               mainAxisSize: MainAxisSize.max,
                              
                          
//                               children: [
//                                 SizedBox(
//                                   width: widthScreen - 70,
                                  
                                  
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 10, left: 10, right: 10),
//                                         child: Text(
//                                           data['fullName'],
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 10),
//                                         child: Text(
//                                           data['reservationDate'],
//                                           style: const TextStyle(
//                                               fontSize: 13,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: widthScreen * 0.8,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         data['reservationOccasion'],
//                                         style: const TextStyle(
//                                             fontSize: 14, color: Colors.grey),
//                                       ),
//                                       Text(
//                                         " ${data['phoneNumber']} ",
//                                         style: const TextStyle(
//                                             fontSize: 14, color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//       )
    
//     ;
//   }
// }



// //-------------- archive --------------//
// class ArchiveScree extends StatefulWidget {
//   const ArchiveScree({super.key});

//   @override
//   State<ArchiveScree> createState() => _ArchiveScreeState();
// }

// class _ArchiveScreeState extends State<ArchiveScree> {
//   Future<void> refesh() {
//     return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
//       setState(() {});
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final heightAppbar = AppBar().preferredSize.height;
//     return SizedBox(
//       // color: Colors.amber,
//       // height: heightScreen* 0.6,
          
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('reservations')
//             .where('archive',
//              isEqualTo: 'Yes')
//             // .orderBy("reservationDate", descending: true)
//             .snapshots(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }
          
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CircularProgressIndicator(
//               color: Colors.white,
//             ));
//           }
          
//           return RefreshIndicator(
//             onRefresh: refesh,
//             child: ListView(
//               children:
//                   snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return InkWell(
//                   onTap: () {
//                     setState(() {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (c) => ReservationInfoScreen(
//                                   uiddd: data['reservationID'])));
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 10, left: 3, right: 3),
//                     padding: const EdgeInsets.only(left: 3, right: 3),
//                     // height: 60,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(0),
//                         border: const Border(bottom: BorderSide(width: 1,color: Colors.white)
//                           // width: 1,
//                           // color: data['isDontCame'] == "Yes"
//                           //     ? Colors.red
//                           //     : data['isCame'] == "Yes"
//                           //         ? Colors.green
//                           //         : Colors.blue,
//                         )),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: data['isDontCame'] == "Yes"
//                               ? Colors.red
//                               : data['isCame'] == "Yes"
//                                   ? Colors.green
//                                   : Colors.blue,
//                           radius: 20,
//                           child: Text((data['fullName'][0]).toString()),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           mainAxisSize: MainAxisSize.max,
                          
                      
//                           children: [
//                             SizedBox(
//                               width: widthScreen - 70,
                              
                              
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 10, left: 10, right: 10),
//                                     child: Text(
//                                       data['fullName'],
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.only(top: 10),
//                                     child: Text(
//                                       data['reservationDate'],
//                                       style: const TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: widthScreen * 0.8,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     data['reservationOccasion'],
//                                     style: const TextStyle(
//                                         fontSize: 14, color: Colors.grey),
//                                   ),
//                                   Text(
//                                     " ${data['phoneNumber']} ",
//                                     style: const TextStyle(
//                                         fontSize: 14, color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//         },
//       ),
//     )
//     ;
//   }
// }












// //-------------- Confirmed bookings --------------//
// class ConfirmedReservationScree extends StatefulWidget {
//   const ConfirmedReservationScree({super.key});

//   @override
//   State<ConfirmedReservationScree> createState() => _ConfirmedReservationScreeState();
// }

// class _ConfirmedReservationScreeState extends State<ConfirmedReservationScree> {
//   Future<void> refesh() {
//     return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
//       setState(() {});
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final double widthScreen = MediaQuery.of(context).size.width;
//     final double heightScreen = MediaQuery.of(context).size.height;
//     final heightAppbar = AppBar().preferredSize.height;
//     return Scaffold(
      
//       body: SizedBox(
//         // color: Colors.amber,
//         // height: heightScreen* 0.6,
            
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('reservations')
//               .where('confirme',
//                isEqualTo: 'Yes')
//               // .orderBy("reservationDate", descending: true)
//               .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }
            
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 color: Colors.white,
//               ));
//             }
            
//             return RefreshIndicator(
//               onRefresh: refesh,
//               child: ListView(
//                 children:
//                     snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data()! as Map<String, dynamic>;
//                   return InkWell(
//                     onTap: () {
//                       setState(() {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (c) => ReservationInfoScreen(
//                                     uiddd: data['reservationID'])));
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(top: 10, left: 3, right: 3),
//                       padding: const EdgeInsets.only(left: 3, right: 3),
//                       // height: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(0),
//                           border: const Border(bottom: BorderSide(width: 1,color: Colors.white)
//                             // width: 1,
//                             // color: data['isDontCame'] == "Yes"
//                             //     ? Colors.red
//                             //     : data['isCame'] == "Yes"
//                             //         ? Colors.green
//                             //         : Colors.blue,
//                           )),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: data['isDontCame'] == "Yes"
//                                 ? Colors.red
//                                 : data['isCame'] == "Yes"
//                                     ? Colors.green
//                                     : Colors.blue,
//                             radius: 20,
//                             child: Text((snapshot.data!.docs.length.toString())
//                               // data['fullName'][0]).toString()
//                               ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             mainAxisSize: MainAxisSize.max,
                            
                        
//                             children: [
//                               SizedBox(
//                                 width: widthScreen - 70,
                                
                                
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 10, left: 10, right: 10),
//                                       child: Text(
//                                         data['fullName'],
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(top: 10),
//                                       child: Text(
//                                         data['reservationDate'],
//                                         style: const TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: widthScreen * 0.8,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       data['reservationOccasion'],
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.grey),
//                                     ),
//                                     Text(
//                                       " ${data['phoneNumber']} ",
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           },
//         ),
//       ),
//     )
//     ;
//   }
// }
