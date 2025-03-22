import 'package:flutter/material.dart';

class DetallePokemonPage extends StatefulWidget {
  const DetallePokemonPage({super.key, required this.id, this.extras});

  final String id;
  final Map? extras;

  @override
  _DetallePokemonPageState createState() => _DetallePokemonPageState();
}

class _DetallePokemonPageState extends State<DetallePokemonPage> {
  late String ChangeImage;

  // Inicializar la variable antes que cargue la pantalla
  @override
  void initState() {
    super.initState();
   
    ChangeImage = widget.extras?['img'] ??
        'https://img.freepik.com/free-vector/glitch-error-404-page-background_23-2148083447.jpg?t=st=1741201077~exp=1741204677~hmac=7f4799125ec835eedf2222dc7a34eb8ac8a01acc5bedb2ac25473fb55d91b096&w=740';
  }

  @override
  Widget build(BuildContext context) {
    final VertLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
           icon: Icon(Icons.arrow_back),
           color: const Color.fromARGB(255, 253, 253, 253),
           ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: const Color.fromARGB(255, 253, 253, 253),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.green[400],
      body: SingleChildScrollView(
              physics: VertLandscape ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(1.0),
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      ChangeImage,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                
                  // Tipos del Pokémon
                  Text(
                    ' Tipos',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 248, 245, 245),
                    ),
                  ),
                  Wrap(
                    
                    spacing: 5,
                    children: widget.extras?['type']
                        .map<Widget>((type) => Chip(
                              label: Text(
                                type,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: _getTypeColor(type),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),

                  // Sección  para el verde 
                  Container(
                   width: MediaQuery.of(context).size.width*0.99,
                   height: MediaQuery.of(context).size.height*0.99,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 252, 250), 
                      borderRadius: BorderRadius.circular(35),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Debilidades:',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 220, 80, 239),
                          ),
                        ),
                        SizedBox(height: 10),
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

                        // Altura y peso
                 
                          Text(
                            'Altura: ${widget.extras?['height']}',
                            style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 17, 17, 17) , fontWeight: FontWeight.bold),
                          ),
                      
                        SizedBox(height: 10),
              
                         Text(
                            'Peso: ${widget.extras?['weight']}',
                            style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 17, 17, 17) , fontWeight: FontWeight.bold),
                            
                          ),
            
                        SizedBox(height: 16),

                        // Candy y spawn time
                    
                          Text(
                            'Candy: ${widget.extras?['candy']}',
                            style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 17, 17, 17) , fontWeight: FontWeight.bold),
                          ),
      
                        SizedBox(height: 10),
                   
                           Text(
                            'Candy Count: ${widget.extras?['candy_count'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 17, 17, 17) , fontWeight: FontWeight.bold),
                          ),
                      
                        SizedBox(height: 16),
                         Text(
                            'Tiempo de aparición: ${widget.extras?['spawn_time']}',
                            style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 17, 17, 17) , fontWeight: FontWeight.bold),
                          ),
                        
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );

  }

  // Función para obtener el color según el tipo de Pokémon
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