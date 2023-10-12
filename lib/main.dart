import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/product_detail.dart';
import 'components/search.dart';

Future<List<Map<String, dynamic>>> fetchData(String url) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as List<dynamic>;
    return jsonData.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PayLess'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Products'),
                Tab(text: 'Places'),
              ],
            ),
          ),
          body: TabBarView(
            children: [

              // Вкладка "Products"
              FutureBuilder(
                future: fetchData('http://10.0.2.2:8000/products'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else {
                    final data = snapshot.data as List<Map<String, dynamic>>;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetailPage(product: data[index]),
                              ),
                            );
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Image.network(data[index]['image'],
                                width: 150,
                                height: 150,
                                ),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index]['title']),
                                    Text(data[index]['price']),
                                  ],
                                ))
                              ],
                            )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              // Вкладка "Places"
              FutureBuilder(
                future: fetchData('http://10.0.2.2:8000/places'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else {
                    final data = snapshot.data as List<Map<String, dynamic>>;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(data[index]['title']),
                              Text(data[index]['address']),
                              Text(data[index]['description']),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
