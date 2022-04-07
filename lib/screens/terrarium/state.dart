import 'package:flutter/material.dart';

class TerrariumState {
  final List<ItemModel> items;

  const TerrariumState(this.items);
}

class ItemModel {
  final int id;
  final double left;
  final double top;
  final double height;
  final double width;
  final ImageProvider image;

  ItemModel({
    required this.id,
    required this.left,
    required this.top,
    required this.height,
    required this.width,
    required this.image,
  });

  @override
  String toString() {
    return 'ItemModel{id: $id, left: $left, top: $top, height: $height, weight: $width, image: $image}';
  }
}

class Images {
  static const lion = AssetImage("assets/lion.png");
}
