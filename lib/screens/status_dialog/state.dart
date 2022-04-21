import 'package:flutter/material.dart';
import 'package:terrarium/screens/terrarium/state.dart' as terrarium;

class ItemModel {
  final int id;
  final int health;
  final ImageProvider image;
  final bool needFeed;
  final bool needWater;

  ItemModel.from(terrarium.ItemModel model)
      : id = model.id,
        health = model.health,
        image = model.image,
        needFeed = model.type == terrarium.Type.animal,
        needWater = model.type == terrarium.Type.plant;
}
