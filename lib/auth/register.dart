
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mgmt/firebase_services/auth.dart';
import 'package:mgmt/screens/mobile_web_page.dart';
import 'package:mgmt/widgets/contants.dart';
import 'package:mgmt/widgets/snack_bar.dart';


import 'log_in.dart';


import 'package:path/path.dart' show basename;


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final phoneNumberController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final nameController = TextEditingController();

  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);

    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  clickOnRegister() async {
    if (_formKey.currentState!.validate() &&
        imgName != null &&
        imgPath != null) {
      setState(() {
        isLoading = true;
      });
      await AuthMethods().register(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context,
        titleee: titleController.text,
        phoneNumber: phoneNumberController.text,
        imgName: imgName,
        imgPath: imgPath,
        nameee: nameController.text, salary: "", 
        birthday: "", startedDate: "",
        // lastActive: null,
      );
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MobileScreen()),
      );
    } else {
      showSnackBar(context, "ERROR");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      
      backgroundColor: const Color.fromRGBO(7, 51, 72, 1),
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        margin: widthScreen > 600
            ? EdgeInsets.symmetric(vertical: 55, horizontal: widthScreen / 6)
            : null,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const  SizedBox(height: 30,),
                    Image.asset("assets/img/konya_logo copy.png", height: 150,),
                    const SizedBox(height: 40,),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(146,146,147, 1),
                      ),
                      child: Stack(
                        children: [
                          imgPath == null
                              ? const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 244, 244, 244),
                                  radius: 71,
                                  // backgroundImage: AssetImage("assets/img/avatar.png"),
                                  backgroundImage:
                                      AssetImage("assets/img/Icon-512.png"),
                                )
                              : CircleAvatar(
                                  radius: 71,
                                  // backgroundImage: AssetImage("assets/img/avatar.png"),
                                  backgroundImage: MemoryImage(imgPath!),
                                ),
                          Positioned(
                            left: 88,
                            bottom: -10,
                            child: IconButton(
                              onPressed: () {
                                // uploadImage2Screen();
                                showmodel();
                              },
                              icon: const Icon(Icons.add_a_photo_outlined, size: 40,),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
            
                    TextFormField(
                        validator: (value) {
                          return value!.isEmpty ? "Can Not be empty" : null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        style: const TextStyle(color: Colors.black),
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter  Full Name : ",
                            suffixIcon: const Icon(Icons.person))),
                    const SizedBox(
                      height: 22,
                    ),
            
                    
                    
                    TextFormField(
                        validator: (value) {
                          return value!.isEmpty ? "Can Not be empty" : null;
                        },
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                                                style: const TextStyle(color: Colors.black),

                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Position Job : ",
                            suffixIcon: const Icon(Icons.work))),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        validator: (value) {
                          return value!.isEmpty ? "Can Not be empty" : null;
                        },
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                                                style: const TextStyle(color: Colors.black),

                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Phone Number : ",
                            suffixIcon: const Icon(Icons.phone_callback))),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        // we return "null" when something is valid
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Enter a valid email";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                                                style: const TextStyle(color: Colors.black),

                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: const Icon(Icons.email_outlined))),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                        onChanged: (password) {},
                        // we return "null" when something is valid
                        validator: (value) {
                          return value!.length < 6
                              ? "Enter at least 6 characters"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isVisable ? true : false,
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
                      height: 15,
                    ),
            
                    ElevatedButton(
                      onPressed: () async {
                        clickOnRegister();
                      },
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(fontSize: 19),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
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
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text('sign in',
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
