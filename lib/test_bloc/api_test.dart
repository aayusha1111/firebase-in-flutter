import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/test_bloc/test_bloc.dart';
import 'package:new_project/test_bloc/test_event.dart';
import 'package:new_project/test_bloc/test_state.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Posts")),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<ApiBloc>().add(FetchDataEvent());
                },
                child: const Text("Load Posts"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ApiBloc, ApiState>(
                  builder: (context, state) {
                    if (state is ApiInitialState) {
                      return const Center(child: Text("Press button to load posts"));
                    } else if (state is ApiLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ApiLoadedState) {
                      final posts = state.posts;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.body),
                            ),
                          );
                        },
                      );
                    } else if (state is ApiErrorState) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
