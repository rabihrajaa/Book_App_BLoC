import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static Future<List<Book>> fetchBooks(String query) async {
    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception('Erreur lors du chargement des livres');
    }
  }
}
