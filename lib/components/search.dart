import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const SearchPage({super.key, required this.data});

  @override
  _SearchPageState createState() => _SearchPageState(data: data);
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> data;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  _SearchPageState({required this.data});

  void _performSearch(String query) {
    setState(() {
      searchResults = data.where((product) {
        final title = product['title'].toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _performSearch(value);
              },
              decoration: const InputDecoration(labelText: 'Search'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(searchResults[index]['title']),
                    subtitle: Text(searchResults[index]['description']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
