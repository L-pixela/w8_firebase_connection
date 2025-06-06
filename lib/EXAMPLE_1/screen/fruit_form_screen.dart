// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/EXAMPLE_1/model/fruit.dart';

class FruitForm extends StatefulWidget {
  final Fruit? fruit;
  final Function(String, double) onSubmit;

  const FruitForm({super.key, this.fruit, required this.onSubmit});

  @override
  _FruitFormState createState() => _FruitFormState();
}

class _FruitFormState extends State<FruitForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;

  void onSumitted() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name, _price);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.fruit != null) {
      _name = widget.fruit!.name;
      _price = widget.fruit!.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.fruit == null ? 'Add Fruit' : 'Edit Fruit'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) => _name = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a name' : null,
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0
                  ? 'Enter a valid price'
                  : null,
              onChanged: (value) => _price = double.tryParse(value) ?? 0.0,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: onSumitted,
          child: Text('Save'),
        ),
      ],
    );
  }
}
