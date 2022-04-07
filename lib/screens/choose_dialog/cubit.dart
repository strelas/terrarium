import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/screens/choose_dialog/state.dart';

class ChooseDialogCubit extends Cubit<ChooseDialogState> {
  final BuildContext _context;

  ChooseDialogCubit(ChooseDialogState initialState, this._context)
      : super(initialState);

  select(int id) {
    emit(ChooseDialogState(
      state.choosed == id ? null : id,
      state.models,
    ));
  }

  apply() {
    final result =
        state.models.firstWhere((element) => element.id == state.choosed);
    Navigator.of(_context).pop(result.image);
  }
}
