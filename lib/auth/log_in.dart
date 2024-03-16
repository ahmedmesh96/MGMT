

import 'package:flutter/material.dart';
import 'package:mgmt/firebase_services/auth.dart';
import 'package:mgmt/screens/mobile_web_page.dart';
import 'package:mgmt/widgets/contants.dart';
import 'package:mgmt/widgets/snack_bar.dart';
import 'register.dart';
import 'forgot_passowrd.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn() async {
    setState(() {
      isLoading = true;
    });

    await AuthMethods().signIn(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;
    
    
    showSnackBar(context, "successfully sign-in ");
  }

  //* google sign in *///

  
//***************************************** */

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Container(
      height: heightScreen,
      width: widthScreen,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(14,13,11, 0)
      ),
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(7, 51, 72, 1),
          body: Container(
            
            margin: widthScreen > 600
                ? EdgeInsets.symmetric(
                    vertical: 55, horizontal: widthScreen / 6)
                : null,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/konya_logo copy.png", height: 150,),
                      const SizedBox(
                        height: 164,
                      ),
                      TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Email : ",
                              
                              suffixIcon: const Icon(Icons.email))),
                      const SizedBox(
                        height: 33,
                      ),
                      TextField(
                        
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: isVisable ? false : true,
                          style: const TextStyle(color: Colors.black),
                          decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Password : ",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisable = !isVisable;
                                    });
                                  },
                                  icon: isVisable
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)))),
                      const SizedBox(
                        height: 33,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          signIn();
                        },
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all(BTNgreen),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign in",
                                style: TextStyle(fontSize: 19),
                              ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Do not have an account?",
                              style: TextStyle(fontSize: 18)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()),
                                );
                              },
                              child: const Text('sign up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline))),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()),
                            );
                          },
                          child: const Text(
                            "forget password?",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          )),
                      
                      
                    ]),
              ),
            )),
          )),
    );
  }
}
