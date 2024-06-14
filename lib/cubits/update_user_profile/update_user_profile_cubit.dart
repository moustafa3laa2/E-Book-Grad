import 'package:bloc/bloc.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'update_user_profile_state.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  UpdateUserProfileCubit() : super(UpdateUserProfileInitial());

  GlobalKey<FormState> editFormKey = GlobalKey();
  TextEditingController editFirstName = TextEditingController();
  TextEditingController editLastName = TextEditingController();
  TextEditingController editUserName = TextEditingController();
  TextEditingController editEmail = TextEditingController();

  Future<void> updateUserProfile() async {
    final url = Uri.parse('https://book-store-api-mu.vercel.app/User/Edit');

    try {
      emit(UpdateUserProfileLoading());
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: 'token')}'
        },
        body: {
          'firstname': editFirstName.text,
          // 'lastname': editLastName.text,
          // 'username': editUserName.text,
          // 'email': editEmail.text,
        },
      );

      if (response.statusCode == 200) {
        emit(UpdateUserProfileSuccess());
      } else {
        // The request failed
        print(
            'Failed to update user profile. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('An error occurred: $error');
    }
  }
}
