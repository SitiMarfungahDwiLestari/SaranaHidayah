import 'package:get/get.dart';
import 'package:sarana_hidayah/model/book.dart';
import 'package:sarana_hidayah/service/book_service.dart';

class BookController extends GetxController {
  final BookService bookService = BookService();

  Future<List<Book>> getBooks() async {
    try {
      List<dynamic> bookData = await bookService.fetchBooks();
      List<Book> books = bookData.map((json) => Book.fromMap(json)).toList();
      return books;
    } catch (e) {
      print(e);
      throw Exception('Failed to get books');
    }
  }
}
