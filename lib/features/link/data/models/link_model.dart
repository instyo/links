import 'package:hive/hive.dart';

part 'link_model.g.dart';

@HiveType(typeId: 0)
class LinkModel extends HiveObject {
  @HiveField(0)
  final String icon;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String customTitle;

  @HiveField(3)
  final String url;

  LinkModel({
    required this.icon,
    required this.title,
    this.customTitle = '',
    required this.url,
  });

  String get mainTitle => customTitle.isEmpty ? title : customTitle;
}
