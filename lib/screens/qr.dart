
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';





class QRCodeGenerator extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String guestsCount;
  final String date;

  const QRCodeGenerator({super.key, required this.fullName, required this.phoneNumber, required this.date, required this.email, required this.guestsCount, });

  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
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


  String generateQRData(){
    return "${widget.fullName}\n${widget.phoneNumber}\n${widget.date}\n${widget.guestsCount}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromRGBO(228, 198, 144, 1)),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Image.asset(
            "assets/img/konya_logo.png",
            height: 40,
          ),
        ),
       
        backgroundColor: const Color.fromRGBO(21, 8, 88, 1),
      ),
      
       backgroundColor:const Color.fromARGB(255, 67, 20, 35),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(controller: screenshotController,
              child: cartImage()),
            
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: ()async{
              await captureAndSaveImage();
    
            }, child: const  Text("Caputer Image"))
          ],
        ),
      ),
    );
  }


  Widget cartImage(){
    return Container(
              padding: const EdgeInsets.all(10),
              width: 350,
              height: 200,
              decoration: const  BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                gradient: LinearGradient(colors: [
                   Color.fromRGBO(34,33,49, 1),
                   Color.fromRGBO(58,49,73, 1),
                  
             
                ],
                begin: Alignment.topLeft, end: Alignment.bottomRight)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
             
                Stack(
                  children: [
                    Center(child: Opacity( opacity: 0.1 ,child: Image.asset("assets/img/Icon-512.png", height: 100,))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(widget.fullName,
                          style: const TextStyle(
                                                  color: Colors.white),),
                        
                                                  Text(widget.phoneNumber,
                          style: const TextStyle(
                                                  color: Colors.grey),)
                        ],),
                        Text(widget.date,
                      style: const TextStyle( fontSize: 12,
                                              color: Color.fromARGB(255, 255, 204, 0)),)
                      ],
                    ),
                    
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                   
                        color: Colors.white,borderRadius: BorderRadius.circular(11)),
                          height: 100,
                          width: 100,
                          child:QrImageView(data: generateQRData(), 
              version: QrVersions.auto,
              gapless: false,
              size: 90,
              
              ),
                          
                         
                        ),
             
                        const Text( "Table No : 2", style: TextStyle(color: Colors.white10),)
                  ],
                )
                
              ],),
             );
           
  }



Future<String> saveImage(Uint8List bytes) async{
  await [Permission.storage].request();
  final name = 'cart_${widget.fullName}';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);

  return result['filePath'];
}
}