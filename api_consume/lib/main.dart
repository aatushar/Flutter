import 'package:api_consume/models/author.dart';
import 'package:api_consume/services/author_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Author-wise Book List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthorListScreen(),
    );
  }
}

class AuthorListScreen extends StatefulWidget {
  @override
  _AuthorListScreenState createState() => _AuthorListScreenState();
}

class _AuthorListScreenState extends State<AuthorListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Author>> futureAuthors;

  @override
  void initState() {
    super.initState();
    futureAuthors = apiService.fetchAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author-wise Book List'),
      ),
      body: FutureBuilder<List<Author>>(
        future: futureAuthors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No authors found'));
          }

          List<Author> authors = snapshot.data!;

          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (context, index) {
              Author author = authors[index];
              return ListTile(
                leading: Image.network(author.image),
                title: Text(author.name),
                subtitle: Text(author.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookListScreen(author: author),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class BookListScreen extends StatelessWidget {
  final Author author;

  BookListScreen({required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${author.name} - Books'),
      ),
      body: ListView.builder(
        itemCount: author.books.length,
        itemBuilder: (context, index) {
          Book book = author.books[index];
          return ListTile(
            leading: Image.network(book.image),
            title: Text(book.title),
            subtitle: Text('${book.price} BDT'),
          );
        },
      ),
    );
  }
}
