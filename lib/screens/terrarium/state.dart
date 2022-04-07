import 'package:flutter/material.dart';

class TerrariumState {
  final List<ItemModel> items;

  const TerrariumState(this.items);

  dynamic toJson() => {"items": items.map((e) => e.toJson()).toList()};

  TerrariumState.fromJson(dynamic json)
      : items =
            (json["items"] as List).map((e) => ItemModel.fromJson(e)).toList();
}

class ItemModel {
  final int id;
  final double left;
  final double top;
  final double height;
  final double width;
  final AssetImage image;

  ItemModel({
    required this.id,
    required this.left,
    required this.top,
    required this.height,
    required this.width,
    required this.image,
  });

  dynamic toJson() => {
        "id": id,
        "left": left,
        "top": top,
        "height": height,
        "width": width,
        "image": image.assetName
      };

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        left = json["left"],
        top = json["top"],
        height = json["height"],
        width = json["width"],
        image = AssetImage(json["image"]);

  @override
  String toString() {
    return 'ItemModel{id: $id, left: $left, top: $top, height: $height, weight: $width, image: $image}';
  }
}

class Images {
  static const lion = AssetImage("assets/lion.png");
}
