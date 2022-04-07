import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/screens/terrarium/cubit.dart';
import 'package:terrarium/screens/terrarium/terrarium.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TerrariumCubit(context),
        child: Builder(
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 5,
                    child: Terrarium(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<TerrariumCubit>().addAnimal();
                          },
                          child: const Text("Добавить животное"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<TerrariumCubit>().addDecoration();
                          },
                          child: const Text("Добавить декорацию"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<TerrariumCubit>().addPlant();
                          },
                          child: const Text("Добавить растение"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
