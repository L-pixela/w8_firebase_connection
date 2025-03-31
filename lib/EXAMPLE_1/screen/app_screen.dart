import 'package:flutter/material.dart';
import 'package:flutter_rest_api/EXAMPLE_1/model/fruit.dart';
import 'package:flutter_rest_api/EXAMPLE_1/screen/fruit_form_screen.dart';
import 'package:flutter_rest_api/EXAMPLE_1/screen/provider/fruit_provider.dart';
import 'package:provider/provider.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  void _onAddPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FruitForm(
        onSubmit: (name, price) =>
            context.read<FruitProvider>().addFruit(name, price),
      ),
    );
  }

  void _onRemovePressed(BuildContext context, String id) {
    final FruitProvider fruitProvider = context.read<FruitProvider>();
    fruitProvider.removeFruit(id);
  }

  @override
  Widget build(BuildContext context) {
    final fruitProvider = Provider.of<FruitProvider>(context);

    Widget content = Text('');
    if (fruitProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (fruitProvider.hasData) {
      List<Fruit> fruits = fruitProvider.fruitsState!.data!;

      if (fruits.isEmpty) {
        content = Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: fruits.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(fruits[index].name),
            subtitle: Text("${fruits[index].price}"),
            trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _onRemovePressed(context, fruits[index].id)),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () => _onAddPressed(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(child: content),
    );
  }
}
