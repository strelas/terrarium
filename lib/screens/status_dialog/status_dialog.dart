import 'package:flutter/material.dart';
import 'package:terrarium/components/fullscreen_dialog.dart';
import 'package:terrarium/screens/status_dialog/state.dart';
import 'package:terrarium/screens/terrarium/cubit.dart';
import 'package:terrarium/screens/terrarium/state.dart' as terrarium;
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusDialog extends StatelessWidget {
  static void open(BuildContext context, TerrariumCubit cubit, int id) {
    Navigator.of(context).push(
      FullscreenDialogRoute(
        builder: (context) => StatusDialog(
          cubit: cubit,
          id: id,
        ),
      ),
    );
  }

  final TerrariumCubit cubit;
  final int id;

  const StatusDialog({
    Key? key,
    required this.id,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TerrariumCubit, terrarium.TerrariumState>(
          bloc: cubit,
          builder: (context, state) {
            final model = ItemModel.from(
              state.items.firstWhere((element) => element.id == id),
            );
            return Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Opacity(
                          opacity: model.health == 0 ? 0.5 : 1,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image(image: model.image),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Здоровье: ${model.health}%"),
                        const SizedBox(height: 5),
                        if (model.needFeed)
                          TextButton(
                            onPressed: () {
                              cubit.feedAnimal(model.id);
                            },
                            child: const Text("Покормить"),
                          ),
                        const SizedBox(height: 5),
                        if (model.needWater)
                          TextButton(
                            onPressed: () {
                              cubit.waterPlant(model.id);
                            },
                            child: const Text("Полить"),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
