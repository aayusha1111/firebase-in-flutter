import 'package:flutter/material.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/pages/login_page.dart';
import 'package:new_project/pages/reset_password_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:new_project/widgets/custom_text_formfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Text(
                  "Find your account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 10,),

                Text("Enter the phone number associated with your account",style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),

                SizedBox(height: 20,),
                CustomTextformfield(
                  labelText: "Phone number",
                ),
                SizedBox(height: 40,),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.push (context,MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
                      

                      
                    },
                    backgroundColor: primaryColor,
                    child: Text("Send Code",style: TextStyle(fontSize: 16,color: Colors.white),),
                  ),
                )
              ],

            
            ),
          ),
        ),
      ),
    );
  }
}
