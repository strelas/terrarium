import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TerrariumState {
  final List<ItemModel> items;
  final int health;
  final bool isPaused;

  const TerrariumState(this.items, this.health, this.isPaused);

  dynamic toJson() => {
        "items": items.map((e) => e.toJson()).toList(),
        "health": health,
        "isPaused": isPaused
      };

  TerrariumState.fromJson(dynamic json)
      : items =
            (json["items"] as List).map((e) => ItemModel.fromJson(e)).toList(),
        health = json["health"],
        isPaused = json["isPaused"];

  TerrariumState copyWith({
    List<ItemModel>? items,
    int? health,
    bool? isPaused,
  }) =>
      TerrariumState(
        items ?? this.items,
        health ?? this.health,
        isPaused ?? this.isPaused,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TerrariumState &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(items, other.items) &&
          health == other.health &&
          isPaused == other.isPaused;

  @override
  int get hashCode =>
      const ListEquality().hash(items) ^ health.hashCode ^ isPaused.hashCode;
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
  static const earth = AssetImage("assets/earth.png");
  static const gnome = AssetImage("assets/gnome.png");
  static const turbine = AssetImage("assets/turbine.png");
  static const vent = AssetImage("assets/vent.png");
  static const stone = AssetImage("assets/stone.png");
  static const decorations = [earth, gnome, turbine, vent, stone];

  static const animal1 = AssetImage("assets/animal_1.png");
  static const animal2 = AssetImage("assets/animal_2.png");
  static const animal3 = AssetImage("assets/animal_3.png");
  static const animal4 = AssetImage("assets/animal_4.png");
  static const animal5 = AssetImage("assets/animal_5.png");
  static const animals = [animal1, animal2, animal3, animal4, animal5];

  static const plant1 = AssetImage("assets/plant_1.png");
  static const plant2 = AssetImage("assets/plant_2.png");
  static const plant3 = AssetImage("assets/plant_3.png");
  static const plant4 = AssetImage("assets/plant_4.png");
  static const plant5 = AssetImage("assets/plant_5.png");
  static const plant6 = AssetImage("assets/plant_6.png");
  static const plants = [plant1, plant2, plant3, plant4, plant5, plant6];
}

enum Type { plant, animal, decoration }
