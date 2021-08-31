import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Universe with ChangeNotifier {
  late String id;
  late String name;

  Universe({
    required this.id,
    required this.name,
  });
}

class UniverseProvider with ChangeNotifier {
  List<Universe> _universes = [];

  List<Universe> get getUniverses {
    return [..._universes];
  }

  Future<void> fetchUniverses() async {
    var url = Uri.http('localhost:8000', 'universe/');

    try {
      final response = await http.get(url);

      //print(response.body);
      final extractedData = json.decode(response.body) as List<dynamic>;

      if (extractedData.isEmpty) {
        return;
      }
      /* final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body); */
      final List<Universe> loadedUniverses = [];

      print(extractedData);

      extractedData.forEach((universe) {
        loadedUniverses.add(
          Universe(
            id: universe['UniverseId'].toString(),
            name: universe['UniverseName'],
          ),
        );
      });

      _universes = loadedUniverses.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
