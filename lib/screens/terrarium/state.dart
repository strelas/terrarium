import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TerrariumState {
  final List<ItemModel> items;
  final int health;

  const TerrariumState(this.items, this.health);

  dynamic toJson() =>
      {"items": items.map((e) => e.toJson()).toList(), "health": health};

  TerrariumState.fromJson(dynamic json)
      : items =
            (json["items"] as List).map((e) => ItemModel.fromJson(e)).toList(),
        health = json["health"];

  TerrariumState copyWith({
    List<ItemModel>? items,
    int? health,
  }) =>
      TerrariumState(
        items ?? this.items,
        health ?? this.health,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TerrariumState &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(items, other.items) &&
          health == other.health;

  @override
  int get hashCode => const ListEquality().hash(items) ^ health.hashCode;
}

class ItemModel {
  final int id;
  final double left;
  final double top;
  final double height;
  final double width;
  final AssetImage image;
  final int health;
  final Type type;

  ItemModel({
    required this.id,
    required this.left,
    required this.top,
    required this.height,
    required this.width,
    required this.image,
    required this.health,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          left == other.left &&
          top == other.top &&
          height == other.height &&
          width == other.width &&
          image == other.image &&
          health == other.health &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^
      left.hashCode ^
      top.hashCode ^
      height.hashCode ^
      width.hashCode ^
      image.hashCode ^
      health.hashCode ^
      type.hashCode;

  dynamic toJson() => {
        "id": id,
        "left": left,
        "top": top,
        "height": height,
        "width": width,
        "image": image.assetName,
        "health": health,
        "type": type.index,
      };

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        left = json["left"],
        top = json["top"],
        height = json["height"],
        width = json["width"],
        image = AssetImage(json["image"]),
        health = json["health"],
        type = Type.values[json["type"]];

  ItemModel copyWith({int? health}) => ItemModel(
        id: id,
        left: left,
        top: top,
        height: height,
        width: width,
        image: image,
        health: health ?? this.health,
        type: type,
      );

  @override
  String toString() {
    return 'ItemModel{id: $id, left: $left, top: $top, height: $height, weight: $width, image: $image}';
  }
}

class Images {
  static const lion = AssetImage("assets/lion.png");
}

enum Type { plant, animal, decoration }
