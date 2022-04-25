import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionCreationForm extends StatefulWidget {
  const TransactionCreationForm({Key? key}) : super(key: key);

  @override
  TransactionCreationFormState createState() {
    return TransactionCreationFormState();
  }
}

class TransactionCreationFormState extends State<TransactionCreationForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController dateEditingController = TextEditingController(
      text: DateFormat('MMM d, yyyy').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    final transactionModel = context.watch<TransactionModel>();

    return Column(
      children: [
        Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    autofocus: true,
                    controller: nameEditingController,
                    validator: (value) => _validateRequired(value))),
            Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                    maxLength: 5,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Enter Amount',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: amountEditingController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => _validateRequired(value))),
            Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                    onTap: () => _selectDate(context, dateEditingController),
                    child: AbsorbPointer(
                        child: TextFormField(
                      controller: dateEditingController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(color: Colors.blue),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Enter Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        isDense: true,
                        suffixIcon: const Icon(Icons.date_range),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (value) => _validateRequired(value),
                    )))),
          ]),
        ),
        ElevatedButton(
          onPressed: () => _save(transactionModel),
          child: const Text('ADD'),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context, dateEditingController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var format = DateFormat('MMM d, yyyy');
        var dateString = format.format(DateTime.now());
        dateEditingController.text = dateString;
      });
    }
  }

  void _save(TransactionModel transactionModel) {
    if (_formKey.currentState!.validate()) {
      transactionModel.add(TransactionItem(
          int.parse(amountEditingController.text),
          nameEditingController.text,
          selectedDate));

      Navigator.pop(context);
    }
  }

  String? _validateRequired(String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }
}
