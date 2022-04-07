import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/components/fullscreen_dialog.dart';
import 'package:terrarium/screens/choose_dialog/cubit.dart';
import 'package:terrarium/screens/choose_dialog/state.dart';

class ChooseDialog extends StatelessWidget {
  static Future<ImageProvider?> openDialog(
    BuildContext context,
    List<ImageProvider> images,
  ) {
    return Navigator.of(context).push(
      FullscreenDialogRoute(
        builder: (context) => BlocProvider(
          create: (context) => ChooseDialogCubit(
            ChooseDialogState(
              null,
              images
                  .mapIndexed((index, element) => ItemModel(index, element))
                  .toList(),
            ),
            context,
          ),
          child: const ChooseDialog(),
        ),
      ),
    );
  }

  const ChooseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseDialogCubit, ChooseDialogState>(
        builder: (context, state) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 40,
                  bottom: 140,
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runAlignment: WrapAlignment.spaceAround,
                  children: [
                    ...state.models.map((e) {
                      return GestureDetector(
                        onTap: () {
                          context.read<ChooseDialogCubit>().select(e.id);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          padding: e.id == state.choosed
                              ? null
                              : const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0x00000000),
                            border: e.id == state.choosed
                                ? Border.all(
                                    color: Colors.lightGreenAccent,
                                    width: 5,
                                  )
                                : null,
                          ),
                          child: Image(image: e.image),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              height: 80,
              left: 40,
              right: 40,
              child: OutlinedButton(
                onPressed: () {
                  context.read<ChooseDialogCubit>().apply();
                },
                child: const Text("Добавить"),
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
        ),
      );
    });
  }
}
