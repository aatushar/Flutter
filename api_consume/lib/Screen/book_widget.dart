import 'package:api_consume/models/book.dart';
import 'package:flutter/material.dart';


class BookWidget extends StatelessWidget {
  final Book book;

  BookWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(book.image, width: 80, height: 120),
          Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${book.price} BDT', style: TextStyle(color: Colors.green)),
          Text('${book.originalPrice} BDT', style: TextStyle(decoration: TextDecoration.lineThrough)),
          Text('Stock: ${book.stock}'),
        ],
      ),
    );
  }
}
