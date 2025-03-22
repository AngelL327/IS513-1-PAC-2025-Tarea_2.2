import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemsProvider {
  Future<List<Map<String, dynamic>>> getPokems() async {
    final url = Uri.parse('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar el JSON como un mapa
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extraer la lista de Pokémon de la clave 'pokemon'
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonData['pokemon']);

        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}