import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/category_controller.dart';
import 'package:sarana_hidayah/model/category.dart';
import 'package:sarana_hidayah/widgets/drawer_widget.dart';
import 'package:sarana_hidayah/widgets/header_widget.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(title: 'Category'),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  return ListTile(
                    title: Text(category.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            nameController.text = category.name;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Edit Category'),
                                  content: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        hintText: 'Category Name'),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        final updatedCategory = Category(
                                          id: category.id,
                                          name: nameController.text,
                                        );
                                        categoryController.updateCategory(
                                            category.id, nameController.text);
                                        Get.back();
                                      },
                                      child: Text('Update'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            categoryController.deleteCategory(category.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Category Name'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    categoryController.addCategory(nameController.text);
                    nameController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
