import 'package:bloc_demo/cubits/counter_cubit.dart';
import 'package:bloc_demo/cubits/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Button Pressed"),
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              if (state.counterValue < 0) {
                return Text(
                  'Negative: ${state.counterValue.toString()}',
                  style: TextStyle(fontSize: 40),
                );
              } else if (state.counterValue > 5) {
                return Text(
                  'Greater than 5: ${state.counterValue.toString()}',
                  style: TextStyle(fontSize: 40),
                );
              } else {
                return Text(
                  state.counterValue.toString(),
                  style: TextStyle(fontSize: 40),
                );
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                child: Icon(Icons.remove),
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
