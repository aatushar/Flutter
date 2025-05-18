import 'package:flutter/material.dart';

class FoodHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF8E9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.person_outline, color: Colors.black),
            SizedBox(width: 8),
            Text('Welcome,', style: TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            SizedBox(height: 16),
            SpecialBanner(),
            SizedBox(height: 30),
            SectionTitle(title: "Limited time"),
            SizedBox(height: 8),
            LimitedTimeDeals(),
            SizedBox(height: 16),
            SectionTitle(title: "Explore"),
            SizedBox(height: 8),
            ExploreCategories(),
            SizedBox(height: 16),
            SectionTitle(title: "Repeat order"),
            SizedBox(height: 8),
            RepeatOrderSection(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for products.",
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class SpecialBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage("assets/banner.jpg"), // Replace with actual image
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Text(
        "Special\nFresh bakery items available daily.",
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text("View all items", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

class LimitedTimeDeals extends StatelessWidget {
  final List<Map<String, String>> deals = [
    {"title": "Juicy oranges", "image": "assets/orange.jpg", "price": "N", "tag": "Discount"},
    {"title": "Sweet watermelon", "image": "assets/watermelon.jpg", "price": "N", "tag": "Save 10%"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: deals.map((deal) {
          return ProductCard(
            title: deal["title"]!,
            imageUrl: deal["image"]!,
            price: deal["price"]!,
            tag: deal["tag"]!,
            buttonText: "Add to cart",
          );
        }).toList(),
      ),
    );
  }
}

class ExploreCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "New", "icon": Icons.new_releases},
    {"name": "Big sale", "icon": Icons.local_offer},
    {"name": "Artisan", "icon": Icons.handyman},
    {"name": "Fresh", "icon": Icons.apple},  // This may cause an error, replace it if needed
    {"name": "Quality", "icon": Icons.verified},
    {"name": "Seafood", "icon": Icons.set_meal},
    {"name": "Farm", "icon": Icons.agriculture},
    {"name": "Dairy", "icon": Icons.local_drink},
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: Icon(category["icon"] as IconData, color: Colors.blue), // Explicit cast
          label: Text(category["name"] as String), // Explicit cast
          onPressed: () {},
        );
      }).toList(),
    );
  }
}


class RepeatOrderSection extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {"title": "Tasty bacon strips", "image": "assets/oragne_juice.jpg", "tag": "Limited"},
    {"title": "Fresh bananas", "image": "assets/watermelon_juice.jpg", "tag": "Great"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: orders.map((order) {
          return ProductCard(
            title: order["title"]!,
            imageUrl: order["image"]!,
            price: "",
            tag: order["tag"]!,
            buttonText: "Add to order",
          );
        }).toList(),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String tag;
  final String buttonText;

  ProductCard({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.tag,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  color: Colors.blue,
                  child: Text(tag, style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(price, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
