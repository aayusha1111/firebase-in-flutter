import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerificationsPage extends StatefulWidget {
  const VerificationsPage({super.key});

  @override
  State<VerificationsPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationsPage> {
  String? selectedId;
  File? uploadedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => uploadedImage = File(image.path));
    }
  }

  // ---------- Show bottom sheet ----------
  void _showUploadSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Upload ID",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

              SizedBox(height: 20),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: uploadedImage != null
                      ? Image.file(uploadedImage!, fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_rounded, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              "Drag and Drop here\nor\nUpload photos",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // ---------- Figma style button ----------
  Widget _idTypeButton(String title, IconData icon) {
    final isSelected = selectedId == title;
    return GestureDetector(
      onTap: () {
        setState(() => selectedId = title);
        _showUploadSheet();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffD5E4F5) : Color(0xffEFEFF7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 10),
                  Text(
                    "Verify Your Identity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),

              SizedBox(height: 20),

              Text(
                "Upload your valid ID to continue your journey",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),

              SizedBox(height: 25),

              Text(
                "Select ID type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 15),

              _idTypeButton("Passport", Icons.credit_card),
              _idTypeButton("Citizenship ID", Icons.person),
              _idTypeButton("School ID", Icons.directions_bus),
            ],
          ),
        ),
      ),
    );
  }
}
