import 'package:bookstore/constants.dart';
import 'package:bookstore/cubits/update_user_profile/update_user_profile_cubit.dart';
import 'package:bookstore/widgets/custom_button.dart';
import 'package:bookstore/widgets/custom_text_form_field.dart';
import 'package:bookstore/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: context.read<UpdateUserProfileCubit>().editFormKey,
        child: Center(
          child: ListView(
            children: [
              topBar('Update Information', null),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Please fill your details to update.',
                style: TextStyle(
                    fontSize: getResponsiveFontSize(context, fontSize: 18)),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            // image: NetworkImage(state.user.profilePic),
                            image: AssetImage('assets/images/accountpic.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 12,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller:
                          context.read<UpdateUserProfileCubit>().editFirstName,
                      obscureText: false,
                      hintText: 'First Name',
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      onSaved: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller:
                          context.read<UpdateUserProfileCubit>().editLastName,
                      obscureText: false,
                      hintText: 'Last Name',
                      prefixIcon: const Icon(FontAwesomeIcons.user),
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: context.read<UpdateUserProfileCubit>().editUserName,
                obscureText: false,
                hintText: 'Username',
                prefixIcon: const Icon(FontAwesomeIcons.user),
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: context.read<UpdateUserProfileCubit>().editEmail,
                obscureText: false,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              BlocConsumer<UpdateUserProfileCubit, UpdateUserProfileState>(
                listener: (context, state) {
                  if (state is UpdateUserProfileSuccess) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is UpdateUserProfileInitial) {
                    return CustomButton(
                        color: Colors.black,
                        title: 'Update',
                        onTap: () {
                          context
                              .read<UpdateUserProfileCubit>()
                              .updateUserProfile();
                        });
                  } else if (state is UpdateUserProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CustomButton(
                        color: Colors.black,
                        title: 'Update',
                        onTap: () {
                          context
                              .read<UpdateUserProfileCubit>()
                              .updateUserProfile();
                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
