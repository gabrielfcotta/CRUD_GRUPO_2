import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/providers/powers_provider.dart';

class PowerCard extends StatefulWidget {
  final heroesProvider.Hero hero;
  const PowerCard({Key? key, required this.hero}) : super(key: key);

  @override
  _PowerCardState createState() => _PowerCardState();
}

class _PowerCardState extends State<PowerCard> {
  var _bool = false;
  @override
  Widget build(BuildContext context) {
    var power = Provider.of<Power>(context);
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFFFFF33), Color(0xFFeb07d4)]),
                borderRadius: BorderRadius.circular(50),
                color: Colors.lightGreenAccent,
              ),
            ),
            onTap: () {
              setState(() {
                _bool = !_bool;
                if (_bool) {
                  Provider.of<heroesProvider.HeroesProvider>(context,
                          listen: false)
                      .addPower(widget.hero, power);
                } else {
                  Provider.of<heroesProvider.HeroesProvider>(context,
                          listen: false)
                      .deletePower(widget.hero, power.id);
                }
              });
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      power.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Checkbox(
                      value: _bool,
                      onChanged: (value) => setState(() {
                        print(power.id);
                        _bool = !_bool;
                        if (_bool) {
                          Provider.of<heroesProvider.HeroesProvider>(context,
                                  listen: false)
                              .addPower(widget.hero, power);
                        } else {
                          Provider.of<heroesProvider.HeroesProvider>(context,
                                  listen: false)
                              .deletePower(widget.hero, power.id);
                        }
                      }),
                      activeColor: Colors.lightGreen.shade400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
