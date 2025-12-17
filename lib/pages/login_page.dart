import 'package:flutter/material.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/features/constants/app_string.dart';
import 'package:new_project/pages/forgot_password_page.dart';
import 'package:new_project/pages/signup_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:new_project/widgets/custom_text_formfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
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
                  "Username",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),

                CustomTextformfield(
                  labelText: userStr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return userNameValidation;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 18),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),

              
                CustomTextformfield(
                  labelText: passwordStr,
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return passwordValidationStr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 230),
                    child: Text("Forgot Password?"),
                  ),
                ),

                SizedBox(height: 30),

                CustomElevatedButton(
                  
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  backgroundColor: primaryColor,
                  child: Text("Login", style: TextStyle(fontSize: 18)),
                ),

                SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      "Didn't have an account? Signup",
                     
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

