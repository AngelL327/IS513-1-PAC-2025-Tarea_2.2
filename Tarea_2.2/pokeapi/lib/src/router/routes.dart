import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapi/src/views/detalle_pokemon_page.dart';
import 'package:pokeapi/src/views/home_page.dart';

final router = GoRouter(
  initialLocation: '/pokems',
  routes: [
    GoRoute(
      path: '/pokems',
      name: 'productos',
      builder: (context, settings) => HomePage(),
      routes: [
        GoRoute(
          path: '/:pokemsId', // /productos/4
          name: 'detalle-pokems',
          builder: (BuildContext context, GoRouterState settings) {
            final id = settings.pathParameters['pokemsId'];

            final extras = settings.extra as Map;
            print(extras);

            return DetallePokemonPage(
              id: '$id',
              extras: extras,
            );
          },
        )
      ],
    ),
    
  ],
);