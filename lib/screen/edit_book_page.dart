import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarana_hidayah/controller/book_controller.dart';
import 'package:sarana_hidayah/model/book.dart';
import 'package:sarana_hidayah/controller/category_controller.dart';
import 'package:sarana_hidayah/model/category.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  EditBookPage({required this.book});

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final BookController bookController = Get.find<BookController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController publicationYearController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  XFile? _image;
  Category? _selectedCategory;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      bookController.updateBook(
        widget.book.id,
        titleController.text,
        authorController.text,
        int.parse(publicationYearController.text),
        int.parse(priceController.text),
        descriptionController.text,
        _selectedCategory!.id,
        _image?.path,
      );

      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    publicationYearController =
        TextEditingController(text: widget.book.publicationYear.toString());
    priceController = TextEditingController(text: widget.book.price.toString());
    descriptionController =
        TextEditingController(text: widget.book.description);

    _selectedCategory = categoryController.categories.firstWhere(
      (category) => category.id == widget.book.categoryId,
      orElse: () => categoryController.categories.first,
    );

    categoryController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Book',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff134f5c),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xff134f5c),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xff134f5c),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: publicationYearController,
                decoration: InputDecoration(
                  labelText: 'Publication Year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xff134f5c),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the publication year';
                  }
                  if (int.tryParse(value) == null ||
                      int.parse(value) < 1000 ||
                      int.parse(value) > DateTime.now().year) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xff134f5c),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xff134f5c),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Obx(() => DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    items: categoryController.categories
                        .map((category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.name),
                            ))
                        .toList(),
                    onChanged: (Category? value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xff134f5c),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 10),
              _image == null
                  ? Image.network(widget.book.image,
                      height: 200, fit: BoxFit.cover)
                  : Image.file(File(_image!.path),
                      height: 200, fit: BoxFit.cover),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text(_image == null ? 'Select Image' : 'Change Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
