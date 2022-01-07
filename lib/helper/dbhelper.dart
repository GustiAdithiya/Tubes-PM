import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoonline/models/keranjang.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tokoonline.db';

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE keranjang(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idproduk INTEGER,
        judul TEXT,
        harga TEXT,
        hargax TEXT,
        thumbnail TEXT,
        jumlah INTEGER,
        userid TEXT,
        idcabang TEXT
      );
    ''');
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database;
  }

  Future<List<Map<String, dynamic>>> selectKeranjang() async {
    Database db = await database;
    var mapList = await db.query('keranjang');
    return mapList;
  }

  Future<List<Keranjang>> getKeranjang() async {
    var mapList = await selectKeranjang();
    int count = mapList.length;
    List<Keranjang> list = <Keranjang>[];
    for (int i = 0; i < count; i++) {
      list.add(Keranjang.fromMap(mapList[i]));
    }
    return list;
  }
}
