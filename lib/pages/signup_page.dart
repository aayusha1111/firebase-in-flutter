import 'package:flutter/material.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/features/constants/app_string.dart';
import 'package:new_project/pages/verification_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:new_project/widgets/custom_text_formfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
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
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(height: 25),
          
                
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
          
                
                CustomTextformfield(
                  
                  labelText: nameStr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return userNameValidation;
                    }
                    return null;
                  },
                ),
          
                SizedBox(height: 18),

                Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
          
          
                
                CustomTextformfield(
                  labelText: addressStr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return passwordValidationStr;
                    }
                    return null;
                  },
                  
                ),
SizedBox(height: 10,),


                Text(
                  "Phone number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
          
          
                // PASSWORD FIELD
                CustomTextformfield(
                  labelText: phoneStr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return passwordValidationStr;
                    }
                    return null;
                  },
                  
                ),
                   SizedBox(height: 10,),


                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
          
          
                
                CustomTextformfield(
                  labelText: passwordStr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return passwordValidationStr;
                    }
                    return null;
                  },
                  
                ),
                SizedBox(height: 10,),
          
                SizedBox(height: 30,),
                CustomElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>VerificationPage()));
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: Text("Proceed",style: TextStyle(fontSize:18 ),),
                ),

                SizedBox(height: 30,),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "Didn't have an account? Login",
                    style: TextStyle(
                      color: Colors.blue, 
                      fontWeight: FontWeight.w600,
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
