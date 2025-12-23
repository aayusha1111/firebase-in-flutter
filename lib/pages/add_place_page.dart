import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/core/app_string.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_bloc.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_event.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_state.dart';
import 'package:new_project/features/authentication/model/addplace.dart';
import 'package:new_project/pages/places_list_page.dart';
import 'package:new_project/utils/route_generator.dart';
import 'package:new_project/utils/routes.dart';
import 'package:new_project/widgets/custom_elevated_button.dart';
import 'package:new_project/widgets/custom_text_formfield.dart';
import 'package:new_project/widgets/spin_kit.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => AddPlacePageState();
}

class AddPlacePageState extends State<AddPlacePage> {
  String? destinationName;
  String? description;
  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void submitPlace() {
    if (destinationName == null || destinationName!.trim().isEmpty) {
      showError("Please enter destination name");
      return;
    }

    if (description == null || description!.trim().isEmpty) {
      showError("Please enter description");
      return;
    }

    if (selectedImage == null) {
      showError("Please upload an image");
      return;
    }

    final place = AddPlaceModel(
      destination: destinationName!.trim(),
      about: description!.trim(),
    );

    context.read<AddPlaceBloc>().add(
      SubmitPlaceEvent(place: place, imageFile: selectedImage!),
    );
  }

  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => backdropFilter(context),
    );
  }

  void hideLoader() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPlaceBloc, AddPlaceState>(
      listener: (context, state) {
        if (state is AddPlaceLoadingState) {
          showLoader();
        }
        if (state is AddPlaceLoadedState) {
          hideLoader();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Place added successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          RouteGenerator.navigateToPage(context, Routes.placeListRoute);

        }

        if (state is AddPlaceErrorState) {
          hideLoader();
          showError(state.message);
        }
      },
      child: Scaffold(
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
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Add Place",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Destination",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  CustomTextformfield(
                    labelText: destinationStr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return destinationValidationStr;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      destinationName = value;
                    },
                  ),

                  SizedBox(height: 18),
                  Text(
                    "About the destination",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  CustomTextformfield(
                    labelText: descriptionStr,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return descriptionValidationStr;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Upload Image",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),

                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.upload_outlined,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Drag and Drop here",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "or",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Upload photos of destination",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),

                  BlocBuilder<AddPlaceBloc, AddPlaceState>(
                    builder: (context, state) {
                      final isLoading = state is AddPlaceLoadingState;

                      return CustomElevatedButton(
                        backgroundColor: const Color(0xFF3D8DB5),
                        onPressed: isLoading ? null : submitPlace,

                        child: Text(
                          "Proceed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
