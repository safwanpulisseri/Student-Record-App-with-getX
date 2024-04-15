import 'package:hive/hive.dart';
part 'model_db.g.dart';

@HiveType(typeId: 0)
class Studentmodel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String age;

  @HiveField(2)
  late String address;

  @HiveField(3)
  late String mobile;

  @HiveField(4)
  late String image;
}
