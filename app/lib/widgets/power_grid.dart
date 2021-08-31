import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/powers_provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/widgets/power_card.dart';

class PowerGrid extends StatefulWidget {
  final heroesProvider.Hero hero;
  const PowerGrid({Key? key, required this.hero}) : super(key: key);

  @override
  _PowerGridState createState() => _PowerGridState();
}

class _PowerGridState extends State<PowerGrid> {
  var _isLoading = false;

  void initState() {
    _isLoading = true;
    Provider.of<PowersProvider>(context, listen: false).fetchPowers().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final powersData = Provider.of<PowersProvider>(context);
    return Center(
      child: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio:
                MediaQuery.of(context).size.width <= 600 ? 7 / 2 : 8 / 2,
            mainAxisSpacing: 10,
          ),
          itemCount: powersData.getPowers.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          itemBuilder: (context, index) {
            //It's necessary to pass a provider here because we need to use the power provider on PowerCard
            return ChangeNotifierProvider.value(
              value: powersData.getPowers[index],
              child: GridTile(
                child: PowerCard(
                  hero: widget.hero,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
