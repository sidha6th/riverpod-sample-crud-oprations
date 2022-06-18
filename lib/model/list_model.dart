import 'package:hive_flutter/hive_flutter.dart';

part 'list_model.g.dart';

@HiveType(typeId: 0)
class ListModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String key;
  ListModel({
    required this.email,
    required this.phone,
    required this.key,
  });
}
