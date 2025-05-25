import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/book/book_bloc.dart';
import '../blocs/book/book_event.dart';
import '../blocs/book/book_state.dart';
import '../widgets/book_card.dart';
import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  final controller = TextEditingController();

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
              boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 10)],
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text('Recherche de livres', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage())),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Mot-clé'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => context.read<BookBloc>().add(SearchBooks(controller.text)),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookLoading) return const Center(child: CircularProgressIndicator());
                if (state is BookLoaded) return ListView(children: state.books.map((book) => BookCard(book: book)).toList());
                if (state is BookError) return Center(child: Text(state.message));
                return const Center(child: Text('Tapez un mot-clé pour rechercher un livre.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
