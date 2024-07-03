import 'package:flutter/material.dart';
import 'package:sarana_hidayah/model/book.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/category_controller.dart';
import 'package:sarana_hidayah/model/category.dart';

class DetailBookPage extends StatelessWidget {
  final Book book;

  DetailBookPage({required this.book});

  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    final category = categoryController.categories.firstWhere(
      (category) => category.id == book.categoryId,
      orElse: () => Category(id: 0, name: 'Unknown'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff134f5c),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (book.image != null && book.image!.isNotEmpty)
              Image.network(book.image!, height: 200, fit: BoxFit.cover)
            else
              Container(
                height: 200,
                color: Colors.grey,
                child: Center(child: Text('No Image Available')),
              ),
            SizedBox(height: 20),
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Author: ${book.author}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Publication Year: ${book.publicationYear}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${book.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${category.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
