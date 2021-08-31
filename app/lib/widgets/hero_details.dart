import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/widgets/power_grid_hero.dart';

class HeroDetails extends StatelessWidget {
  final heroesProvider.Hero hero;
  const HeroDetails({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
        MediaQuery.of(context).size.width < 600
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    MediaQuery.of(context).size.width < 600
                        ? Container(
                            height: MediaQuery.of(context).size.width * 0.6,
                            width: double.infinity,
                            child: Image.network(
                              hero.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.05,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2,
                            ),
                            height: 600,
                            width: 600,
                            child: Image.network(
                              hero.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Text(
                      'Powers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: PowerGridHero(hero: hero),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.height * 0.5,
                    child: Image.network(
                      hero.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Powers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: PowerGridHero(hero: hero),
                  ),
                ],
              ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.6 - 50,
          right: 0,
          child: Container(
            width: 200,
            height: 50,
            color: Colors.black.withOpacity(0.7),
            child: Center(
                child: Text(
              hero.universe.name,
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
          ),
        ),
      ],
    );
  }
}
