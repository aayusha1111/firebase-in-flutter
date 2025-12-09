import 'package:flutter/material.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/pages/login_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
 
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Text(
                  "Enter code",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 10),

               
                Text(
                  "Enter the verification code that was sent to your registered phone number to proceed ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),

                Container(),

                SizedBox(height: 20),

                Text(
                  "Didn't get it? Resend code(disabled for 30s",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),

                SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: primaryColor,
                    child: Text(
                      "Verify",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
