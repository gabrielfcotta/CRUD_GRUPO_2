import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/widgets/hero_details.dart';

class HeroDetailsScreen extends StatelessWidget {
  static const routeName = '/hero-details';

  @override
  Widget build(BuildContext context) {
    // We get the id as an argument when acesing this route
    final heroId = ModalRoute.of(context)!.settings.arguments as String;
    final heroesProvider.Hero hero = Provider.of<heroesProvider.HeroesProvider>(
      context,
      listen: false,
    ).findById(heroId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          hero.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: HeroDetails(hero: hero),
    );
  }
}
