import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mgmt/auth/log_in.dart';
import 'package:mgmt/screens/mobile_web_page.dart';
import 'package:mgmt/widgets/snack_bar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  signIn({required emailll, required passworddd, required context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }
  }
  


  @override
  void initState() {
    super.initState();
    navigatortoMenu();
    
    
  }

  navigatortoMenu() async{
    await Future.delayed(const Duration(seconds: 5), (){
      
    // signIn(context: context, passworddd: "123456", emailll: 'web@gmail.com').whenComplete((){

      
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MobileScreen() ));

    // });
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> 
    StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      } else if (snapshot.hasError) {
                        return showSnackBar(context, "Something went wrong");
                      } else if (snapshot.hasData) {
                        return
                            // VerifyEmailPage();
                            const MobileScreen();
                      } else {
                        return const Login();
                      }
                    },
                  )
                  
                  )
                  
                  );
  }




  
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Container(
        height: heightScreen,
        width: widthScreen,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue, Colors.purple
          ],begin:Alignment.topRight, end: Alignment.bottomLeft )),
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset("assets/img/Icon-512.png", height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      
      
      const SizedBox(height: 100.0),
      DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Brando-Bold',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            RotateAnimatedText('مرحبا بكم في مطعم كونيا',),
            RotateAnimatedText('Welcome to Konya Restaurant'),
            RotateAnimatedText('Konya Restoran\'a Hoş Geldiniz'),
            RotateAnimatedText('بەخێربێن بۆ چێشتخانەی کۆنیا'),
          ],
          onTap: () {
             print("Tap Event");
          },
        ),
      ),
        ],
      )
          ],),
      ),
    );
  }
}