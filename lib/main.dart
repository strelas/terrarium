import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/screens/terrarium/cubit.dart';
import 'package:terrarium/screens/terrarium/terrarium.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(cubit: TerrariumCubit(),));
}

class MyApp extends StatelessWidget {
  final TerrariumCubit cubit;
  MyApp({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(cubit: cubit),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final TerrariumCubit cubit;
  const MyHomePage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void dispose() {
    widget.cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => widget.cubit..context = context,
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
                        TextButton(
                          onPressed: () {
                            context.read<TerrariumCubit>().clearTerrarium();
                          },
                          child: const Text("Почистить террариум"),
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
