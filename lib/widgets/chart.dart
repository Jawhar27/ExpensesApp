import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  //getting the transaction list
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  //generating new List
  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(Duration(days: index));
      double sumAmount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (weekDays.day == recentTransactions[i].date.day &&
            weekDays.month == recentTransactions[i].date.month &&
            weekDays.year == recentTransactions[i].date.year) {
          sumAmount = sumAmount + recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDays), 'amount': sumAmount};
    });
  }

  double get totalSpending {
    return groupTransactions.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactions);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactions.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    e['day'],
                    totalSpending == 0.0
                        ? 0.0
                        : (e['amount'] as double) / totalSpending,
                    e['amount']),
              );
            }).toList()),
      ),
    );
  }
}
