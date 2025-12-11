import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_project/pages/signup_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String selectedId='Passport';
  File? uploadedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Verify Your Identity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),



                Text(
                  "Upload your valid ID to continue your journey",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),

                SizedBox(height: 15),
                Text(
                  "Select ID Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 10,),

               Column(
              children: [
                _idOption("Passport"),
                _idOption("Citizenship ID"),
                _idOption("School ID"),
              ],
            ),
              ],
            ),
          ),
        ),
      ), 
    );
  }
   Widget _idOption(String idName) {
    return RadioListTile<String>(
      title: Text(idName),
      value: idName,
      groupValue: selectedId,
      onChanged: (value) {
        setState(() {
          selectedId = value!;
        });
      },
    );
  }
}
