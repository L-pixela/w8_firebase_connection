import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../dto/fruit_dto.dart';
import '../../model/fruit.dart';
import '../fruit_repository.dart';

class FirebaseFruitRepository implements FruitRepository {
  static const String baseUrl = 'YOUR URL';
  static const String fruitsCollection = "fruits";
  static const String allFruitsUrl = '$baseUrl/$fruitsCollection.json';

  @override
  Future<Fruit> addFruit({required String name, required double price}) async {
    Uri uri = Uri.parse(allFruitsUrl);

    final newFruitData = {'name': name, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newFruitData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add fruit');
    }

    final newId = json.decode(response.body)['name'];
    return Fruit(id: newId, name: name, price: price);
  }

  @override
  Future<List<Fruit>> getFruits() async {
    Uri uri = Uri.parse(allFruitsUrl);
    final http.Response response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load fruits');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries
        .map((entry) => FruitDto.fromJson(entry.key, entry.value))
        .toList();
  }
}
