import 'package:bookstore/helper/api.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:bookstore/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddCommentForRating extends StatelessWidget {
  const AddCommentForRating({Key? key, required this.bookid});
  final String bookid;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> addCommentFormKey = GlobalKey();
    TextEditingController addCommentController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: addCommentFormKey,
        child: CustomTextFormField(
          controller: addCommentController,
          obscureText: false,
          hintText: 'Add Comment ...',
          suffixIcon: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RateBookDialog(
                    bookid: bookid,
                    addCommentController: addCommentController,
                  );
                },
              );
            },
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}

class RateBookDialog extends StatefulWidget {
  final String bookid;
  final TextEditingController addCommentController;

  RateBookDialog({required this.bookid, required this.addCommentController});

  @override
  _RateBookDialogState createState() => _RateBookDialogState();
}

class _RateBookDialogState extends State<RateBookDialog> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Rate this Book ..")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBarWidget2(
            size: 40,
            rating: rating,
            onRatingUpdate: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final response = await Api().post(
              token: CacheNetwork.getCacheData(key: 'token'),
              url:
                  'https://book-store-api-mu.vercel.app/User/Reviews/${widget.bookid}',
              body: {
                'rating': rating.toString(),
                'comment': widget.addCommentController.text,
              },
            );
            if (response != null) {
              widget.addCommentController.clear();
              Navigator.pop(context);
            }
          },
          child: const Text(
            "ok",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}

class RatingBarWidget2 extends StatelessWidget {
  final double size;
  final double rating;
  final Function(double) onRatingUpdate;

  RatingBarWidget2({
    required this.size,
    required this.rating,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: size,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
