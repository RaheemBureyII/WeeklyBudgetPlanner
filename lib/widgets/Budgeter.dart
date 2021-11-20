import 'package:budget/models/Expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import '../databases/expenses.dart';

class Budgeter extends StatefulWidget {
  final double amount;
  Budgeter(this.amount);
  @override
  _BudgeterState createState() => _BudgeterState();
}

class _BudgeterState extends State<Budgeter> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController icon = TextEditingController();
  bool isupdate = true;
  TextEditingController expamn = TextEditingController();
  late IconData icondata;
  void setdate(formattedDate) {
    setState(() {
      date.text = formattedDate; //set output date to TextField value.
    });
  }

  void seticon(iconData, name) {
    setState(() {
      icondata = iconData;
      icon.text = name; //set output date to TextField value.
      print(icon.text);
    });
  }

  void setexpenses() {
    setState(() {
      expenses1.add(Expense(
          date: date.text,
          expnse: double.parse(expamn.text),
          icon: icondata,
          name: name.text));
      isupdate = !isupdate;
    });
  }

  void setanalytics() {
    setState(() {
      isupdate = !isupdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    double amount = widget.amount;
    double expenses = 0;
    for (var x = 0; x < expenses1.length; x++) {
      expenses += expenses1[x].expnse;
    }

    print(amount);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Weekly Budgeter"),
        backgroundColor: Color.fromRGBO(28, 153, 65, 1),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _alertanalytics(context);
                  });
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: 300,
                        height: 300,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: expamn,
                              decoration: InputDecoration(
                                labelText: "Expense amount",
                              ),
                            ),
                            TextField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Expense Name",
                              ),
                            ),
                            TextField(
                              readOnly: true,
                              onTap: () {
                                getdate(context, setdate);
                              },
                              controller: date,
                              decoration: InputDecoration(
                                labelText: "Enter Date",
                              ),
                            ),
                            TextField(
                              readOnly: true,
                              onTap: () {
                                _alerticons(context, seticon);
                              },
                              controller: icon,
                              decoration: InputDecoration(
                                labelText: "Type Of Expense",
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  print(expenses1);
                                  setexpenses();
                                  date.text = "";
                                  icon.text = "";
                                  name.text = "";
                                  expamn.text = "";
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Color.fromRGBO(230, 245, 229, 1),
        child: Column(children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _testwidget("Amount", amount),
                _testwidget("Expenses", expenses),
                _testwidget("Balance", amount - expenses),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return _expense(index);
                },
                itemCount: expenses1.length,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget _testwidget(text, number) {
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        text,
        style: TextStyle(
            color: Color.fromRGBO(28, 153, 65, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      Text(
        "\$ ${number.toString()}",
        style: TextStyle(color: Colors.black, fontSize: 15),
      )
    ]),
  );
}

Widget _expense(int index) {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromRGBO(28, 153, 65, 1),
        borderRadius: BorderRadius.circular(10)),
    width: double.infinity,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        CircleAvatar(
          child: Icon(
            expenses1[index].icon,
            color: Color.fromRGBO(28, 153, 65, 1),
          ),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 20),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            expenses1[index].name,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(expenses1[index].date)
        ]),
      ]),
      Text(
        "\$ ${expenses1[index].expnse.toString()}",
        style: TextStyle(fontSize: 20),
      )
    ]),
  );
}

void getdate(context, setdate) async {
  DateTime today = DateTime.now();

  DateTime _firstDayOfTheweek = today.weekday != DateTime.sunday
      ? today.subtract(new Duration(days: today.weekday))
      : today;
  DateTime _lastdayofweek = DateTime.now()
      .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday - 1));
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(_firstDayOfTheweek.year, _firstDayOfTheweek.month,
          _firstDayOfTheweek.day),
      lastDate: DateTime(
          _lastdayofweek.year, _lastdayofweek.month, _lastdayofweek.day));
  if (pickedDate != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

    setdate(formattedDate);
  } else {
    print("Date is not selected");
  }
}

Future<dynamic> _alerticons(context, seticon) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose your icons"),
          actions: [
            _iconoption(Icons.restaurant, "Food", seticon, context),
            _iconoption(Icons.payments, "Bills", seticon, context),
            _iconoption(Icons.local_taxi, "Commute", seticon, context),
            _iconoption(Icons.redeem, "Gifts", seticon, context)
          ],
        );
      });
}

Widget _iconoption(icondata, String name, seticon, context) {
  return Container(
    child: MaterialButton(
      onPressed: () {
        seticon(icondata, name);
        Navigator.of(context).pop();
      },
      child: Row(
        children: [Icon(icondata), SizedBox(width: 10), Text(name)],
      ),
    ),
  );
}

Widget _alertanalytics(context) {
  Map<String, double> dataMap = {};
  for (var x = 0; x < expenses1.length; x++) {
    dataMap[expenses1[x].name] = expenses1[x].expnse;
  }
  return PieChart(
      dataMap: dataMap,
      centerText: "Expenses",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
}
