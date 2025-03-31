import 'package:flutter_rest_api/EXAMPLE_1/model/fruit.dart';

abstract class FruitRepository {
  Future<Fruit> addFruit({required String name, required double price});
  Future<List<Fruit>> getFruits();
  Future<void> removeFruit(String id);
}
