import '../../model/fruit.dart';
import '../fruit_repository.dart';

class MockFruitRepository extends FruitRepository {
  final List<Fruit> fruits = [];

  @override
  Future<Fruit> addFruit({required String name, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      Fruit newFruit = Fruit(id: "0", name: name, price: price);
      fruits.add(newFruit);
      return newFruit;
    });
  }

  @override
  Future<List<Fruit>> getFruits() {
    return Future.delayed(Duration(seconds: 1), () => fruits);
  }

  @override
  Future<void> removeFruit(String id) async {
    fruits.removeWhere((fruit) => fruit.id == id);
  }
}
