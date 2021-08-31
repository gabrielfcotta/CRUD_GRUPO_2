import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart';
import 'package:shop_app/widgets/hero_card.dart';

class HeroGrid extends StatefulWidget {
  const HeroGrid({Key? key}) : super(key: key);

  @override
  _HeroGridState createState() => _HeroGridState();
}

class _HeroGridState extends State<HeroGrid> {
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<HeroesProvider>(context, listen: false).fetchHeroes().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heroesData = Provider.of<HeroesProvider>(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 800 ? 5 : (3),
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisSpacing: 10,
      ),
      itemCount: heroesData.getHeroes.length,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      itemBuilder: (context, index) {
        //It's necessary to pass a provider here because we need to use the hero provider on HeroCard
        return ChangeNotifierProvider.value(
          value: heroesData.getHeroes[index],
          child: GridTile(
            child: HeroCard(),
          ),
        );
      },
    );
  }
}
