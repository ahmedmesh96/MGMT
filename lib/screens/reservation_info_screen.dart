import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mgmt/contantt.dart';
import 'package:mgmt/firebase_services/firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mgmt/generated/l10n.dart';
import 'package:mgmt/widgets/contants.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationInfoScreen extends StatefulWidget {
  final String uiddd;
  final String subcollectionID;
  final String subcollectionName;
  const ReservationInfoScreen(
      {super.key,
      required this.uiddd,
      required this.subcollectionID,
      required this.subcollectionName});

  @override
  State<ReservationInfoScreen> createState() => _ReservationInfoScreenState();
}

class _ReservationInfoScreenState extends State<ReservationInfoScreen> {
  late String tokenSender;
  final _formKey = GlobalKey<FormState>();
  final tableNoController = TextEditingController();

  Future<void> captureAndSaveImage() async {
    final Uint8List? uint8list = await screenshotController.capture();
    if (uint8list != null) {
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        final result = await ImageGallerySaver.saveImage(uint8list);
        if (result['isSuccess']) {
          print("Image Saved To Gallery");
        } else {
          print("Failed to save image: ${result}");
        }
      } else {
        print("Permission to access storage denied");
      }
    }
  }

  saveToGallery() {
    screenshotController.capture().then((Uint8List? image) async {
      saveScreenshot(image!);
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("Iamge saved to Gallery"))
    // );
  }

  saveScreenshot(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = 'ScreenShot$time';
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  Future<void> refesh() {
    return Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tableNoController.dispose();
    super.dispose();
  }

  Map userData = {};
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Reservations')
          .doc(widget.subcollectionID)
          .collection(widget.subcollectionName)
          .doc(widget.uiddd)
          .get();

      userData = snapshot.data()!;

      //
    } catch (e) {
      // print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    String generateQRData() {
      return "${userData["fullName"]}\n${userData['phoneNumber']}\n${userData['reservationDate']}\n${userData['guestsCount']}";
    }

    final double widthScreen = MediaQuery.of(context).size.width;
    //  Uri phoneNumber = Uri(scheme: 'tel', path: '567898766545');
    //  callNumber()async{
    //   await launchUrl(phoneNumber);
    //  }

    //  directcall ()async{
    //   await FlutterPhoneDirectCaller.callNumber("567898766545");
    //  }
    final Uri whatsApp = Uri.parse("https://wa.me/${userData['phoneNumber']}");

    return isLoading
        ? const Scaffold(
            backgroundColor: Color.fromRGBO(7, 51, 72, 1),
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(7, 51, 72, 1),
            appBar: AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "",
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation1, animation2) {
                          return Container();
                        },
                        transitionBuilder: (context, a1, a2, widget) {
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ScaleTransition(
                                      scale: Tween<double>(begin: 0.5, end: 1.0)
                                          .animate(a1),
                                      child: Screenshot(
                                        controller: screenshotController,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 350,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        34, 33, 49, 1),
                                                    Color.fromRGBO(
                                                        58, 49, 73, 1),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Stack(
                                                children: [
                                                  Center(
                                                      child: Opacity(
                                                          opacity: 0.1,
                                                          child: Image.asset(
                                                            "assets/img/Icon-512.png",
                                                            height: 100,
                                                          ))),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            userData[
                                                                "fullName"],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          Text(
                                                            userData[
                                                                'phoneNumber'],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        "${userData['reservationDate']} - ${userData["reservationTime"]}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    204,
                                                                    0)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11)),
                                                    height: 100,
                                                    width: 100,
                                                    child: QrImageView(
                                                      data: generateQRData(),
                                                      version: QrVersions.auto,
                                                      gapless: false,
                                                      size: 90,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Table No : ${userData['tableNo']}",
                                                    style: const TextStyle(
                                                        color: Colors.white10),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await saveToGallery();
                                        setState(() {
                                          Navigator.pop(context);
                                        });

                                        // launchUrl(whatsApp, );

                                        // setState(() {
                                        //   // Navigator.pop(context);
                                        // });
                                      },
                                      child: Text(S
                                          .of(context)
                                          .save_the_card_to_the_gallery)),
                                  // ElevatedButton(onPressed: ()async{
                                  //   final urlImage ="data:image/jpeg;base64,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";
                                  //   final url = Uri.parse(urlImage);
                                  //   final response = await http.get(url);
                                  //   final bytes = response.bodyBytes;
                                  //   final temp = await getTemporaryDirectory();
                                  //   final path = "${temp.path}/image.ipg";
                                  //   File(path).writeAsBytesSync(bytes);
                                  //   await Share.shareFiles(text: "konya", [path]);
                                  // }, child: Text("Share"))
                                ],
                              ),
                            ),
                          );
                          //   FadeTransition(
                          //     opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                          //     child: AlertDialog(
                          //       content: Text(
                          //         S.of(context).thanks,
                          //         textAlign: TextAlign.center,
                          //         style: const TextStyle(fontFamily: "Brando-Regular"),
                          //       ),
                          //       shape: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(16),
                          //           borderSide: BorderSide.none),
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    },
                    icon: const Icon(Icons.qr_code))
              ],
              iconTheme:
                  const IconThemeData(color: Color.fromRGBO(228, 198, 144, 1)),
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Image.asset(
                  "assets/img/konya_logo.png",
                  height: 40,
                ),
              ),
              backgroundColor: const Color.fromRGBO(21, 8, 88, 1),
            ),
            body: RefreshIndicator(
              onRefresh: refesh,
              child: SizedBox(
                  // color: Colors.amber,

                  child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      //  Text((index +1).toString()),
                      //----------******   "معلومات الزبون". ****--------------//
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: userData['isDontCame'] == "Yes"
                                ? Colors.red
                                : userData['isCame'] == "Yes"
                                    ? Colors.green
                                    : Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 2, color: Colors.black)),
                        child: Column(children: [
                          const Text(
                            "معلومات الزبون",
                            style: TextStyle(
                                fontFamily: "ReemKufiFun",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: widthScreen,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "اسم الزبون : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userData['fullName'],
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "رقم التلفون : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userData['phoneNumber'],
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'tel',
                                              path: userData['phoneNumber']);
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('cannot lanch this url');
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 40,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/img/phone.png"))),
                                          padding: const EdgeInsets.all(5),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          launchUrl(whatsApp);
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(
                                              "assets/img/whatsapp.png",
                                              height: 30,
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "الايميل : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      userData['email'],
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),

                      //----------****** "اقتراحات وجبة السحور"  ****--------------//
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: userData['isDontCame'] == "Yes"
                                ? Colors.red
                                : userData['isCame'] == "Yes"
                                    ? Colors.green
                                    : Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 2, color: Colors.black)),
                        child: Column(children: [
                          const Text(
                            "معلومات الحجز",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: widthScreen,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "مناسبةالدعوى : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: Text(
                                        userData['reservationOccasion'],
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "تاريخ الدعوى : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: Text(
                                        " ${userData['reservationDate']}  -- ${userData['reservationTime']} ",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "عدد الضيوف : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: Text(
                                        userData['guestsCount'],
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "مناسبة الدعوى : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: Text(
                                        userData['reservationOccasion'],
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "طلبات اخرى  : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: Text(
                                        userData['requests'],
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "رقم الطاولة  : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: widthScreen * 0.5,
                                      child: userData['tableNo'] == "***"
                                          ? Text(tableNoController.text)
                                          : Text(
                                              userData['tableNo'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),

                      const SizedBox(
                        height: 33,
                      ),

                      SizedBox(
                        width: widthScreen,
                        child: Row(
                          children: [
                            Container(
                              width: widthScreen * 0.6,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                  // validator: (value) {
                                  //   return value!.isEmpty
                                  //       ? "Can Not be empty"
                                  //       : null;
                                  // },
                                  controller: tableNoController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: decorationTextfield.copyWith(
                                      fillColor:
                                          const Color.fromARGB(255, 41, 4, 144),
                                      hintText: "Put Number of table : ",
                                      suffixIcon: const Icon(
                                          Icons.table_bar_outlined))),
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(228, 198, 144, 1))),
                                onPressed: () {
                                  setState(() {
                                    putNoOfTable();
                                  });
                                },
                                child: const Text(
                                  "ثبت رقم الطاولة",
                                  style: TextStyle(
                                      color: Color.fromRGBO(138, 0, 47, 1)),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    

                     
                      Container(
                       
                        width: widthScreen,
                        
                        padding: const EdgeInsets.all(10),
                        child: Column(
                         
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                button(
                                    color: Colors.orange,
                                    onTap: () {
                                sendToConfirme().whenComplete(() {
                                  pushNotificationsToSender(
                                      token: userData['tokenSender'],
                                      title: userData['fullName'],
                                      body:
                                          " تم تثبيت حجزك في تاريخ  ${userData['reservationDate']} ${userData['reservationTime']}");
                                });
                                Navigator.pop(context);
                                print(
                                    "sender Token : ${userData['tokenSender']}");
                              },
                                    lable: "تأكيد الحجز"),

                                    button(
                                    color: Colors.yellow,
                                    onTap: () {
                                setState(() {
                                  sendToArchivee(
                                    isDontCame: "No",
                                    iscame: "Yes"
                                  );
                                  Navigator.pop(context);
                                });
                              },
                                    lable: "أرشيف"),
                                button(
                                    color: Colors.red,
                                    onTap: () {
                              showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: "",
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return Container();
                                  },
                                  transitionBuilder: (context, a1, a2, widget) {
                                    return ScaleTransition(
                                      scale: Tween<double>(begin: 0.5, end: 1.0)
                                          .animate(a1),
                                      child: FadeTransition(
                                        opacity:
                                            Tween<double>(begin: 0.5, end: 1.0)
                                                .animate(a1),
                                        child: AlertDialog(
                                          content: Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).are_you_sure,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Brando-Regular"),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("رجوع")),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            delete();
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: const Text("حذف"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    );
                                  });
                            },
                                    lable: "حذف"),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                              button(onTap: () {
                                setState(() {
                                  sendToArchivee(
                                    isDontCame: "Yes",
                                    iscame: "No"
                                  );
                                  Navigator.pop(context);
                                });
                              }, color: Colors.redAccent, lable: "لم يحضر")

                             , button(onTap: () {
                                  setState(() {
                                    sendToHere();
                                    Navigator.pop(context);
                                  });
                                }, color: Colors.green, lable: "اتى")


                            ],)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ));
  }

  Widget button(
      {required Function() onTap,
      required Color color,
      required String lable}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 180,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: color,
                blurRadius: 10,
                spreadRadius: 2,
                blurStyle: BlurStyle.outer,
                offset: Offset.fromDirection(0))
          ],
        ),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Text(
          lable,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Future<void> putNoOfTable() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .update({'tableNo': tableNoController.text})
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> isHere() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .update({
          'isCame': "Yes",
          'isDontCame': "No",
          'newReservation': "No",
          'archive': "No",
          'confirme': "Yes",
        })
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> isDontCame() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .update({
          'isCame': "No",
          'isDontCame': "Yes",
          'newReservation': "No",
          'archive': "Yes",
          'confirme': "No",
        })
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .delete()
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> sendToArchive() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .update({
          'newReservation': "No",
          'archive': "Yes",
          'confirme': "No",
        })
        .then((value) => setState(() {}))
        .catchError((error) => Navigator.pop(context));
  }

  Future<void> sendToComfirme() async {
    return await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .update({
          'newReservation': "No",
          'archive': "No",
          'confirme': "Yes",
        })
        .then((value) => setState(() {}))
        .catchError((error) => print("Failed to update user: $error"));
  }

  //------- Send notification to sender -------//
  Future<bool> pushNotificationsToSender({
    required String token,
    required String title,
    required String body,
  }) async {
    String dataNotifications = '{ "to" : "$token",'
        ' "notification" : {'
        ' "title":"$title",'
        '"body":"$body"'
        ' }'
        ' }';

    await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.KEY_SERVER}',
      },
      body: dataNotifications,
    );
    return true;
  }

  sendToArchivee({required String iscame, required String isDontCame}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await FireStoreMethods().uploadReservation(
        fullName: userData['fullName'],
        phoneNumber: userData['phoneNumber'],
        email: userData['email'],
        reservationOccasion: userData['reservationOccasion'],
        reservationDate: userData['reservationDate'],
        reservationTime: userData['reservationTime'],
        guestsCount: userData['guestsCount'],
        requests: userData['requests'],
        context: context,
        tableNo: tableNoController.text == null
            ? userData['tableNo'] == "***"
            : tableNoController.text,
        reservationID: userData['reservationID'],
        collectionReference: 'archive',
        newReservation: "No",
        confirme: 'Yes',
        archive: "Yes",
        uid: userData['uid'],
        startTime: userData['startTime'],
        collectionReferenceID: "archives", isCame: iscame, isDontCame: isDontCame,
        // tokenSender: tokenSender
      );
      setState(() {
        FirebaseFirestore.instance
            .collection('Reservations')
            .doc(widget.subcollectionID)
            .collection(widget.subcollectionName)
            .doc(userData['reservationID'])
            .delete();

        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pop(context);
    } else {}
  }

  sendToConfirme() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await FireStoreMethods().uploadReservation(
        fullName: userData['fullName'],
        phoneNumber: userData['phoneNumber'],
        email: userData['email'],
        reservationOccasion: userData['reservationOccasion'],
        reservationDate: userData['reservationDate'],
        reservationTime: userData['reservationTime'],
        guestsCount: userData['guestsCount'],
        requests: userData['requests'],
        context: context,
        tableNo: tableNoController.text == null
            ? userData['tableNo'] == "***"
            : tableNoController.text,
        reservationID: userData['reservationID'],
        collectionReference: 'ConfirmeReservations',
        newReservation: "No",
        confirme: 'Yes',
        archive: "No",
        uid: userData['uid'],
        startTime: userData['startTime'],
        collectionReferenceID: "confirmeResrervatins",
        isCame: "No",
        isDontCame: "No",
        // tokenSender: tokenSender
      );
      setState(() {
        FirebaseFirestore.instance
            .collection('Reservations')
            .doc(widget.subcollectionID)
            .collection(widget.subcollectionName)
            .doc(userData['reservationID'])
            .delete();

        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pop(context);
    } else {}
  }

  sendToHere() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await FireStoreMethods().uploadReservation(
        fullName: userData['fullName'],
        phoneNumber: userData['phoneNumber'],
        email: userData['email'],
        reservationOccasion: userData['reservationOccasion'],
        reservationDate: userData['reservationDate'],
        reservationTime: userData['reservationTime'],
        guestsCount: userData['guestsCount'],
        requests: userData['requests'],
        context: context,
        tableNo: tableNoController.text == null
            ? userData['tableNo'] == "***"
            : tableNoController.text,
        reservationID: userData['reservationID'],
        collectionReference: 'Here',
        newReservation: "No",
        confirme: 'Yes',
        archive: "No",
        uid: userData['uid'],
        startTime: userData['startTime'],
        collectionReferenceID: "here",
        isCame: "Yes",
        isDontCame: "No",
        // tokenSender: tokenSender
      );
      setState(() {
        FirebaseFirestore.instance
            .collection('Reservations')
            .doc(widget.subcollectionID)
            .collection(widget.subcollectionName)
            .doc(userData['reservationID'])
            .delete();

        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pop(context);
    } else {}
  }

  delete() async {
    await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(widget.subcollectionID)
        .collection(widget.subcollectionName)
        .doc(userData['reservationID'])
        .delete()
        .whenComplete(() {
      Navigator.pop(context);
    });
  }
}
