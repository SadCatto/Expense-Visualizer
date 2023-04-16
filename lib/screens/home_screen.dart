import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/utils/app_styles.dart';
import 'package:expense_tracker/utils/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 1;
  var currentButtonNo = 1;
  Color b1 = Colors.white;
  Color b2 = Colors.black;
  Color b3 = Colors.black;
  Color t1 = Colors.black;
  Color t2 = Colors.white;
  Color t3 = Colors.white;
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var data = {};
  List<dynamic> expenseList = [];
  List<dynamic> masterExpenseList = [];
  String userName = "";
  @override
  Widget build(BuildContext context) {
    final docRef = users.doc(currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        setState(() {
          userName = data['name'].toString();
          masterExpenseList = data['expenses'];
        });
        expenseList = getDailyExpense(data,currentButtonNo);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    final size = AppLayout.getSize(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Styles.primaryColor,
        title: Text("Expense Tracker",style: Styles.headLineStyle2,),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerUtil(userName: userName,),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(20)),
          child: Column(
            children: [
              Gap(AppLayout.getHeight(10)),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(225, 230, 255, 1),
                    borderRadius:
                        BorderRadius.circular(AppLayout.getHeight(25))),
                padding: EdgeInsets.symmetric(
                    vertical: AppLayout.getHeight(15),
                    horizontal: AppLayout.getWidth(15)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: size.width * 0.30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello $userName,",
                                    style: Styles.headLineStyle2.copyWith(
                                        fontSize: AppLayout.getWidth(20)),
                                  ),
                                ],
                              ),
                              Text(
                                "Manage your Expenses",
                                style: Styles.headLineStyle2
                                    .copyWith(fontSize: AppLayout.getWidth(20)),
                              )
                            ],
                          )),
                      Container(
                        width: size.width * 0.5,
                        height: AppLayout.getHeight(200),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/Asset 1.png"),
                                fit: BoxFit.contain)),
                      ),
                    ]),
              ),
              Gap(AppLayout.getHeight(20)),
              Container(
                  width: size.width * 0.9,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.circular(AppLayout.getHeight(25))),
                  padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getHeight(15),
                      horizontal: AppLayout.getWidth(15)),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: AppLayout.getHeight(100),
                          margin: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(5)),
                          decoration: BoxDecoration(
                              color: b1,
                              borderRadius: BorderRadius.circular(
                                  AppLayout.getHeight(15))),
                          child: TextButton(
                            onPressed: () {
                              List<dynamic> dailyExpense = [];
                                users.doc(currentUser!.uid).get().then(
                                      (DocumentSnapshot doc) {
                                   var userData = doc.data() as Map<String, dynamic>;
                                   setState(() {
                                     b1 = Colors.white;
                                     b2 = Colors.black;
                                     b3 = Colors.black;
                                     t1 = Colors.black;
                                     t2 = Colors.white;
                                     t3 = Colors.white;
                                     currentButtonNo = 1;
                                     expenseList = getDailyExpense(userData, 1);
                                   });
                                  },
                                  onError: (e) => print("Error getting document: $e"),
                                );
                            },
                            child: Text("Daily", style: Styles.headLineStyle3.copyWith(color: t1)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: AppLayout.getHeight(100),
                          margin: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(5)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppLayout.getHeight(15)),
                              color: b2),
                          child: TextButton(
                            onPressed: () {
                              List<dynamic> weeklyExpense = [];
                                users.doc(currentUser!.uid).get().then(
                                      (DocumentSnapshot doc) {
                                    var userData = doc.data() as Map<String, dynamic>;
                                    setState(() {
                                      b1 = Colors.black;
                                      b2 = Colors.white;
                                      b3 = Colors.black;
                                      t1 = Colors.white;
                                      t2 = Colors.black;
                                      t3 = Colors.white;
                                      currentButtonNo = 2;
                                      expenseList = getDailyExpense(userData, 2);
                                    });
                                  },
                                  onError: (e) => print("Error getting document: $e"),
                                );

                            },
                            child: Text("Monthly", style: Styles.headLineStyle3.copyWith(color: t2)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: AppLayout.getHeight(100),
                          margin: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(5)),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(15)),
                            color: b3,
                          ),
                          child: TextButton(
                            onPressed: () {
                              List<dynamic> monthlyExpense = [];
                              users.doc(currentUser!.uid).get().then(
                                    (DocumentSnapshot doc) {
                                  var userData = doc.data() as Map<String, dynamic>;
                                  setState(() {
                                    b1 = Colors.black;
                                    b2 = Colors.black;
                                    b3 = Colors.white;
                                    t1 = Colors.white;
                                    t2 = Colors.white;
                                    t3 = Colors.black;
                                    currentButtonNo = 3;
                                    expenseList = getDailyExpense(userData, 3);
                                  });
                                },
                                onError: (e) => print("Error getting document: $e"),
                              );


                            },
                            child:
                                Text("Yearly", style: Styles.headLineStyle3.copyWith(color: t3)),
                          ),
                        ),
                      ),
                    ],
                  )),
              Gap(AppLayout.getHeight(30)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
                width: size.width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expenses",
                      style: Styles.headLineStyle.copyWith(
                          fontSize: AppLayout.getHeight(36),
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/expense");
                        },
                        child: Text(
                          "+",
                          style: Styles.headLineStyle
                              .copyWith(fontSize: AppLayout.getWidth(36)),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenseList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: ListTile(
                        iconColor: Colors.black,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(expenseList[index]['category'],
                                style: Styles.headLineStyle2.copyWith(fontSize: AppLayout.getWidth(18))),
                            Expanded(child: Container(),),
                            TextButton(onPressed: (){
                              var removeIndex = masterExpenseList.indexOf(expenseList[index]);
                              setState(() {
                                masterExpenseList.removeAt(removeIndex);
                                users
                                    .doc(currentUser!.uid)
                                    .update({'expenses': masterExpenseList});
                              });
                            }, child: const Icon(Icons.delete,color: Colors.red,),
                            ),
                            Text(
                              expenseList[index]['amount'].toString(),
                              style: Styles.headLineStyle2.copyWith(fontSize: AppLayout.getWidth(18)),
                            ),
                          ],
                        ),
                        leading: Icon(Icons.currency_rupee,size: AppLayout.getHeight(18),),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


List<dynamic> getDailyExpense(data,fun){
  List<dynamic> expenseList = [];
  switch(fun){
    case 1 :
      for(var e in data['expenses']){
        if(e['date'].toDate().day == DateTime.now().day && e['date'].toDate().month == DateTime.now().month && e['date'].toDate().year == DateTime.now().year){
          expenseList.add(e);
        }
      }
       break;
    case 2 :
      for(var e in data['expenses']){
        if(e['date'].toDate().month == DateTime.now().month && e['date'].toDate().year == DateTime.now().year){
          expenseList.add(e);
        }
      }
      break;
    case 3:
      for(var e in data['expenses']){
        if(e['date'].toDate().year == DateTime.now().year){
          expenseList.add(e);
        }
      }
      break;
  }
  return expenseList;
}







