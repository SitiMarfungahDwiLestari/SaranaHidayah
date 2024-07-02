import 'package:get/get.dart';
import 'package:sarana_hidayah/model/category.dart';
import 'package:sarana_hidayah/service/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService categoryService = CategoryService();

  var categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<dynamic> categoryData = await categoryService.fetchCategories();
      List<Category> categoryList =
          categoryData.map((json) => Category.fromMap(json)).toList();
      categories.value = categoryList;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch categories');
    }
  }

  Future<void> addCategory(String name) async {
    try {
      await categoryService.addCategory(name);
      await fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to add category');
    }
  }

  Future<void> updateCategory(int id, String name) async {
    try {
      await categoryService.updateCategory(id, name);
      await fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await categoryService.deleteCategory(id);
      await fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to delete category');
    }
  }
}
