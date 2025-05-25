import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart'; // ← Assure-toi que ce fichier existe bien
import 'blocs/book/book_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc(),
      child: MaterialApp(
        title: 'Book App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: HomePage(),
      ),
    );
  }
}
