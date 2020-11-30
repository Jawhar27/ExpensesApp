import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;
  TransactionList(this.transactions, this.delTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Text(
                      'No Transactions Added Yet!',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/noTransaction.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            '\$' + transactions[index].amount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat()
                            .add_yMMMd()
                            .format(transactions[index].date),
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              label: Text('Delete'),
                              textColor: Colors.red,
                              onPressed: () => delTx(transactions[index].id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => delTx(transactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
                // children: transactions
                //     .map(
                // (e) => Card(
                //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                //   elevation: 5,
                //   child: ListTile(
                //     leading: CircleAvatar(
                //       radius: 30,
                //       child: FittedBox(
                //         child: Text(
                //           '\$' + e.amount.toString(),
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //     title: Text(
                //       e.title,
                //       style: TextStyle(
                //           fontSize: 15, fontWeight: FontWeight.bold),
                //     ),
                //     subtitle: Text(
                //       DateFormat().add_yMMMd().format(e.date),
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //     trailing: IconButton(
                //       icon: Icon(Icons.delete),
                //       color: Colors.red,
                //       onPressed: () => delTx(e.id),
                //     ),
                //   ),
                // ),
                //  Card(
                //         child: Row(
                //       children: [
                //         Container(
                //           // THE AMOUNT OF TRANSACTIONS
                //           child: Text(
                //             '\$' + e.amount.toString(),
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 15,
                //               color: Colors.purple,
                //             ),
                //           ),
                //           margin: EdgeInsets.symmetric(
                //               vertical: 15, horizontal: 20),
                //           decoration: BoxDecoration(
                //               border: Border.all(
                //                   color: Colors.deepPurple, width: 2)),
                //           padding: EdgeInsets.all(5),
                //         ),

                //         // THE DATE AND TITLE OF TX
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               e.title,
                //               style: TextStyle(
                //                   fontSize: 15, fontWeight: FontWeight.bold),
                //             ),
                //             Text(
                //               DateFormat().add_yMMMd().format(e.date),
                //               style: TextStyle(color: Colors.grey),
                //             ),
                //           ],
                //         ),
                //       ],
                //     )
                //     )
              ));
    //               .toList(),
    //         ),
    // );
  }
}
