import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Power with ChangeNotifier {
  late String id;
  late String name;

  Power({required this.id, this.name = ''});
}

class PowersProvider with ChangeNotifier {
  List<Power> _powers = [];
  static List<Power> powers = [];

  List<Power> get getPowers {
    return [..._powers];
  }

  Future<void> fetchPowers() async {
    var url = Uri.http('localhost:8000', 'power/');

    try {
      final response = await http.get(url);

      //print(response.body);
      final extractedData = json.decode(response.body) as List<dynamic>;

      if (extractedData.isEmpty) {
        return;
      }
      final List<Power> loadedPowers = [];

      print(extractedData);

      extractedData.forEach((power) {
        loadedPowers.add(
          Power(
            id: power['PowerId'].toString(),
            name: power['PowerName'],
          ),
        );
      });
      //}); */
      _powers = loadedPowers.reversed.toList();
      powers = loadedPowers.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
