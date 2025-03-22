import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/src/providers/poke_provider.dart';

class DetallePokemonPage extends StatefulWidget {
  const DetallePokemonPage({super.key, required this.id, this.extras,  });

  final String id;
  final Map? extras;
  

  @override
  _DetallePokemonPageState createState() => _DetallePokemonPageState();
}

class _DetallePokemonPageState extends State<DetallePokemonPage> {
  late String ChangeImage;
  String selectedSection = 'details';

  @override
  void initState() {
    super.initState();
    ChangeImage = widget.extras?['img'] ??
        'https://img.freepik.com/free-vector/glitch-error-404-page-background_23-2148083447.jpg?t=st=1741201077~exp=1741204677~hmac=7f4799125ec835eedf2222dc7a34eb8ac8a01acc5bedb2ac25473fb55d91b096&w=740';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 218, 229),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Expanded(
        child: Container(
        width: double.infinity, // Mantiene el ancho igual al tamaño de la pantalla
        constraints:  BoxConstraints(
          minHeight: double.infinity, 
        ),
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/#FFFFFF.jpg'),
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el contenedor
          ),
        ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del Pokémon
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 240,
                        height: 240,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              'https://i.pinimg.com/736x/8c/83/14/8c8314a0e1b76e0c38b7ea04b08eeeee.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(ChangeImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 5),
                Divider(color: Colors.white, thickness: 0.7),
                Text(
                  '       Información de ${widget.extras?['name']}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Divider(color: Colors.white, thickness: 0.7),
                const SizedBox(height: 16),
          
                // Sección de botones para seleccionar información
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSection = 'pre_evo';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedSection == 'pre_evo'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: const Text('Pre Evo'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSection = 'evo';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedSection == 'evo'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: const Text('Evo'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSection = 'details';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedSection == 'details'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      child: const Text('Detalles'),
                    ),
                  ],
                ),
          
                const SizedBox(height: 16),
          
                // Contenedor que cambia
                Container(
                  width: MediaQuery.of(context).size.width*0.999,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: _getSectionContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para devolver el contenido según la sección seleccionada
String? _getImageFromName(String name) {
  final list = widget.extras?['all_pokemon'] as List<dynamic>?;

  if (list != null) {
    final pokemon = list.firstWhere(
      (p) => p['name'] == name,
      orElse: () => null,
    );

    return pokemon?['img'];
  }

  return null;
}
String getPokemonImageUrl(String num) {
  return 'http://www.serebii.net/pokemongo/pokemon/$num.png';
}


Widget _getSectionContent() {
  if (selectedSection == 'pre_evo') {
    final prevEvolutionName = widget.extras?['prev_evolution']?[0]?['name'];
    final prevEvolutionNum = widget.extras?['prev_evolution']?[0]?['num'];
    final prevEvolutionImage = prevEvolutionNum != null
        ? getPokemonImageUrl(prevEvolutionNum)
        : 'https://i.gifer.com/5IPv.gif';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pre Evolución: ${prevEvolutionName ?? 'No disponible'}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (prevEvolutionImage != null)
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(prevEvolutionImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  } else if (selectedSection == 'evo') {
    final nextEvolutionName = widget.extras?['next_evolution']?[0]?['name'];
    final nextEvolutionNum = widget.extras?['next_evolution']?[0]?['num'];
    final nextEvolutionImage = nextEvolutionNum != null
        ? getPokemonImageUrl(nextEvolutionNum)
        : 'https://i.gifer.com/4m3s.gif';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evolución: ${nextEvolutionName ?? 'No disponible'}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (nextEvolutionImage != null)
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(nextEvolutionImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  } else {
    // Detalles
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
          'Tipos:',
           style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 220, 80, 239),
       ),
     ),
      SizedBox(height: 10),
      Divider(
      endIndent: 0.1,
      color: const Color.fromARGB(255, 30, 31, 32),
      thickness: 0.7,
          ),
       Wrap(
      spacing: 5,
      children: widget.extras?['type']
      .map<Widget>((Type) => Chip(
       label: Text(
         Type,
       style: TextStyle(color: Colors.white),
      ),
         backgroundColor: _getTypeColor(Type),
                                    //backgroundColor: const Color.fromARGB(255, 220, 80, 239),
        ))
    .toList(),
      ),
     SizedBox(height: 16),
      Text(
          'Debilidades:',
           style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 220, 80, 239),
       ),
     ),
    SizedBox(height: 10),
    Divider(
      endIndent: 0.1,
      color: const Color.fromARGB(255, 30, 31, 32),
      thickness: 0.7,
  ),
    Wrap(
      spacing: 5,
      children: widget.extras?['weaknesses']
      .map<Widget>((weakness) => Chip(
       label: Text(
         weakness,
       style: TextStyle(color: Colors.white),
      ),
    backgroundColor: _getTypeColor(weakness),
                                    //backgroundColor: const Color.fromARGB(255, 220, 80, 239),
        ))
    .toList(),
   ),
          SizedBox(height: 16),
        Text(
          'Altura: ${widget.extras?['height']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Peso: ${widget.extras?['weight']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Candy: ${widget.extras?['candy']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Candy Count: ${widget.extras?['candy_count'] ?? 'N/A'}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Tiempo de aparición: ${widget.extras?['spawn_time']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

 Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.orange.shade600;
      case 'water':
        return Colors.blue.shade600;
      case 'grass':
        return Colors.green.shade600;
      case 'electric':
        return Colors.yellow.shade600;
      case 'psychic':
        return Colors.purple.shade600;
      case 'ice':
        return Colors.cyan.shade600;
      case 'dragon':
        return Colors.indigo.shade600;
      case 'dark':
        return Colors.brown.shade600;
      case 'fairy':
        return Colors.pink.shade300;
      case 'normal':
        return Colors.grey.shade600;
      case 'fighting':
        return Colors.red.shade600;
      case 'flying':
        return Colors.lightBlue.shade300;
      case 'poison':
        return Colors.purple.shade800;
      case 'ground':
        return Colors.brown.shade400;
      case 'rock':
        return Colors.grey.shade800;
      case 'bug':
        return Colors.lightGreen.shade600;
      case 'ghost':
        return Colors.deepPurple.shade600;
      case 'steel':
        return Colors.blueGrey.shade600;
      default:
        return Colors.grey;
    }
  }
}
