import 'package:bookstore/constants.dart';
import 'package:bookstore/cubits/user_cubit/user_cubit.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:bookstore/views/signin-up/sign_up_view.dart';
import 'package:bookstore/views/user_nav_bar_m.dart';
import 'package:bookstore/widgets/custom_button.dart';
import 'package:bookstore/widgets/custom_text_form_field.dart';
import 'package:bookstore/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _isVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          print('tokennn isss :${CacheNetwork.getCacheData(key: 'token')}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const UserNavigationBar(),
            ),
          );
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: context.read<UserCubit>().signInFormKey,
              child: Center(
                child: ListView(
                  children: [
                    topBar('Get Started', null),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'Please fill your details to login.',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextFormField(
                      controller: context.read<UserCubit>().signInEmail,
                      obscureText: false,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) {
                        if (!RegExp(
                                r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value!)) {
                          return "Please enter a valid email address";
                        } else if (value.isEmpty) {
                          return "Email should not be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: context.read<UserCubit>().signInPassword,
                      obscureText: _isVisible,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => _isVisible = !_isVisible),
                        icon: _isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password should not be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(height: 30),
                    state is SignInLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.black,
                          ))
                        : CustomButton(
                            color: Colors.black,
                            title: 'Get Started',
                            onTap: () {
                              context.read<UserCubit>().signIn();
                            },
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New member ?  ',
                          style: TextStyle(
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 18),
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
