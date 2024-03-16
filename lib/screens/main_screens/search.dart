import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mgmt/Screens/reservation_info_screen.dart';
import 'package:mgmt/generated/l10n.dart';


class SearchScreen extends StatefulWidget {
  final String subcollectionID;
  final String subcollectionName;
  const SearchScreen({super.key, required this.subcollectionID, 
  required this.subcollectionName});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Color textLabelColor = Colors.white.withOpacity(0.8);
  final Color textColor = Colors.white;
    final phoneNumberController = TextEditingController();

  final myController = TextEditingController();

  // @override
  // void initState() {

  //   super.initState();
  //   myController.addListener(ddddd);
  // }

  // ddddd() {
  //   setState(() {

  //   });
  // }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:const  Color.fromRGBO(7, 51, 72, 1),
      appBar: AppBar(
        toolbarHeight: 100,
          // backgroundColor: Colors.white.withOpacity(0.1),
          backgroundColor: Colors.transparent,
          title: SizedBox(
            height: 100,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: 
                IntlPhoneField(
                  showDropdownIcon: true,
                  dropdownTextStyle: const TextStyle(
                      color: Colors.white, fontSize: 16),
    
                  pickerDialogStyle: PickerDialogStyle(
                    countryCodeStyle: const TextStyle(
                      color: Color.fromARGB(255, 250, 200, 119),
                    ),
                    countryNameStyle: const TextStyle(
                      color: Color.fromARGB(255, 250, 200, 119),
                    ),
                    backgroundColor: const Color.fromARGB(255, 3, 2, 45),
                  ),
                  onChanged: (phone) {
                    setState(() {
                      phoneNumberController.text = phone.completeNumber;
                    });
                    // print(phone.completeNumber);
                  },
                  // controller: phoneNumberController,
                  initialCountryCode: "IQ",
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIconColor: textLabelColor,
                      counterStyle: TextStyle(
                        color: textLabelColor,
                      ),
                      border: const OutlineInputBorder(),
                      // labelText: S.of(context).write_your_phonenumber,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      suffixIconColor: textLabelColor,
                      hoverColor: textLabelColor,
                      labelStyle: TextStyle(
                          color: textLabelColor)),
                  style: TextStyle(color: textColor),
                ),
                
                // TextFormField(
                //   maxLength: 14,
                              
                //   onChanged: (value) {
                //     setState(() {});
                //   },
                //   controller: myController,
                //   keyboardType: TextInputType.phone,
                //   decoration: InputDecoration(
                //    counterStyle: const TextStyle(fontSize: 10),
                    
                //     border: OutlineInputBorder(
                      
                //       borderRadius: BorderRadius.circular(11),
                //     ),
                //     // hintText: 'Search for a user...',
                //     // helperText: 'write user name...',
                      
                //     labelText: '${S.of(context).search_by_phone_number}...',
                //     // label: Text("gdhd"),
                //   ),
                // ),
             
              ),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: Colors.white.withOpacity(0.7),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Reservations').doc(widget.subcollectionID).collection(widget.subcollectionName)
                  .where("phoneNumber", isEqualTo: phoneNumberController.text)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
    
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 3, bottom: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                   color:snapshot.data!.docs[index]["isDontCame"] == "Yes" ? Colors.red : Colors.green),
                                
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReservationInfoScreen(
                                              uiddd: snapshot
                                                  .data!.docs[index]["reservationID"], 
                                                  subcollectionID: widget.subcollectionID, 
                                                  subcollectionName: widget.subcollectionName,
                                            )));
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          snapshot.data!.docs[index]["fullName"]),
                                           Text(
                                          snapshot.data!.docs[index]["phoneNumber"]),
                                    ],
                                  ),
                                      Text(
                                      snapshot.data!.docs[index]["reservationDate"]),
                                ],
                              ),
    
                              leading: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color:snapshot.data!.docs[index]["isDontCame"] == "Yes" ? Colors.red : Colors.green)),
                                padding: const EdgeInsets.all(2.5),
                                child: Text(
                                      snapshot.data!.docs[index]["tableNo"], style: const TextStyle(fontSize: 20),),),
                            ),
                          ),
                        );
                      });
                }
    
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
