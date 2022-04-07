import 'package:flutter/material.dart';

class ChooseDialogState {
  final int? choosed;
  final List<ItemModel> models;

  const ChooseDialogState(this.choosed, this.models);
}

class ItemModel {
  final int id;
  final ImageProvider image;

  const ItemModel(this.id, this.image);
}