import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heroes_provider.dart';
import 'edit_hero_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hero_card.dart';
import '../widgets/user_hero_item.dart';

class UserHeroScreen extends StatelessWidget {
  const UserHeroScreen({Key? key}) : super(key: key);

  final String id = '';

  Future<void> _refreshHeroes(BuildContext context) async {
    await Provider.of<HeroesProvider>(context, listen: false).fetchHeroes();
  }

  static const routeName = '/user-heroes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your heroes', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditHeroScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshHeroes(context),
        builder: (context, snpashot) => snpashot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return _refreshHeroes(context);
                },
                child: Consumer<HeroesProvider>(
                  builder: (context, heroesData, _) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: heroesData.getHeroes.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              UserHeroItem(
                                id: heroesData.getHeroes[index].id,
                                name: heroesData.getHeroes[index].name,
                                imageUrl: heroesData.getHeroes[index].imageUrl,
                              ),
                              //imageUrl: productsData.items[index].imageUrl),
                              Divider(),
                            ],
                          );
                        }),
                  ),
                ),
              ),
      ),
    );
  }
}
