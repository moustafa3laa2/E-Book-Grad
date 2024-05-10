import 'package:bookstore/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddCommentForRating extends StatelessWidget {
  const AddCommentForRating({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: CustomTextFormField(
        obscureText: false,
        hintText: 'Add Comment ...',
        suffixIcon: Icon(Icons.send),
      ),
    );
  }
}
