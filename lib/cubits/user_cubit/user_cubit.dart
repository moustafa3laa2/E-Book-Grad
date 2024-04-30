import 'package:bloc/bloc.dart';
import 'package:bookstore/constants.dart';
import 'package:bookstore/core/services/get_fav_book_services.dart';
import 'package:bookstore/helper/api.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:bookstore/models/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up FirstName
  TextEditingController signUpFirstName = TextEditingController();
  //Sign up Last Name
  TextEditingController signUpLastName = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up UserName
  TextEditingController signUpUserName = TextEditingController();
  // SignInModel? signInModel;

  Future<void> signIn() async {
    try {
      emit(SignInLoading());
      final response = await Api().post(
        token: kToken,
        url: 'https://book-store-api-mu.vercel.app/User/Login',
        body: {
          'username': signInEmail.text,
          'password': signInPassword.text,
        },
      );

      // Parse the response body
      // final jsonData = jsonDecode(response.body);
      final signInModel = SignInModel.fromJson(response['UserInformation']);
      await CacheNetwork.insertToCache(key: "token", value: response['token']);
      emit(
        SignInSuccess(signInModel: signInModel),
      );
      print(
        'token is ${CacheNetwork.getCacheData(key: 'token')}',
      );
      print(GetFavBooksServices().getFavBooks());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }

  signUp() async {
    try {
      emit(SignUpLoading());
      Api().post(
          url: 'https://book-store-api-mu.vercel.app/User/Register',
          body: {
            'firstname': signUpFirstName.text,
            'lastname': signUpLastName.text,
            'username': signUpUserName.text,
            'email': signUpEmail.text,
            'password': signUpPassword.text,
          });
      emit(SignUpSuccess());
    } catch (e) {
      emit(
        SignUpFailure(errMessage: e.toString()),
      );
    }
  }

  // uploadProfilePic(XFile image) {
  //   profilePic = image;
  //   emit(UploadProfilePic());
  // }

//   getUserProfile() async {
//     try {
//       emit(GetUserLoading());
//       final response = await api.get(
//         EndPoint.getUserDataEndPoint(
//           CacheHelper().getData(key: ApiKey.id),
//         ),
//       );
//       emit(
//         GetUserSuccess(
//           user: UserModel.fromJson(response),
//         ),
//       );
//     } on ServerException catch (e) {
//       emit(
//         GetUserFailure(errMessage: e.errModel.errorMessage),
//       );
//     }
//   }
}
