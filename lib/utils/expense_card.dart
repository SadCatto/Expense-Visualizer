import 'package:flutter/material.dart';

import 'layout.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width * 0.80,
      height: size.height * 0.25,
      child: Container(
        margin: EdgeInsets.only(right: AppLayout.getHeight(16)),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(AppLayout.getHeight(15))
        ),
      ),
    );
  }
}
