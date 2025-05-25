class Book {
  final String id;
  final String title;
  final String author;
  final String thumbnail;

  Book({required this.id, required this.title, required this.author, required this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Titre inconnu',
      author: (volumeInfo['authors'] != null) ? (volumeInfo['authors'] as List).join(", ") : 'Auteur inconnu',
      thumbnail: volumeInfo['imageLinks'] != null ? volumeInfo['imageLinks']['thumbnail'] : '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnail': thumbnail,
      };
}