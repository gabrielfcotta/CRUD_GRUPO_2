import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/custom_route.dart';
import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_hero_screen.dart';
import 'screens/hero_details_screen.dart';
import 'screens/heroes_screen.dart';
import 'screens/user_hero_screen.dart';

import 'providers/heroes_provider.dart';
import 'providers/powers_provider.dart';
import 'providers/universe_provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HeroesProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PowersProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UniverseProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          /* ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products(null, null, []),
            update: (context, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (context) => Orders(null, '', []),
            update: (context, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ), */
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: auth.isAuth
                ? HeroesScreen()
                : /* FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Center(
                                child: Text('Loading...'),
                              )
                            : */
                HeroesScreen(),
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              accentColor: Colors.yellow.shade900,
              buttonColor: Colors.red.shade500,
              iconTheme: IconThemeData(color: Colors.yellow),
              primaryIconTheme: IconThemeData(color: Colors.yellow),
              appBarTheme: AppBarTheme(backgroundColor: Colors.black),
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
              }),
              textTheme: TextTheme(
                bodyText1:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                headline1:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                headline4:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            routes: {
              UserHeroScreen.routeName: (context) => UserHeroScreen(),
              EditHeroScreen.routeName: (context) => EditHeroScreen(),
              HeroDetailsScreen.routeName: (context) => HeroDetailsScreen(),
            },
          ),
        ),
      ),
    );
