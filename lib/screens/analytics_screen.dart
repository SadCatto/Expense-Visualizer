import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/utils/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/app_styles.dart';
import '../utils/layout.dart';

class AnalyticsScreen extends StatefulWidget {

  const AnalyticsScreen({Key? key}) : super(key: key);
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<dynamic> expenseList = [];
  List<dynamic> monthExpenseList = [];
  int month = DateTime.now().month;
  double max = 0.0;
  String userName = "";
  late DateTime date;
  List<Color> gradientColors = [
    Colors.yellow,
    Colors.blue,
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    final docRef = users.doc(currentUser!.uid);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          userName = data['name'].toString();
          expenseList = data['expenses'];
          monthExpenseList = data['expenses'].where( (el) => el['date'].toDate().month == month ).toList();
        });
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: AppLayout.getSize(context).height * 0.5,
                color: Colors.black,
                margin: EdgeInsets.fromLTRB(AppLayout.getWidth(5), AppLayout.getHeight(10), AppLayout.getWidth(5), AppLayout.getHeight(10)),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: AppLayout.getWidth(18),
                    left: AppLayout.getWidth(12),
                    top: AppLayout.getHeight(24),
                    bottom: AppLayout.getHeight(12),
                  ),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
              DropdownButton(
                  focusColor: Colors.grey,
                  iconEnabledColor: Styles.orangeColor,
                  dropdownColor: Styles.primaryColor,
                  menuMaxHeight: size.height * 0.4,
                  borderRadius:
                  BorderRadius.circular(AppLayout.getHeight(15)),
                  style: Styles.headLineStyle2
                      .copyWith(fontWeight: FontWeight.w500),
                  value: month,
                  items: const [
                     DropdownMenuItem(
                        value: 1,
                        child: Text("  January")),
                    DropdownMenuItem(
                        value: 2,
                        child: Text("  February")),
                    DropdownMenuItem(
                        value: 3,
                        child: Text("  March")),
                    DropdownMenuItem(
                        value: 4,
                        child: Text("  April")),
                    DropdownMenuItem(
                        value: 5,
                        child: Text("  May")),
                    DropdownMenuItem(
                        value: 6,
                        child: Text("  June")),
                    DropdownMenuItem(
                        value: 7,
                        child: Text("  July")),
                    DropdownMenuItem(
                        value: 8,
                        child: Text("  August")),
                    DropdownMenuItem(
                        value: 9,
                        child: Text("  September")),
                    DropdownMenuItem(
                        value: 10,
                        child: Text("  October")),
                    DropdownMenuItem(
                        value: 11,
                        child: Text("  November")),
                    DropdownMenuItem(
                        value: 12,
                        child: Text("  December")),

                  ],
                  onChanged: (value){
                    setState(() {
                      month = value as int;
                    });
                  }),
              SizedBox(
                height: size.height * 0.5,
                child: ListView.builder(
                  itemCount: monthExpenseList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: ListTile(
                        iconColor: Colors.black,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(monthExpenseList[index]['category'],
                                style: Styles.headLineStyle2.copyWith(fontSize: AppLayout.getWidth(18))),
                            Expanded(child: Container(),),
                            Text(
                              monthExpenseList[index]['amount'].toString(),
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
        )
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 5:
        text = const Text('5', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 15:
        text = const Text('15', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 25:
        text = const Text('25', style: style);
        break;
      case 30:
        text = const Text('30', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 200:
        text = '200';
        break;
      case 400:
        text = '400';
        break;
      case 600:
        text = '600';
        break;
      case 800:
        text = '800';
        break;
      case 1000:
        text = '1000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.blueGrey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.blueGrey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 31,
      minY: 0,
      maxY: 1000,
      lineBarsData: [
        LineChartBarData(
          spots: monthExpenseList.map((e) => FlSpot(((e['date']).toDate()).day/1, e['amount']/1)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}