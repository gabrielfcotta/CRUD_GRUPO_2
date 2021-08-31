import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/user_hero_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          child: Column(
            children: [
              AppBar(
                title: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading: false,
                foregroundColor: Colors.black,
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.userFriends,
                  color: Colors.black,
                ),
                title: Text('All Heroes'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                title: Text('Your Heros'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UserHeroScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.filter,
                  color: Colors.black,
                ),
                title: Text('Filters'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
