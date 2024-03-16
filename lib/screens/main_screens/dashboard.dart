import 'dart:async';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';



class DashboardScreen extends StatefulWidget {
  final String subcollectionID;
  final String subcollectionName;
  final String isYes;
  const DashboardScreen({super.key, required this.subcollectionID, required this.subcollectionName, required this.isYes});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {

   
  Future<void> refesh() {
    return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {
        getDataFromFirestore();
      });
    });
  }
  List<Color> colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> option= <String>["Add", "Delete","update" ];
  final databaseReference =FirebaseFirestore.instance;
  

  @override
  void initState(){
    initializeEventColor();
    getDataFromFirestore().then((result) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          
        });
      });

    });
    super.initState();
 
  }

  
  

    final Random randomm = Random();


  Future<void> getDataFromFirestore()async{
    var snapShotValue = await databaseReference
    .collection("Reservations").doc(widget.subcollectionID).collection(widget.subcollectionName).get();
     final int duration = randomm.nextInt(3);
    final Random random = new Random();
    List<Meeting> list = snapShotValue.docs
    .map((e) => Meeting(
      from: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['startTime']), 
      to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['startTime']).add(Duration(hours: duration == 0 ? 1 : duration)), 
      eventName: e.data()['fullName'], 
      background: colorCollection[random.nextInt(9)], 
      // isAllDay: false, 
      )).toList();
      setState(() {
        events = MeetingDataSource(list);
      });
  }



void initializeEventColor(){
  colorCollection.add( Colors.black);
  colorCollection.add( Colors.red);
  colorCollection.add( Colors.blue);
  colorCollection.add( Colors.blueAccent);
  colorCollection.add( Colors.green);
  colorCollection.add( Colors.yellow);
  colorCollection.add( Colors.orange);
  colorCollection.add( const Color.fromARGB(255, 145, 18, 18));
}


  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    final heightAppbar = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: const  Color.fromRGBO(7, 51, 72, 1),
      appBar: AppBar(backgroundColor: Colors.transparent,),

      body: RefreshIndicator(
                onRefresh: refesh,
        child: SizedBox(
          height: heightScreen- heightAppbar ,
          child: SfCalendar(
          
           
            view: CalendarView.week,
            initialDisplayDate: DateTime.now(),
            firstDayOfWeek: 6,
            monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            
         
            dataSource:  events,
     
          ),
        ),
      ),

    );
  }
  
}



class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Meeting> source){
    appointments =source;
  }

  @override
  DateTime getStartTime(int index){
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index){
    return appointments![index].to;
  }

  String getsubject(int index){
    return appointments![index].eventName;
  }



  @override
  Color getColor(int index){
    return appointments![index].background;
  }




}



class Meeting {
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  Meeting({
    

     required this.eventName,
    required this.from,
    required this.to,
    required this.background,
     this.isAllDay =false
  });
  
}