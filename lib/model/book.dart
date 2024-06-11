import 'dart:convert';

class Book {
  final int id;
  final int categoryId;
  final String title;
  final String author;
  final String publicationYear;
  final double price;
  final String description;
  final String image;

  Book({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? 0,
      categoryId: map['category_id'] ?? 0,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      publicationYear: map['publication_year'] ?? '',
      price:
          (map['price'] != null) ? double.parse(map['price'].toString()) : 0.0,
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'author': author,
      'publication_year': publicationYear,
      'price': price,
      'description': description,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
