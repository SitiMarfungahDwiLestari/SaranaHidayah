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

  void fetchCategories() async {
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

  void addCategory(String name) async {
    try {
      await categoryService.addCategory(name);
      fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to add category');
    }
  }

  void updateCategory(int id, String name) async {
    try {
      await categoryService.updateCategory(id, name);
      fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to update category');
    }
  }

  void deleteCategory(int id) async {
    try {
      await categoryService.deleteCategory(id);
      fetchCategories();
    } catch (e) {
      print(e);
      throw Exception('Failed to delete category');
    }
  }
}
