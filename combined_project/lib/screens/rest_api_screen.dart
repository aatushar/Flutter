import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestApiScreen extends StatefulWidget {
  @override
  _RestApiScreenState createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API Screen'),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['title']),
            subtitle: Text(data[index]['body']),
          );
        },
      ),
    );
  }
}
