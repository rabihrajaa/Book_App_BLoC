// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/book.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = DBService.getItems();
  }

  void refresh() {
    setState(() {
      futureBooks = DBService.getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10),
              ],
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Vos favoris',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: futureBooks,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final books = snapshot.data!;
                if (books.isEmpty) {
                  return const Center(child: Text('Aucun favori pour le moment.'));
                }
                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: books.map((book) => ListTile(
                    leading: book.thumbnail.isNotEmpty ? Image.network(book.thumbnail, width: 50) : null,
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await DBService.deleteItem(book.id);
                        refresh();
                      },
                    ),
                  )).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
