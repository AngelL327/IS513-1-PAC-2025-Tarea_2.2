import 'package:flutter/material.dart';
import 'package:pokeapi/src/widgets/header_side_menu.dart';
import 'package:pokeapi/src/widgets/menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/736x/8a/79/ac/8a79ac178777d9e9bc8a46c7935fad07.jpg',
            ),
          fit: BoxFit.cover,
          ),
  
        ),
        child: SafeArea(
          child: ListView(
            children: [
              HeaderSideMenu(
                title: 'Angel Lagos',
                email: 'Pineda@mail.com',
              ),
              ListTile(
                leading: Icon(Icons.animation_rounded),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text('Pokedex'),
                onTap: () {},
                // subtitle: Text('Pantalla principal de reseñas'),
              ),
             ListTile(
                leading: Icon(Icons.star),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text(' Favoritos'),
                onTap: () {},
                // subtitle: Text('Pantalla principal de reseñas'),
              ),
        
          
            ],
          ),
        ),
      ),
    );
  }
}