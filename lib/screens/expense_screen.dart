import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/utils/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/app_styles.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String selectedValue = "Miscellaneous";
  TextEditingController amountController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    TextEditingController expenseController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(20),
              vertical: AppLayout.getHeight(60)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppLayout.getWidth(120),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              BorderRadius.circular(AppLayout.getHeight(25))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: AppLayout.getHeight(25),
                              color: Colors.black,
                            ),
                            Text(
                              "Back",
                              style: Styles.headLineStyle3.copyWith(
                                  color: Colors.black,
                                  fontSize: AppLayout.getHeight(20)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "New Expense",
                      style: Styles.headLineStyle2,
                    )
                  ],
                ),
                Gap(AppLayout.getHeight(40)),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(AppLayout.getHeight(17))),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusColor: Colors.grey,
                      iconColor: Colors.black,
                      icon: Icon(Icons.currency_rupee_rounded),
                      alignLabelWithHint: true,
                      hintText: "Amount",
                    ),
                    style: Styles.headLineStyle
                        .copyWith(fontSize: AppLayout.getHeight(30)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                DropdownButton(
                    focusColor: Colors.grey,
                    iconEnabledColor: Styles.orangeColor,
                    dropdownColor: Styles.primaryColor,
                    menuMaxHeight: size.height * 0.4,
                    borderRadius:
                        BorderRadius.circular(AppLayout.getHeight(15)),
                    style: Styles.headLineStyle2
                        .copyWith(fontWeight: FontWeight.w500),
                    value: selectedValue,
                    items: [
                      DropdownMenuItem(
                          value: "Miscellaneous",
                          child: Row(
                            children: const [
                              Icon(Icons.currency_rupee),
                              Text("  Miscellaneous"),
                            ],
                          )),
                      DropdownMenuItem(
                          value: "Food",
                          child: Row(
                            children: const [
                              Icon(Icons.local_pizza_rounded),
                              Text("  Food"),
                            ],
                          )),
                      DropdownMenuItem(
                          value: "Shopping",
                          child: Row(
                            children: const [
                              Icon(Icons.shopping_cart),
                              Text("  Shopping"),
                            ],
                          )),
                      DropdownMenuItem(
                          value: "Rent",
                          child: Row(
                            children: const [
                              Icon(Icons.home),
                              Text("  Rent"),
                            ],
                          )),
                      DropdownMenuItem(
                          value: "Friend",
                          child: Row(
                            children: const [
                              Icon(Icons.person),
                              Text("  Friend"),
                            ],
                          )),
                      DropdownMenuItem(
                          value: "Groceries",
                          child: Row(
                            children: const [
                              Icon(Icons.food_bank),
                              Text("  Groceries"),
                            ],
                          )),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue.toString();
                      });
                    }),
                Gap(AppLayout.getHeight(25)),
                TextButton(
                  onPressed: () {
                    var expenses = [];
                    final docRef = users.doc(currentUser!.uid);
                    docRef.get().then(
                      (DocumentSnapshot doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        expenses = data['expenses'];
                        expenses.add({
                          'category': selectedValue.toString(),
                          'amount': double.parse(amountController.text.toString()),
                          'date': DateTime.now()
                        });
                        users
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'expenses': expenses,
                        });
                        amountController.clear();
                      },
                      onError: (e) => print("Error getting document: $e"),
                    );
                  },
                  child: Text("Save", style: Styles.headLineStyle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
