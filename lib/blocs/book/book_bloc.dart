import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_event.dart';
import 'book_state.dart';
import '../../services/api_service.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<SearchBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await ApiService.fetchBooks(event.query);
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Erreur: ${e.toString()}'));
      }
    });
  }
}
