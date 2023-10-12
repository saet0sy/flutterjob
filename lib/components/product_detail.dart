import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 300,
              maxHeight: 400
            ),
          child: Column(
            children: [
              Image.network(
                product['image'],
                width: 225,
                height: 225,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${product['title']}'),
                    Text('Price: ${product['price']}'),
                    Text('Description: ${product['description']}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        )
      ),
    );
  }
}
