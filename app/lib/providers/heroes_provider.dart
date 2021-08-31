import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'universe_provider.dart';
import 'powers_provider.dart';

class Hero with ChangeNotifier {
  late final String id;
  late final String name;
  late final String imageUrl;
  late final Universe universe;
  late final List<Power> powers;
  late final String creationDate;

  Hero(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.powers,
      required this.universe,
      required this.creationDate});
}

class HeroesProvider with ChangeNotifier {
  List<Hero> _heroes = [];

  //Gets a list of all heroes in the app that weren't deleted
  List<Hero> get getHeroes {
    return [..._heroes];
  }

  //Finds and returns a hero by it's ID
  Hero findById(String id) {
    return _heroes.firstWhere((hero) => hero.id == id);
  }

  // Adds a new Hero to the app
  Future<void> addHero(Hero newHero) async {
    var url = Uri.http('localhost:8000', '/hero/');
    final timestamp = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await http.post(url,
          body: json.encode({
            'HeroName': newHero.name,
            'UserId': 'gabrielfcotta@hotmail.com',
            'Power':
                newHero.powers.map((power) => power.id.toString()).toList(),
            'Universe': newHero.universe.id,
            'CreationDate': timestamp,
            'PhotoFileName': newHero.imageUrl,
          }));

      print(response.body);

      if (response.statusCode != 200) {
        _heroes.add(
          Hero(
              id: newHero.id,
              name: newHero.name,
              imageUrl: newHero.imageUrl,
              universe: newHero.universe,
              powers: newHero.powers,
              creationDate: timestamp),
        );
      }

      notifyListeners();
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  //Updates the hero if it already exists
  Future<void> updateHero(Hero newHero, String id) async {
    var url = Uri.http('localhost:8000', '/hero/');
    final timestamp = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await http.put(url,
          body: json.encode({
            'HeroId': int.parse(newHero.id),
            'HeroName': newHero.name,
            'UserId': 'gabrielfcotta@hotmail.com',
            'Power': (newHero.powers as List<dynamic>)
                .map((power) => Power(id: power.toString()))
                .toList() /* newHero.powers
                .map((power) => {
                      'PowerId': int.parse(power.id),
                      'PowerName': power.name,
                    })
                .toList() */
            ,
            'Universe': 1,
            'CreationDate': timestamp,
            'PhotoFileName': newHero.imageUrl,
            'Deleted': false
          }));

      print(response.body);

      int _index = _heroes.indexWhere((hero) => hero.id == id);
      _heroes[_index] = newHero;

      notifyListeners();
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  //Deletes the hero logically
  void deleteHero(String id) {
    var url = Uri.http('localhost:8000', '/hero/$id');

    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw ('Could not delete the hero...');
      }
    }).catchError((_) {
      notifyListeners();
    });
    notifyListeners();
  }

  void addPower(Hero hero, Power power) {
    print('${power.id}, ${power.name}');
    hero.powers.add(power);
    notifyListeners();
  }

  void deletePower(Hero hero, String powerId) {
    hero.powers.removeWhere((power) => power.id == powerId);
    notifyListeners();
  }

  void setUniverse(Hero hero, Universe newUniverse) {
    hero.universe.id = newUniverse.id;
    hero.universe.name = newUniverse.name;
    notifyListeners();
  }

  // Fetch all heroes created that weren't deleted
  Future<void> fetchHeroes([String filterByUserId = 'false']) async {
    var url = Uri.http('localhost:8000', 'hero/');

    try {
      final response = await http.get(url);

      //print(response.body);
      final extractedData = json.decode(response.body) as List<dynamic>;

      if (extractedData.isEmpty) {
        return;
      }

      final List<Hero> loadedHeroes = [];

      //print(extractedData);

      extractedData.forEach((hero) {
        print(hero['Universe'].toString());
        //Only shows the hero if it wasn't deleted
        if (hero['Deleted'] == false) {
          loadedHeroes.add(
            Hero(
              id: hero['HeroId'].toString(),
              name: hero['HeroName'],
              powers: [] /* (hero['Power'] as List<dynamic>)
                  .map((power) => Power(id: power.toString()))
                  .toList() */
              ,
              imageUrl: hero['PhotoFileName'],
              universe: Universe(
                name: hero['Universe'].toString() == 1
                    ? 'Ey Comics'
                    : hero['Universe'] == 2
                        ? 'Trainee Comics'
                        : 'Outros',
                id: hero['Universe'].toString(),
              ),
              creationDate: hero['CreationDate'],
            ),
          );
        }
      });
      _heroes = loadedHeroes.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
