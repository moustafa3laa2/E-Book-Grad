import 'package:bookstore/constants.dart';
import 'package:bookstore/models/book_id_model.dart';
import 'package:bookstore/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class CommentsOfBook extends StatefulWidget {
  const CommentsOfBook(
      {super.key, required this.bookid, required this.reviews});
  final String bookid;
  final List<Review> reviews;

  @override
  State<CommentsOfBook> createState() => _CommentsOfBookState();
}

class _CommentsOfBookState extends State<CommentsOfBook> {
  @override
  Widget build(BuildContext context) {
    var reviews = widget.reviews;

    return widget.reviews.length == 0
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nocomments.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                    'No Comments Yet',
                    style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 20),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: widget.reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${reviews[index].user!.firstname} ${reviews[index].user!.lastname}',
                              style: TextStyle(
                                  fontSize: getResponsiveFontSize(context,
                                      fontSize: 20),
                                  fontWeight: FontWeight.bold),
                            ),
                            RatingBarWidget(
                              rating: reviews[index].rating.toDouble(),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/accountpic.png'),
                        title: Text(
                          reviews[index].comment.toString(),
                          style: TextStyle(
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ));
  }
}
