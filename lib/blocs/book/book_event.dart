import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBooks extends BookEvent {
  final String query;
  SearchBooks(this.query);

  @override
  List<Object?> get props => [query];
}