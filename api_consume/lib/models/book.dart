class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final double originalPrice;
  final String image;
  final int stock;
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
      price: json['price'].toDouble(),
      originalPrice: json['originalPrice'].toDouble(),
      image: json['image'],
      stock: int.parse(json['stock']),
      category: json['category'],
    );
  }
}
