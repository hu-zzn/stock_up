import 'package:hive_ce/hive.dart';

part 'item_models.g.dart';

// Item Model
@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  String defaultUnit;

  @HiveField(4)
  String brand;

  @HiveField(5)
  bool isFavorite;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.defaultUnit,
    this.brand = '',
    this.isFavorite = false,
  });
}

// Selected Item Model
@HiveType(typeId: 1)
class SelectedItem extends HiveObject {
  @HiveField(0)
  String itemId;

  @HiveField(1)
  double quantity;

  @HiveField(2)
  String unit;

  @HiveField(3)
  String brand;

  @HiveField(4)
  String notes;

  SelectedItem({
    required this.itemId,
    required this.quantity,
    required this.unit,
    this.brand = '',
    this.notes = '',
  });
}

// List Model
@HiveType(typeId: 2)
class ListModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  List<SelectedItem> items;

  ListModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.items,
  });
}
