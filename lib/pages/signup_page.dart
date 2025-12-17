
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/core/app_string.dart';
import 'package:new_project/features/authentication/bloc/auth_bloc.dart';
import 'package:new_project/features/authentication/bloc/auth_event.dart';
import 'package:new_project/features/authentication/model/user.dart';
import 'package:new_project/pages/login_page.dart';
import 'package:new_project/pages/verification_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:new_project/widgets/custom_text_formfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? name, address, emailAddress, password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Image.asset("assets/yatra.png"),
                        ),
                        SizedBox(height: 15),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF2596be),
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Text(
                          "Once more,destiny calls you forth.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  CustomTextformfield(
                    labelText: nameStr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return userNameValidation;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      name = val;
                    },
                  ),

                  SizedBox(height: 18),

                  Text(
                    "Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  CustomTextformfield(
                    labelText: addressStr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return passwordValidationStr;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      address = val;
                    },
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Email address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  CustomTextformfield(
                    labelText: emailStr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return emailValidationStr;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      emailAddress = val;
                    },
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  CustomTextformfield(
                    labelText: passwordStr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return passwordValidationStr;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      password = val;
                    },
                  ),

                  SizedBox(height: 30),
                  CustomElevatedButton(
                    onPressed: () {
                      User user = User(
                        name: name,
                        address: address,
                        email: emailAddress,
                        password: password,
                        profileUrl:
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Salman_Khan_in_2023_%281%29_%28cropped%29.jpg/250px-Salman_Khan_in_2023_%281%29_%28cropped%29.jpg",
                        identity: Identity(
                          type: "passport",
                          url:
                              "https://imgv2-2-f.scribdassets.com/img/document/692140141/original/7de1429d40/1?v=1",
                        ),
                      );

                       context.read<AuthBloc>().add(SignupEvent(user)) ;
                      // if (_formKey.currentState!.validate()) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => VerificationPage(),
                      //     ),
                      //   );
                      // }
                    },
                    backgroundColor: primaryColor,
                    child: Text("Proceed", style: TextStyle(fontSize: 18)),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Didn't have an account? Login",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
