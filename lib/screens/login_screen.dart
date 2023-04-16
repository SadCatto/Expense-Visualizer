import 'package:expense_tracker/utils/app_styles.dart';
import 'package:expense_tracker/utils/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: AppLayout.getHeight(40),
              horizontal: AppLayout.getWidth(15)),
          padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(40)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Login", style: Styles.headLineStyle),
                Gap(AppLayout.getHeight(20)),
                TextFormField(
                  controller: emailController,
                  style: Styles.headLineStyle2
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  enableSuggestions: false,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                Gap(AppLayout.getHeight(10)),
                TextFormField(
                  controller: passwordController,
                  enableSuggestions: false,
                  obscureText: true,
                  obscuringCharacter: '.',
                  style: Styles.headLineStyle2
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                Gap(AppLayout.getHeight(40)),
                Container(
                  width: AppLayout.getWidth(200),
                  decoration: BoxDecoration(
                      color: Styles.orangeColor,
                      borderRadius: BorderRadius.circular(AppLayout.getHeight(10))
                  ),
                  child: TextButton(
                      onPressed: () async{
                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString()
                          );
                          Navigator.popAndPushNamed(context, '/home');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      child: Text("Login",style: Styles.headLineStyle2,)),
                ),
                Gap(AppLayout.getHeight(40)),
                TextButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, '/signup');
                  },
                  child: Text("Register Now",style: Styles.headLineStyle,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
