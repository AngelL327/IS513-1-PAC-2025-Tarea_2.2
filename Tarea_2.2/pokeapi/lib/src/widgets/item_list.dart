import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.pokems});

  final Map<String, dynamic> pokems;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getTypeColor(pokems['type'][0]), // Color según el tipo principal
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
        side: BorderSide(
          color: Color(0xFF0D0D1A),
          width: 2.0,
        )

      ),
      child: InkWell(
        onTap: () {
          context.goNamed(
            'detalle-pokems',
            pathParameters: {
              'pokemsId': pokems['id'].toString(),
            },
            extra: pokems,
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen del Pokémon
            
              Stack(
                children: [
                  Stack(
  alignment: Alignment.center,
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        'https://www.pngall.com/wp-content/uploads/4/Pokeball-PNG-Free-Download.png',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 50, color: Colors.white),
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        pokems['img'],
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 50, color: Colors.white),
      ),
    ),
  ],
)
                ],
              ),
              SizedBox(height: 5),
              
              // Nombre del Pokémon
              Text(
                _parsedTitle(pokems['name']),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para obtener el color según el tipo de Pokémon
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire': return Colors.orange.shade600;
      case 'water': return Colors.blue.shade600;
      case 'grass': return Colors.green.shade600;
      case 'electric': return Colors.yellow.shade600;
      case 'psychic': return Colors.purple.shade600;
      case 'ice': return Colors.cyan.shade600;
      case 'dragon': return Colors.indigo.shade600;
      case 'dark': return Colors.brown.shade600;
      case 'fairy': return Colors.pink.shade300;
      case 'normal': return Colors.grey.shade600;
      case 'fighting': return Colors.red.shade600;
      case 'flying': return Colors.lightBlue.shade300;
      case 'poison': return Colors.purple.shade800;
      case 'ground': return Colors.brown.shade400;
      case 'rock': return Colors.grey.shade800;
      case 'bug': return Colors.lightGreen.shade600;
      case 'ghost': return Colors.deepPurple.shade600;
      case 'steel': return Colors.blueGrey.shade600;
      default: return Colors.grey;
    }
  }

  // Función para acortar el título si es muy largo
  String _parsedTitle(String title) {
    return title.length > 20 ? '${title.substring(0, 20)}...' : title;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Map<String, dynamic>>('pokems', pokems));
  }
}