import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/providers/universe_provider.dart';

class UniverseRadioTile extends StatefulWidget {
  final heroesProvider.Hero hero;
  const UniverseRadioTile({Key? key, required this.hero}) : super(key: key);

  @override
  _UniverseRadioTileState createState() => _UniverseRadioTileState();
}

class _UniverseRadioTileState extends State<UniverseRadioTile> {
  var _isLoading = false;
  String dropdownValue = '';
  void initState() {
    _isLoading = true;
    Provider.of<UniverseProvider>(context, listen: false)
        .fetchUniverses()
        .then((_) {
      setState(() {
        _isLoading = false;
        dropdownValue = Provider.of<UniverseProvider>(context, listen: false)
            .getUniverses[0]
            .name;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final universesData = Provider.of<UniverseProvider>(context);

    return _isLoading
        ? CircularProgressIndicator()
        : DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: universesData.getUniverses
                .map((universe) => universe.name)
                .toList()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                onTap: () {
                  setState(() {
                    Universe _universe = universesData.getUniverses
                        .firstWhere((uni) => value == uni.name);
                    Provider.of<heroesProvider.HeroesProvider>(context,
                            listen: false)
                        .setUniverse(widget.hero, _universe);
                  });
                },
                child: Text(value),
              );
            }).toList(),
          );
  }
}


/* child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: universesData
                  .map((universe) => universe.name)
                  .toList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  onTap: () {
                    setState(() {
                      Universe _universe =
                          universesData.firstWhere((uni) => value == uni.name);
                      Provider.of<heroesProvider.HeroesProvider>(context,
                              listen: false)
                          .setUniverse(widget.hero, _universe);
                    });
                  },
                  child: Text(value),
                );
              }).toList(),
            ), */