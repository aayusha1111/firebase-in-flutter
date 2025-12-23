import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_bloc.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_event.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_state.dart';
import 'package:new_project/utils/route_generator.dart';
import 'package:new_project/utils/routes.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetPlacesBloc()..add(FetchPlacesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Places"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              RouteGenerator.navigateToPage(context, Routes.addPlaceRoute);
            },
          ),
        ),
        body: BlocBuilder<GetPlacesBloc, GetPlacesState>(
          builder: (context, state) {
            if (state is GetPlacesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetPlacesErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is GetPlacesLoadedState) {
              if (state.places.isEmpty) {
                return const Center(child: Text("No places found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.places.length,
                itemBuilder: (context, index) {
                  final place = state.places[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (place.url != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              place.url!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.destination,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                place.about,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Edit Button
                                  TextButton.icon(
                                    onPressed: () {
                                      // Navigate to AddPlacesScreen with prefilled data
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: const Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Delete Button
                                  TextButton.icon(
                                    onPressed: () async {
                                      final blocContext = context;

                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (dialogContext) => AlertDialog(
                                          title: const Text("Delete Place"),
                                          content: const Text(
                                            "Are you sure you want to delete this place?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                dialogContext,
                                                false,
                                              ),
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                dialogContext,
                                                true,
                                              ),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true && place.id != null) {
                                        blocContext.read<GetPlacesBloc>().add(
                                          DeletePlaceEvent(id: place.id!),
                                        );
                                      }
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
