import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'app_styles.dart';
import 'layout.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DrawerUtil extends StatelessWidget {
  final String userName;
  const DrawerUtil({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Styles.primaryColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(AppLayout.getHeight(120)),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: AppLayout.getWidth(50),
              foregroundImage: const AssetImage("assets/images/money.png"),
            ),
            Gap(AppLayout.getHeight(10)),
            TextButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, '/home');
                },
                child: Text(userName,style: Styles.headLineStyle2,)),
            TextButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, '/home');
                },
                child: Text("Home",style: Styles.headLineStyle2,)),
            TextButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, '/analytics');
                },
                child: Text("Analytics",style: Styles.headLineStyle2,)),
            TextButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text("Logout",style: Styles.headLineStyle2,)),
          ],
        ),
      ),
    );
  }
}
