import 'package:hive/hive.dart';

part 'database1.g.dart';

@HiveType(typeId: 0)
class Database1 extends HiveObject {
  @HiveField(0)
  late String mname;

  @HiveField(1)
  late DateTime createdDate;
  @HiveField(2)
  late String dname;
  @HiveField(2)
  late String link;
}
