import 'package:bookstore/constants.dart';
import 'package:bookstore/core/services/get_fav_book_services.dart';
import 'package:bookstore/models/fav_books_model.dart';
import 'package:bookstore/widgets/searchcardofbbok.dart';
import 'package:flutter/material.dart';

class UserFavouriteBooks extends StatelessWidget {
  const UserFavouriteBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favourite Books',
            style: TextStyle(
              color: Colors.black,
              fontSize: getResponsiveFontSize(context, fontSize: 24),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<FavBooksModel>>(
            future: GetFavBooksServices().getFavBooks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<FavBooksModel> favBooks = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: favBooks.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SearchCardOfCartBook(
                        title: favBooks[index].title,
                        autherName: favBooks[index].author,
                        bookid: favBooks[index].id,
                        category: favBooks[index].category,
                        image: favBooks[index].image.url,
                        price: favBooks[index].price.toString(),
                      ),
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
