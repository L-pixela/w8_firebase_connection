import 'package:flutter/material.dart';
import 'package:flutter_rest_api/EXAMPLE_1/screen/provider/async_value.dart';
import 'package:flutter_rest_api/EXAMPLE_1/model/fruit.dart';
import 'package:flutter_rest_api/EXAMPLE_1/repository/fruit_repository.dart';

class FruitProvider extends ChangeNotifier {
  final FruitRepository _repository;
  AsyncValue<List<Fruit>>? fruitsState;

  FruitProvider(this._repository) {
    fetchFruits();
  }

  bool get isLoading =>
      fruitsState != null && fruitsState!.state == AsyncValueState.loading;
  bool get hasData =>
      fruitsState != null && fruitsState!.state == AsyncValueState.success;

  void fetchFruits() async {
    try {
      fruitsState = AsyncValue.loading();
      notifyListeners();
      fruitsState = AsyncValue.success(await _repository.getFruits());
    } catch (error) {
      fruitsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addFruit(String name, double price) async {
    await _repository.addFruit(name: name, price: price);
    fetchFruits();
  }
}
