import 'package:hive/hive.dart';
import 'package:movielist/model/database1.dart';

class Boxes {
  static Box<Database1> getdata() => Hive.box<Database1>('transactions');
}
