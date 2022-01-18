import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper{
  late Database db;

  Future init() async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    db=await openDatabase(path,onCreate: (db, version) {

    },);



  }


}