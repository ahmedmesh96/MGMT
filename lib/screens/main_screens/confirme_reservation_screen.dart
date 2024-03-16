import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mgmt/Screens/reservation_info_screen.dart';
import 'package:mgmt/generated/l10n.dart';
import 'package:mgmt/screens/main_screens/dashboard.dart';
import 'package:mgmt/screens/main_screens/search.dart';


class ConfirmedReservationScreen extends StatefulWidget {
  const ConfirmedReservationScreen({super.key});

  @override
  State<ConfirmedReservationScreen> createState() => _ConfirmedReservationScreenState();
}

class _ConfirmedReservationScreenState extends State<ConfirmedReservationScreen> {
  Future<void> refesh() {
    return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    final heightAppbar = AppBar().preferredSize.height;
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(7, 51, 72, 1),
      backgroundColor:const  Color.fromRGBO(7, 51, 72, 1),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const SearchScreen(
              subcollectionID: "confirmeResrervatins", subcollectionName: "ConfirmeReservations")));
          }, icon: const Icon(Icons.search)),
          
          IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const DashboardScreen(subcollectionID: 'confirmeResrervatins', subcollectionName: 'ConfirmeReservations', isYes: 'confirme',)));
        }, icon: const Icon(Icons.calendar_month))],
        backgroundColor: const Color.fromRGBO(21, 8, 88, 1),
        centerTitle: true,
        title: Text(S.of(context).pinned_reservations),
      ),
      body: SizedBox(
        // color: Colors.amber,
        // height: heightScreen* 0.6,
            
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Reservations').doc("confirmeResrervatins").collection("ConfirmeReservations")
              // .where('confirme',
              //  isEqualTo: 'Yes')
              .orderBy("startTime", descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            
            return RefreshIndicator(
                onRefresh: refesh,
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ReservationInfoScreen(
                                    
                                      uiddd: data['reservationID'], 
                                      subcollectionID: 'confirmeResrervatins', 
                                      subcollectionName: 'ConfirmeReservations',)));
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 3, right: 3),
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        // height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: const Border(bottom: BorderSide(width: 1,color: Colors.white)
                              // width: 1,
                              // color: data['isDontCame'] == "Yes"
                              //     ? Colors.red
                              //     : data['isCame'] == "Yes"
                              //         ? Colors.green
                              //         : Colors.blue,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: data['isDontCame'] == "Yes"
                                  ? Colors.red
                                  : data['isCame'] == "Yes"
                                      ? Colors.green
                                      : Colors.blue,
                              radius: 20,
                              child: Text((data['fullName'][0]).toString()),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              
                          
                              children: [
                                SizedBox(
                                  width: widthScreen - 70,
                                  
                                  
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Text(
                                          data['fullName'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10),
                                        child: Text(
                                          data['reservationDate'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data['reservationOccasion'],
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white70),
                                      ),
                                      Text(
                                        " ${data['phoneNumber']} ",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
    )
    
    ;
  }
}

