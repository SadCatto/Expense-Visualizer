import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/app_styles.dart';
import '../utils/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getHeight(20),
                  horizontal: AppLayout.getHeight(20)),
              // height: size.height * 0.5,
              width: size.width * 0.8,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.6,
                    height: AppLayout.getHeight(200),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/money.png"),)
                    ),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Text(
                    "Create an account",
                    style: Styles.headLineStyle,
                  ),
                  Gap(AppLayout.getHeight(10)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500,fontSize: AppLayout.getHeight(20)),
                          decoration: const InputDecoration(
                              labelText: "Name"
                          ),
                        ),
                        Gap(AppLayout.getHeight(10)),
                        TextFormField(
                          controller: emailController,
                          style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500,fontSize: 20),
                          enableSuggestions: false,
                          decoration: const InputDecoration(
                              labelText: "Email"
                          ),
                        ),
                        Gap(AppLayout.getHeight(10)),
                        TextFormField(
                          controller: passwordController,
                          enableSuggestions: false,
                          obscureText: true,
                          obscuringCharacter: '.',
                          style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500,fontSize: 20),
                          decoration: const InputDecoration(
                              labelText: "Password"
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(AppLayout.getHeight(20)),
                  Container(
                    width: AppLayout.getWidth(200),
                    decoration: BoxDecoration(
                      color: Styles.orangeColor,
                      borderRadius: BorderRadius.circular(AppLayout.getHeight(10))
                    ),
                    child: TextButton(
                        onPressed: () async{
                            try {
                              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString()
                              );
                              users.doc(userCredential.user!.uid).set(
                                  {
                                    'name' : nameController.text.toString(),
                                    'email' : emailController.text.toString(),
                                    'expenses' : [],
                                  }
                              );
                              Navigator.popAndPushNamed(context, '/home');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print('The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                        },
                        child: Text("Register",style: Styles.headLineStyle2,)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

