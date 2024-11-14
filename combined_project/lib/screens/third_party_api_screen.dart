import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ThirdPartyApiScreen extends StatefulWidget {
  @override
  _ThirdPartyApiScreenState createState() => _ThirdPartyApiScreenState();
}

class _ThirdPartyApiScreenState extends State<ThirdPartyApiScreen> {
  Map<String, dynamic> data = {};

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));
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
        title: Text('Third-Party API Screen'),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Bitcoin Price Index', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('USD: ${data['bpi']['USD']['rate']}', style: TextStyle(fontSize: 20)),
            Text('GBP: ${data['bpi']['GBP']['rate']}', style: TextStyle(fontSize: 20)),
            Text('EUR: ${data['bpi']['EUR']['rate']}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
