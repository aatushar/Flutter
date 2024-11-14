// author_model.dart

class Author {
  final int id;
  final String name;
  final String image;
  final String description;
  final List<Book> books;

  Author({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.books,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    var bookList = json['books'] as List;
    List<Book> books = bookList.map((book) => Book.fromJson(book)).toList();

    return Author(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      books: books,
    );
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  final int price;
  final int originalPrice;
  final String image;
  final String stock;
  final String category;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.originalPrice,
    required this.image,
    required this.stock,
    required this.category,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      price: json['price'],
      originalPrice: json['originalPrice'],
      image: json['image'],
      stock: json['stock'],
      category: json['category'],
    );
  }
}
