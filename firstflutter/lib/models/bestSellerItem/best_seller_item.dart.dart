// lib/models/best_seller_item.dart

class BestSellerItem {
  final String id; // Keep as String because JSON provides it as a string
  final String title;
  final String author;
  final double price;
  final double originalPrice; // Changed to double to accommodate price values
  final String image;
  final String stock;
  final String category;

  BestSellerItem({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.originalPrice,
    required this.image,
    required this.stock,
    required this.category,
  });

  // Factory method to create an instance of BestSellerItem from a JSON object
  factory BestSellerItem.fromJson(Map<String, dynamic> json) {
    return BestSellerItem(
      id: json['id']?.toString() ?? '', // Ensure it's a string and provide default
      title: json['title'] ?? 'Unknown Title',
      author: json['author'] ?? 'Unknown Author',
      price: (json['price'] ?? 0).toDouble(), // Convert to double and provide default
      originalPrice: (json['originalPrice'] ?? 0).toDouble(), // Convert to double and provide default
      image: json['image'] ?? '',
      stock: json['stock'] ?? 'Out of Stock',
      category: json['category'] ?? 'Uncategorized',
    );
  }

  // Method to convert BestSellerItem instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'price': price,
      'originalPrice': originalPrice,
      'image': image,
      'stock': stock,
      'category': category,
    };
  }
}
