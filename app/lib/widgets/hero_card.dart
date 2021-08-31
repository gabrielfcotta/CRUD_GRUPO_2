import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as herop;
import 'package:shop_app/screens/hero_details_screen.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hero = Provider.of<herop.Hero>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50), topLeft: Radius.circular(50)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            //Goes to Hero Details and pass the id as an argument
            print(hero.id);
            Navigator.pushNamed(context, HeroDetailsScreen.routeName,
                arguments: hero.id);
          },
          child: Card(
            color: Colors.amber,
            child: Image.network(
              hero.imageUrl,
              fit: BoxFit.cover,
            ),
            elevation: 5,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(0.7),
          title: Text(
            hero.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
