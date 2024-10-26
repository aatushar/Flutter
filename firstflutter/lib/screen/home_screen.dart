import 'dart:convert';
import 'package:firstflutter/models/bestSellerItem/best_seller_item.dart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class EmploymentHomePage extends StatefulWidget {
  @override
  _EmploymentHomePageState createState() => _EmploymentHomePageState();
}

class _EmploymentHomePageState extends State<EmploymentHomePage> {
  List<BestSellerItem> bestSellerItems = []; // Change to list of BestSellerItem
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBestSellerItems();
  }

  Future<void> fetchBestSellerItems() async {
    final uri = Uri.parse('http://157.230.251.1:8011/api/website/best-seller-items');
    print(uri); // Log the URI
    final response = await http.get(uri);


    if (response.statusCode == 200) {
      setState(() {
        // Parse the JSON response into a list of BestSellerItem
        final List<dynamic> jsonData = jsonDecode(response.body);
        bestSellerItems = jsonData.map((item) => BestSellerItem.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Seller Items"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: bestSellerItems.length,
        itemBuilder: (context, index) {
          final item = bestSellerItems[index];
          return Card(
            child: ListTile(
              leading: Image.network(item.image, height: 60, width: 40, fit: BoxFit.cover),
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Author: ${item.author}"),
                  Text("Price: \$${item.price} (Original: \$${item.originalPrice})"),
                  Text("Stock: ${item.stock}"),
                  Text("Category: ${item.category}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
