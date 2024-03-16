
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mgmt/Screens/reservation_info_screen.dart';
import 'package:mgmt/controller/language_change_controller.dart';
import 'package:mgmt/generated/l10n.dart';
import 'package:mgmt/provider/push_notifications.dart';
import 'package:mgmt/screens/main_screens/archive_screen.dart';
import 'package:mgmt/screens/main_screens/confirme_reservation_screen.dart';
import 'package:mgmt/screens/main_screens/dashboard.dart';
import 'package:mgmt/screens/main_screens/here_screen.dart';
import 'package:mgmt/screens/main_screens/new_reservation_screen.dart';
import 'package:mgmt/screens/main_screens/reserve_now.dart';
import 'package:mgmt/screens/reservation_table.dart';
import 'package:mgmt/screens/main_screens/search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';



class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

enum Language { english, arabic, turkish, kurdish }

class _MobileScreenState extends State<MobileScreen> {
  PushNotifications pushNotifications = PushNotifications();


  final Color textLabelColor = Colors.white.withOpacity(0.8);
  final Color textColor = Colors.white;
  late bool isArabic = false;
  late bool isTurkish = false;
  late bool isKurdish = false;
  late bool isEnglish = false;
  // late PageController pageController;

  late String rightLeft = "en";
  final filsonProBold = "FilsonProBold";
  final filsonProRegular = "FilsonProRegular";
  final brandoRegular = "Brando-Regular";
  final brandoBold = "Brando-Bold";
  var hour = 0;
  var minute = 0;

  var timeFormat = "AM";
  DateTime date = DateTime.now();
  TimeOfDay time = const TimeOfDay(hour: 8, minute: 30);

 

  @override
  void dispose() {
    //  pageController.dispose();
    super.dispose();
  }

  Future<void> refesh() {
    return Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      setState(() {});
    });
  }

  late String mainLabe = S.of(context).cold_appetizers;
  String reservationOccasion = "Reservation occasion";


   Map userData = {};
  bool isLoading = true;
  late String dovv;
  Future<void> isReservationWebWork() async {
    return await FirebaseFirestore.instance
        .collection('userSSS')
        .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
        .update({
          'isReservationWebWork': "Yes",
          
        })
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> isReservationWebWorkk() async {
    return await FirebaseFirestore.instance
        .collection('userSSS')
        .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
        .update({
          'isReservationWebWork': "No",
          
        })
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }
  


  getData() async {
    setState(() {
      isLoading= true;
    });
    // get Data from DB
    
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('userSSS')
          .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
          .get();

        

       
    // final hh = snapshot.data()!.length.toString();

           
           
     
      userData = snapshot.data()!;
      tokkk = userData['followers'];


       
       

      //
    } catch (e) {
      // print(e.toString());
    }

    setState(() {
      
      isLoading = false;
    });
  }

     int? archiveCount ;

  //--------------------------//
  getDataReservation() async {
    setState(() {
      isLoading= true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('reservations')
          .doc("8U6cgZgOT1hih1Yi9yZQu5BfB9X2")
          .get();

      userData = snapshot.data()!;
      tokkk = userData['followers'];
      // archiveCount = userData['archive'].length;
       db.collection("reservations").where("archive", isEqualTo: "Yes").count().get().then(
          (res) => archiveCount = res.count,
          onError: (e) => print("Error completing: $e"),
        );
      
       late final  String hh = snapshot.data()!.length.toString();

      //
    } catch (e) {
      // print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

 
  
  late final FirebaseFirestore db;





  late List tokkk = [];
@override
  void initState() {
    super.initState();
    // pageController = PageController(viewportFraction: 1);
    
    getData();
    getDataReservation();
    pushNotifications.isTokenRefresh();
    pushNotifications.getDeviceToken().then(
      
     (value)   async{


      
      tokkk.contains(value) ? 
      print(value) :
    

      await FirebaseFirestore.instance
                                              .collection("userSSS")
                                              .doc("Fj8TuEb2S3hXh3hmoispMhod0Ca2")
                                              .update({
                                            "followers": FieldValue.arrayUnion([
                                              "\"$value\""
                                            ])
                                          });


     
      print("device token: $value");
    });

     }




  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    final heightAppbar = AppBar().preferredSize.height;
    // final pages = [
    //   // const DashboardScreen(),
    //   Text("data")
      
      
    // ];

    return isLoading
        ? const Scaffold(
            backgroundColor:  Color.fromRGBO(7, 51, 72, 1),
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        :
    
    
    Scaffold(
        backgroundColor: const Color.fromRGBO(7, 51, 72, 1),
        appBar: AppBar(
          centerTitle: true,
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(228, 198, 144, 1)),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Image.asset(
              "assets/img/konya_logo.png",
              height: 40,
            ),
          ),
          actions: [
            Consumer<LanguageChangeController>(
                builder: (context, provider, child) {
              return PopupMenuButton(
                  iconColor: Colors.white,
                  icon: const Icon(
                    Icons.language_sharp,
                    color: Color.fromRGBO(228, 198, 144, 1),
                  ),
                  onSelected: (Language item) {
                    if (Language.english.name == item.name) {
                      provider.changeLanguage(const Locale("en"));
                      setState(() {});
                      setState(() {
                        isArabic = false;
                        isTurkish = true;
                        isEnglish =true;
                        isKurdish = false;
                        rightLeft = "en";
                      });
                    } else if (Language.arabic.name == item.name) {
                      provider.changeLanguage(const Locale("ar"));
                      setState(() {
                        isArabic = true;
                        isTurkish = false;
                        isEnglish= false;
                        isKurdish = false;
                        rightLeft = "ar";
                      });
                    } else if (Language.turkish.name == item.name) {
                      provider.changeLanguage(const Locale("tr"));
                      setState(() {
                        isArabic = false;
                        isTurkish = true;
                        isEnglish=true;
                        isKurdish =false;
                        rightLeft = "tr";
                      });
                    } else {
                      provider.changeLanguage(const Locale("fa"));
                      setState(() {
                        isArabic = true;
                        isTurkish = false;
                        isEnglish =false;
                        isKurdish = true;
                        rightLeft = "fa";
                      });
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                        PopupMenuItem(
                            value: Language.english,
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/languages_icons/unitedstat.png",
                                    height: 20,
                                  ),
                                  const Text(
                                    "English",
                                  ),
                                ],
                              ),
                            )),
                        PopupMenuItem(
                            value: Language.arabic,
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/languages_icons/iraq.png",
                                    height: 20,
                                  ),
                                  const Text("العربية"),
                                ],
                              ),
                            )),
                        PopupMenuItem(
                            value: Language.turkish,
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/languages_icons/turkey.png",
                                    height: 20,
                                  ),
                                  const Text("Türkçe"),
                                ],
                              ),
                            )),
                        PopupMenuItem(
                            value: Language.kurdish,
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/languages_icons/kurdish.png",
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  const Text("کوردی"),
                                ],
                              ),
                            ))
                      ]);
            }),
          ],
          backgroundColor: const Color.fromRGBO(21, 8, 88, 1),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black87,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Image.asset(
                  "assets/img/konya_logo.png",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
              decoration:  const BoxDecoration(shape: BoxShape.circle,  color: Colors.black),
              child: CircleAvatar(radius: 35,
              backgroundImage: NetworkImage(userData['profileImg']),),),
               ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).search,
                        style: TextStyle(
                            fontFamily: filsonProRegular,
                            color: const Color.fromRGBO(228, 198, 144, 1),
                            fontSize: 15)),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const SearchScreen(subcollectionID: 'newReservations',
                      subcollectionName: 'NewReservations',)));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),
              
             
             
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dashboard",
                        style: TextStyle(
                            fontFamily: filsonProRegular,
                            color: const Color.fromRGBO(228, 198, 144, 1),
                            fontSize: 15)),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  // Navigator.push(context,
                      // MaterialPageRoute(builder: (c) => const DashboardScreen()));
                  // pageController.jumpToPage(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        
                        Text(S.of(context).new_reservation,
                            style: TextStyle(
                                fontFamily: filsonProRegular,
                                color: const Color.fromRGBO(228, 198, 144, 1),
                                fontSize: 15)),

                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 20,right: 20),
                                  padding: const EdgeInsets.only(left: 6, right: 6),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: Colors.red),
                                  child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance
                                                              .collection('Reservations').doc('newReservations').collection('NewReservations')
                                                              .where('newReservation',isEqualTo: "Yes").
                                                              snapshots(),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot.hasData) {
                                                              return const Center(
                                                                child: Text("No Task Added"),
                                                              );
                                                            }
                                                            final documentSnapshotList = snapshot.data!.docs;
                                              
                                                            
                                                            return  Text(documentSnapshotList.length.toString());
                                                          },
                                                        ),
                                ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const NewReservationsScreen()));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),
               ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(S.of(context).pinned_reservations,
                            style: TextStyle(
                                fontFamily: filsonProRegular,
                                color: const Color.fromRGBO(228, 198, 144, 1),
                                fontSize: 15)),
                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 20,right: 20),
                                  padding: const EdgeInsets.only(left: 6, right: 6),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: Colors.red),
                                  child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance
                                                              .collection('Reservations').doc("confirmeResrervatins").collection("ConfirmeReservations")
                                                              .where('confirme',isEqualTo: "Yes").
                                                              snapshots(),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot.hasData) {
                                                              return const Center(
                                                                child: Text("No Task Added"),
                                                              );
                                                            }
                                                            final documentSnapshotList = snapshot.data!.docs;
                                              
                                                            
                                                            return  Text(documentSnapshotList.length.toString());
                                                          },
                                                        ),
                                ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ConfirmedReservationScreen()));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),

              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(S.of(context).here,
                            style: TextStyle(
                                fontFamily: filsonProRegular,
                                color: const Color.fromRGBO(228, 198, 144, 1),
                                fontSize: 15)),
                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 20,right: 20),
                                  padding: const EdgeInsets.only(left: 6, right: 6),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: Colors.red),
                                  child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance
                                                              .collection('Reservations').doc("here").collection("Here")
                                                              .where('confirme',isEqualTo: "Yes").
                                                              snapshots(),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot.hasData) {
                                                              return const Center(
                                                                child: Text("No Task Added"),
                                                              );
                                                            }
                                                            final documentSnapshotList = snapshot.data!.docs;
                                              
                                                            
                                                            return  Text(documentSnapshotList.length.toString());
                                                          },
                                                        ),
                                ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HereScreen()));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),


               ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).archive,
                            style: TextStyle(
                                fontFamily: filsonProRegular,
                                color: const Color.fromRGBO(228, 198, 144, 1),
                                fontSize: 15)),
                                Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 20,right: 20),
                                  padding: const EdgeInsets.only(left: 6, right: 6),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: Colors.red),
                                  child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance
                                                             .collection('Reservations').doc('archives').collection('archive')
                                                              .where('archive',isEqualTo: "Yes").
                                                              snapshots(),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot.hasData) {
                                                              return const Center(
                                                                child: Text("No Task Added"),
                                                              );
                                                            }
                                                            final documentSnapshotList = snapshot.data!.docs;
                                              
                                                            
                                                            return  Text(documentSnapshotList.length.toString());
                                                          },
                                                        ),
                                ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ArchiveScreen()));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),

              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).reserve_now,
                        style: TextStyle(
                            fontFamily: filsonProRegular,
                            color: const Color.fromRGBO(228, 198, 144, 1),
                            fontSize: 15)),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(228, 198, 144, 1),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ReserveNowScreen()));
                  // pageController.jumpToPage(1);
                  // Navigator.pop(context);
                },
              ),
              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                IconButton(onPressed: ()async{
                setState(() {
                  isReservationWebWorkk();
                });
                
              
              }, icon: const Icon(Icons.web_asset_off_outlined, color: Colors.red,)),
              IconButton(onPressed: ()async{
                setState(() {
                  isReservationWebWork();
                });
                
              
              }, icon: const Icon(Icons.web, color: Colors.green,)),
              ],),
              const SizedBox(height: 40,),


              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){setState(() async{
                    await FirebaseAuth.instance.signOut();
                    
                  });}, child: const Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),)),
                const SizedBox(height: 60,),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Copyright © SmartEvo")
                 ],)
                ],
              )
             

              
              
            ],
          ),
        ),
        body:const  DashboardScreen(subcollectionID: "newReservations", subcollectionName: 'NewReservations', isYes: 'newReservation',)
        
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //           itemCount: pages.length,
        //           controller: pageController,
        //           scrollDirection: Axis.vertical,
        //           itemBuilder: (context, index) {
        //             return pages[index];
        //           }),
        //     ),
        //   ],
        // )
        );
  }
}

//-----------Home Page -----------------//



