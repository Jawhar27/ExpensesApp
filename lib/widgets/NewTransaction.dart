import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime pickedDate;
  void addValue() {
    final String enteredInputTitle = titleController.text;
    final double enteredInputAmount = double.parse(amountController.text);

    if (enteredInputAmount <= 0 ||
        enteredInputTitle == null ||
        pickedDate == null) {
      return;
    }
//aceesing from widget that is why we using "widget."
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
      pickedDate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      } else {
        setState(() {
          pickedDate = selectedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Enter the Title'),
                  // onChanged: (val) => inputTitle = val,
                  controller: titleController,
                  onSubmitted: (s) => addValue(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter the Amount'),
                  // onChanged: (val) => inputAmount = val,
                  controller: amountController,
                  onSubmitted: (value) => addValue(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(pickedDate == null
                            ? 'Date not choosen'
                            : 'Picked Date : ' +
                                DateFormat.yMd().format(pickedDate)),
                      ),
                      FlatButton(
                        child: Text(
                          'Choose Date ',
                          style: TextStyle(color: Colors.purple),
                        ),
                        onPressed: presentDatePicker,
                      )
                    ],
                  ),
                ),
                FlatButton(
                    child: Text('Add to Transaction'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: addValue)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
