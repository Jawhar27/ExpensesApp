import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/transactionList.dart';
import './widgets/NewTransaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'OpenSans',
          accentColor: Colors.red),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> transactions = [
    // Transaction(
    // amount: 55, date: DateTime.now(), title: "New Products", id: "t1"),
    // Transaction(
    //     amount: 65, date: DateTime.now(), title: "New Assets", id: "t2"),
    // Transaction(
    //     amount: 95, date: DateTime.now(), title: "New Crimes", id: "t3"),
  ];

  bool onchange = false;

  List<Transaction> get recentTransactions {
    return transactions.where((trans) {
      return trans.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String txt, double amo, DateTime date) {
    final newtx = Transaction(
        title: txt, amount: amo, date: date, id: DateTime.now().toString());
    setState(() {
      transactions.add(newtx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addTransaction));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Center(
          child: Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      )),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );
    final transac = Container(
        height: (MediaQuery.of(context).size.height * 0.8 -
            appbar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        child: TransactionList(transactions, deleteTransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: onchange,
                    onChanged: (val) {
                      setState(() {
                        onchange = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height * 0.4 -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
                width: double.infinity,
                child: Chart(recentTransactions),
              ),
            if (!isLandscape) transac,
            if (isLandscape)
              onchange
                  ? Container(
                      height: (MediaQuery.of(context).size.height * 0.6 -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top),
                      width: double.infinity,
                      child: Chart(recentTransactions),
                    )
                  : transac
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
