import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/screens/choose_dialog/choose_dialog.dart';
import 'package:terrarium/screens/terrarium/state.dart';

class TerrariumCubit extends Cubit<TerrariumState> {
  final BuildContext _context;

  TerrariumCubit(this._context) : super(const TerrariumState([]));

  updatePosition(Offset position, Size size, int id) {
    final result = state.items.map(
      (e) {
        if (e.id == id) {
          return ItemModel(
            id: e.id,
            left: position.dx / size.width,
            top: position.dy / size.height,
            height: e.height,
            width: e.width,
            image: e.image,
          );
        } else {
          return e;
        }
      },
    );
    emit(TerrariumState(result.toList()));
  }

  addAnimal() async {
    final toAdd = await ChooseDialog.openDialog(_context, [
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
    ]);

    if (toAdd != null) {
      final result = [
        ...state.items,
        ItemModel(
          id: (state.items.lastOrNull?.id ?? 0) +
              Random.secure().nextInt(10000),
          left: 0,
          top: 0,
          height: 0.1,
          width: 0.1,
          image: toAdd,
        )
      ];

      emit(TerrariumState(result));
    }
  }

  addPlant() async {
    final toAdd = await ChooseDialog.openDialog(_context, [
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
    ]);

    if (toAdd != null) {
      final result = [
        ...state.items,
        ItemModel(
          id: (state.items.lastOrNull?.id ?? 0) +
              Random.secure().nextInt(10000),
          left: 0,
          top: 0,
          height: 0.1,
          width: 0.1,
          image: toAdd,
        ),
      ];

      emit(TerrariumState(result));
    }
  }

  addDecoration() async {
    final toAdd = await ChooseDialog.openDialog(_context, [
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
      Images.lion,
    ]);

    if (toAdd != null) {
      final result = [
        ...state.items,
        ItemModel(
          id: (state.items.lastOrNull?.id ?? 0) +
              Random.secure().nextInt(10000),
          left: 0,
          top: 0,
          height: 0.1,
          width: 0.1,
          image: toAdd,
        ),
      ];

      emit(TerrariumState(result));
    }
  }

  delete(int id) {
    final result = state.items.where((element) => element.id != id).toList();
    emit(TerrariumState(result));
  }
}
