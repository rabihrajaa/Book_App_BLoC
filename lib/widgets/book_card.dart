import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/db_service.dart';

class BookCard extends StatefulWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    checkIfFav();
  }

  void checkIfFav() async {
    isFav = await DBService.isSaved(widget.book.id);
    setState(() {});
  }

  void toggleFavorite() async {
    if (isFav) {
      await DBService.deleteItem(widget.book.id);
    } else {
      await DBService.insertItem(widget.book);
    }
    checkIfFav();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: ListTile(
        leading: widget.book.thumbnail.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(widget.book.thumbnail, width: 50, fit: BoxFit.cover),
              )
            : null,
        title: Text(widget.book.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.book.author),
        trailing: IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          onPressed: toggleFavorite,
        ),
      ),
    );
  }
}