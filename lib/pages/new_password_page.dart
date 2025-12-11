import 'package:flutter/material.dart';
import 'package:new_project/pages/reset_password_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(child: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(children: [
      //       Row(
      //         children: [
      //           IconButton(onPressed: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
      //           }, icon: Icon(Icons.arrow_back_ios)),
      //           SizedBox(width: 5,),
      //           Text("Reset Password", style: TextStyle(
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.w500,
      //                     ),)
      //         ],
      //       ),
      //       SizedBox(height: 10,),
      //       Text("Create new password")
      //     ],),
      //   ),
      // )),
    );
  }
}