import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/test_bloc/test_bloc.dart';
import 'package:new_project/test_bloc/test_event.dart';
import 'package:new_project/test_bloc/test_state.dart';


class TestOfBloc extends StatefulWidget {
  const TestOfBloc({super.key});

  @override
  State<TestOfBloc> createState() => _TestOfBlocState();
}

class _TestOfBlocState extends State<TestOfBloc> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test of Bloc')),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${state.count}", style: TextStyle(fontSize: 40)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CounterBloc>().add(IncrementEvent()),
                    child: Text("Add"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CounterBloc>().add(DecrementEvent()),
                    child: Text("Subtract"),
                  ),
                ],
              ),

              IconButton(onPressed: (){
                context.read<CounterBloc>().add(ToggleVisibilityEvent());
              }, icon: Icon(state.isVisible?Icons.visibility:Icons.visibility_off))
            ],
          );
        },
      ),


    );
  }
}
