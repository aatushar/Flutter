import 'package:flutter/material.dart';
import 'package:test_flutter/model/PublicationWiseBookList.dart';
import 'package:test_flutter/service/PublicationWiseBookListService.dart';

class AllPublicationWiseBookListViewPage extends StatefulWidget {
  const AllPublicationWiseBookListViewPage({super.key});

  @override
  State<AllPublicationWiseBookListViewPage> createState() => _AllPublicationWiseBookListViewPageState();
}

class _AllPublicationWiseBookListViewPageState extends State<AllPublicationWiseBookListViewPage> {
  late Future<List<PublicationWiseBookList>> futurePublicationWiseBookList;

  @override
  void initState() {
    super.initState();
    futurePublicationWiseBookList = PublicationWiseBookListService().fetchPublicationWiseBookLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publication Wise Book List"),
      ),
      body: FutureBuilder<List<PublicationWiseBookList>>(
        future: futurePublicationWiseBookList,
        builder: (BuildContext context, AsyncSnapshot<List<PublicationWiseBookList>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Publication available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final publication = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: publication.image != null
                            ? Image.network(
                          "http://157.230.251.1:8011/api/website/publication-wise-book-list/${publication.image}",
                          width: 50,  // Adjust the size as needed
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Display an error icon if the image fails to load
                          },
                        )
                            : Icon(Icons.book),
                        title: Text(publication.name ?? 'Unnamed Publication'),
                        subtitle: publication.books != null && publication.books!.isNotEmpty
                            ? Text('Books Available: ${publication.books!.length}')
                            : Text('No Books Available'),
                      )
                      ,
                      if (publication.books != null && publication.books!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: publication.books!.map((book) {
                              return Text(
                                "${book.title ?? 'Unnamed Book'} by ${book.author ?? 'Unknown Author'}",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
