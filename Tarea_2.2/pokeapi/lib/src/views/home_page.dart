import 'package:flutter/material.dart';
import 'package:pokeapi/src/providers/poke_provider.dart';
import 'package:pokeapi/src/widgets/item_list.dart';
import 'package:pokeapi/src/widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    print('Iniciando home page');
    
    // realizar peticiones
    // comprobar informacion local (sqlite o shared preferences)
    // comprabar si hay internet
    // comprobar si el usuario esta logueado
  }

  @override
  Widget build(BuildContext context) {
    final screen1 = MediaQuery.of(context).size.width; // Ancho de la pantalla
    final screen2 = MediaQuery.of(context).size.height; // Alto de la pantalla

    return SafeArea(
    child: Container(
      color: const Color.fromARGB(213, 0, 0, 0),
      child: Scaffold(
      
            appBar: AppBar(
           backgroundColor: const Color.fromARGB(151, 0, 0, 0),
            flexibleSpace: Stack(
              
              children:[
                Container(
        
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      
                      'https://i.pinimg.com/736x/8e/8f/6c/8e8f6cc1b7fb4d382e02ff40884f77a7.jpg',
                    ),
                    fit: BoxFit.cover, // Ajusta la imagen al espacio disponible
                  ),
                ),
              ),
              Container(
               width: screen1*0.39,
               
                decoration: BoxDecoration(
                  
                  image: DecorationImage(
                  
                    image: NetworkImage(
                     'https://i.pinimg.com/originals/bd/cd/20/bdcd20f5411ee5785889542d303ad4cb.png',
                    ),
                    
                  ),
                ),
              ),
              ],
            ),
          ),
      
  
        body: Stack(
         
          children: [  
          
              Container(
                 
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '', // Imagen de fondo
                    ),
                    fit: BoxFit.cover, 
                  ),
                ),
               ),
                
                      
                PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: pageController,
                          // onPageChanged: (value) => {
                          //   currentIndex = value,
                          //   setState(() {}),
                          // },
                          children: [
                            PokemssFragment(),
                            PerfilFragment(),
                          ],
                        ),
                      
          ],
        ),
      
      ),
    )
    );
  }
}

class PerfilFragment extends StatelessWidget {
  const PerfilFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Creando perfil fragment');
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text('Perfil'),
      ),
    );
  }
}

class PokemssFragment extends StatelessWidget {
  PokemssFragment({
    super.key,
  });

  final pokemsProvider = PokemsProvider();

  @override
  Widget build(BuildContext context) {
    // pokemsProvider.getPokems(); // !  NO SE DEBE HACER AQUI
    print('Creando pokemss fragment');
    return FutureBuilder(
      future: pokemsProvider.getPokems(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (asyncSnapshot.hasError) {
          return Center(
            child: Text('Error: ${asyncSnapshot.error}'),
          );
        }

        if (!asyncSnapshot.hasData) {
          return Center(
            child: Text('No hay datos'),
          );
        }

        final pokemss = asyncSnapshot.data!;

        return GridView.builder(
         padding: EdgeInsets.all(2.0),
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columnas
             crossAxisSpacing: 1,
    mainAxisSpacing: 1,
    childAspectRatio: 1.1, // Ajusta la proporción según necesites
  ),
  itemCount: pokemss.length, // Lista de pokemss
  itemBuilder: (context, index) {
    return ItemList(pokems: pokemss[index]);
  },
);

      },
    );
  }
}
