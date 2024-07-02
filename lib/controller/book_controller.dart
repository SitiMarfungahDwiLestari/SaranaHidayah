import 'package:get/get.dart';
import 'package:sarana_hidayah/model/book.dart';
import 'package:sarana_hidayah/service/book_service.dart';

class BookController extends GetxController {
  final BookService bookService = BookService();

  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void fetchBooks() async {
    try {
      List<dynamic> bookData = await bookService.fetchBooks();
      List<Book> bookList = bookData.map((json) => Book.fromMap(json)).toList();
      books.value = bookList;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch books');
    }
  }

  void addBook(String title, String author, int publicationYear, double price,
      String description, int categoryId, String imagePath) async {
    try {
      await bookService.addBook(title, author, publicationYear, price,
          description, categoryId, imagePath);
      fetchBooks();
    } catch (e) {
      print(e);
      throw Exception('Failed to add book');
    }
  }

  void updateBook(int id, String title, String author, int publicationYear,
      double price, String description, int categoryId,
      [String? imagePath]) async {
    try {
      await bookService.updateBook(id, title, author, publicationYear, price,
          description, categoryId, imagePath);
      fetchBooks();
    } catch (e) {
      print(e);
      throw Exception('Failed to update book');
    }
  }

  void deleteBook(int id) async {
    try {
      await bookService.deleteBook(id);
      fetchBooks();
    } catch (e) {
      print(e);
      throw Exception('Failed to delete book');
    }
  }
}
