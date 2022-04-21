import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:terrarium/screens/choose_dialog/choose_dialog.dart';
import 'package:terrarium/screens/status_dialog/status_dialog.dart';
import 'package:terrarium/screens/terrarium/state.dart';

class TerrariumCubit extends Cubit<TerrariumState> {
  final _period = const Duration(seconds: 1);
  late BuildContext context;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Timer? _timer;

  TerrariumCubit() : super(const TerrariumState([], 100)) {
    _storage.read(key: "terrariumState").then((value) {
      if (value != null) {
        emit(TerrariumState.fromJson(jsonDecode(value)));
      }
    });
    startHealthDecreasing();
  }

  dispose() {
    _timer?.cancel();
    _timer = null;
  }

  startHealthDecreasing() {
    _timer = Timer.periodic(_period, (_) {
      final items = state.items.map(
            (e) => e.copyWith(
          health: max(
            0,
            e.health - (state.health > 40 ? 1 : 2),
          ),
        ),
      );

      num positiveChance = 1 -
          pow(
            0.9,
            state.items
                .where(
                  (element) =>
              element.type == Type.decoration && element.health > 0,
            )
                .length,
          );

      num negativeChance = 1 -
          pow(
            0.9,
            state.items
                .where((element) =>
            element.health == 0 && element.type != Type.decoration)
                .length,
          );

      var newHealth = state.health -
          1 +
          (Random().nextDouble() < positiveChance ? 1 : 0) -
          (Random().nextDouble() < negativeChance ? 1 : 0);

      emit(state.copyWith(
        items: items.toList(),
        health: max(
          0,
          newHealth,
        ),
      ));
    });
  }

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
            health: e.health,
            type: e.type,
          );
        } else {
          return e;
        }
      },
    );
    emit(state.copyWith(items: result.toList()));
  }

  feedAnimal(int id) {
    final items = state.items.map(
      (e) => e.id == id && e.health != 0
          ? e.copyWith(
              health: min(
                100,
                e.health + 20,
              ),
            )
          : e,
    );

    emit(state.copyWith(items: items.toList()));
  }

  clearTerrarium() {
    emit(state.copyWith(health: 100));
  }

  waterPlant(int id) {
    final items = state.items.map(
      (e) => e.id == id && e.health != 0
          ? e.copyWith(
              health: min(
                100,
                e.health + 20,
              ),
            )
          : e,
    );

    emit(state.copyWith(items: items.toList()));
  }

  addAnimal() async {
    final toAdd = await ChooseDialog.openDialog(context, [
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
            health: 100,
            type: Type.animal)
      ];

      emit(state.copyWith(items: result));
    }
  }

  addPlant() async {
    final toAdd = await ChooseDialog.openDialog(context, [
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
          health: 100,
          type: Type.plant,
        ),
      ];

      emit(state.copyWith(items: result));
    }
  }

  openStatusDialog(int id) {
    StatusDialog.open(
      context,
      this,
      id,
    );
  }

  addDecoration() async {
    final toAdd = await ChooseDialog.openDialog(context, [
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
          health: 100,
          type: Type.decoration,
        ),
      ];

      emit(state.copyWith(items: result));
    }
  }

  delete(int id) {
    final result = state.items.where((element) => element.id != id).toList();
    emit(state.copyWith(items: result));
  }

  @override
  void emit(TerrariumState state) {
    _storage.write(key: "terrariumState", value: jsonEncode(state.toJson()));
    super.emit(state);
  }
}
