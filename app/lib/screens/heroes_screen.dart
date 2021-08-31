import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/hero_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Tab>[
              Tab(
                child: Text(
                  'All heroes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'My heroes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          title: Container(
            height: 55,
            child: Image(
              image: AssetImage('assets/EY.png'),
              fit: BoxFit.cover,
            ),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: AssetImage('assets/universe.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                HeroGrid(),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: AssetImage('assets/universe.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                HeroGrid(),
              ],
            ),
          ],
        ),

        drawer: AppDrawer(),
        //endDrawer: UserDrawer(),
      ),
    );
  }
}
