import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/controller/cart_controller.dart';
import 'package:sarana_hidayah/model/book.dart';
import 'package:sarana_hidayah/controller/book_controller.dart';
import 'package:sarana_hidayah/screen/book/add_book_page.dart';
import 'package:sarana_hidayah/screen/book/detail_book_page.dart';
import 'package:sarana_hidayah/screen/book/edit_book_page.dart';
import 'package:sarana_hidayah/widgets/drawer_widget.dart';
import 'package:sarana_hidayah/widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookController bookController = Get.put(BookController());
  final AuthController authController = Get.put(AuthController());
  final CartController cartController = Get.put(CartController());
  var quantity = 1.obs;

  @override
  void initState() {
    super.initState();
    bookController.fetchBooks();
  }

  void _addBook() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBookPage()),
    );
  }

  void _editBook(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBookPage(book: book)),
    );
  }

  void _viewBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailBookPage(book: book)),
    );
  }

  void _showQuantityDialog(Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Jumlah Buku'),
          content: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity.value > 1) {
                      quantity.value--;
                    }
                  },
                ),
                Text(quantity.value.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    quantity.value++;
                  },
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Tambahkan ke Keranjang'),
              onPressed: () {
                _addToCart(book);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToCart(Book book) {
    cartController.addToCart(book.id, quantity.value).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${book.title} berhasil ditambahkan ke keranjang'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan ke keranjang: $error'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return HeaderWidget(
            title: 'Catalog',
            isAdmin: authController.isAdmin.value,
          );
        }),
      ),
      drawer: Obx(() => DrawerWidget(isAdmin: authController.isAdmin.value)),
      body: Obx(() {
        if (bookController.books.isEmpty) {
          return const Center(child: Text('No books found'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.6,
          ),
          itemCount: bookController.books.length,
          itemBuilder: (context, index) {
            Book book = bookController.books[index];
            final formatCurrency = NumberFormat.currency(
              locale: 'id_ID',
              symbol: 'Rp',
              decimalDigits: 0,
            );
            String formattedPrice = formatCurrency.format(book.price);

            return GestureDetector(
              onTap: () {
                _viewBookDetails(book);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          book.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${book.author} - ${book.publicationYear}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedPrice,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        if (authController.isAdmin.value) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editBook(book);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  bookController.deleteBook(book.id);
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    _showQuantityDialog(book);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff134f5c),
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 50,
                                          color: Color(0xffEEEEEE),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Masukkan Keranjang",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: Obx(() {
        return Visibility(
          visible: authController.isAdmin.value,
          child: FloatingActionButton(
            onPressed: _addBook,
            child: const Icon(Icons.add),
            tooltip: 'Add Book',
          ),
        );
      }),
    );
  }
}
