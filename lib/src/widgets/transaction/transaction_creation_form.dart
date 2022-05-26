import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/utilizes/date.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TransactionCreationForm extends StatefulWidget {
  const TransactionCreationForm({Key? key, this.item}) : super(key: key);

  final TransactionItem? item;

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
  TextEditingController dateEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameEditingController.text = widget.item?.name ?? ""; // ;
    amountEditingController.text = widget.item?.cost.toString() ?? "";
    dateEditingController.text =
        widget.item?.date.toDateString() ?? DateTime.now().toDateString();

    selectedDate = widget.item?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    amountEditingController.dispose();
    dateEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                      validator: (value) => _validateRequired(value)),
                ),
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
                      validator: (value) => _validateRequired(value)),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () => _selectDate(context, dateEditingController),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateEditingController,
                        keyboardType: TextInputType.datetime,
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
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        ElevatedButton(
          onPressed: () =>
              widget.item == null ? _add() : _edit(widget.item!.id),
          child: Text(widget.item != null ? 'EDIT' : 'ADD',
              style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context, dateEditingController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateEditingController.text = selectedDate.toDateString();
      });
    }
  }

  void _add() {
    if (_formKey.currentState!.validate()) {
      context.read<TransactionModel>().add(TransactionItem(
          DateTime.now().millisecondsSinceEpoch,
          int.parse(amountEditingController.text),
          nameEditingController.text,
          selectedDate));

      Navigator.pop(context);
    }
  }

  void _edit(int id) {
    if (_formKey.currentState!.validate()) {
      context.read<TransactionModel>().edit(TransactionItem(
          id,
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
