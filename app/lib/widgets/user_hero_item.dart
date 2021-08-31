import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart';
import 'package:shop_app/screens/edit_hero_screen.dart';

class UserHeroItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  const UserHeroItem(
      {Key? key, required this.name, required this.id, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditHeroScreen.routeName, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow.shade700,
                )),
            IconButton(
                onPressed: () {
                  Provider.of<HeroesProvider>(context, listen: false)
                      .deleteHero(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
