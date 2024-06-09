import 'package:bookstore/core/errors/errorbooks.dart';
import 'package:bookstore/cubits/get_books/get_Category_books/get_books_cubit.dart';
import 'package:bookstore/cubits/get_books/get_user_own__books/get_books_cubit.dart';
import 'package:bookstore/widgets/custom_loading_big_card.dart';
import 'package:bookstore/widgets/searchcardofbbok.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCardOfCategoryListView extends StatefulWidget {
  const BookCardOfCategoryListView({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<BookCardOfCategoryListView> createState() =>
      _BookCardOfCategoryListViewState();
}

class _BookCardOfCategoryListViewState
    extends State<BookCardOfCategoryListView> {
  @override
  void initState() {
    super.initState();
    context.read<GetCategoryBooksCubit>().getCategorybooks(widget.categoryName);
    context.read<GetownBooksCubit>().getownBooks();
  }

  bool ownershipCheckComplete = false;

  final Map<String, bool> ownedBooks = {};
  void checkIfOwned(String bookId) {
    final ownBooksState = context.read<GetownBooksCubit>().state;

    if (ownBooksState is GetownBooksSuccess) {
      final ownBooks = ownBooksState.books.books!;

      for (var book in ownBooks) {
        if (book.sId == bookId) {
          ownedBooks[bookId] = true;
          ownershipCheckComplete = true;
          return;
        }
      }
      ownedBooks[bookId] = false;
      ownershipCheckComplete = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetCategoryBooksCubit, GetCategoryState>(
              builder: (context, state) {
                if (state is GetCategoryBooksLoading) {
                  return const CustomLoadingBigCard();
                } else if (state is GetCategoryBooksSuccess) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    child: ListView.builder(
                      itemCount: state.books.books!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final favoriteBook = state.books.books![index];
                        if (!ownedBooks.containsKey(favoriteBook.sId)) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            checkIfOwned(favoriteBook.sId!);
                            setState(() {});
                          });
                        }
                        final isOwned = ownedBooks[favoriteBook.sId] ?? false;
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 12, left: 12, bottom: 12.0),
                          child: Column(
                            children: [
                              if (ownershipCheckComplete)
                                SearchCardOfCartBook(
                                  rate: state.books.books![index].averageRating
                                      .toDouble(),
                                  image: state.books.books![index].image!.url
                                      .toString(),
                                  title: state.books.books![index].title!,
                                  price: isOwned
                                      ? 'Owned'
                                      : state.books.books![index].onsale!
                                          ? state.books.books![index].saleprice!
                                              .toString()
                                          : state.books.books![index].price!
                                              .toString(),
                                  autherName: state.books.books![index].author!,
                                  category: state.books.books![index].category!,
                                  bookid: state.books.books![index].sId!,
                                )
                              else
                                Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const BooksError();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
