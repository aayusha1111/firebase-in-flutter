import 'package:flutter/material.dart';
import 'package:new_project/core/color_const.dart';
import 'package:new_project/pages/login_page.dart';
import 'package:new_project/pages/new_password_page.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();

}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String otp="";
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

                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    otp=value;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 55,
                    fieldWidth: 50,
                    activeFillColor: const Color.fromARGB(255, 204, 201, 201),
                    inactiveFillColor:const Color.fromARGB(255, 204, 201, 201),
                    selectedFillColor: const Color.fromARGB(255, 204, 201, 201),

                    activeColor: primaryColor,
                    inactiveColor: const Color.fromARGB(255, 204, 201, 201),
                    selectedColor: primaryColor,
                    borderWidth: 1,
                  ),
                  enableActiveFill: true,
                ),

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
                    onPressed: () {
                      if(otp.length==4){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordPage()));}
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter all 4 digits")));
                      }
                    },
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
