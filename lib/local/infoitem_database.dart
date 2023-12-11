import 'package:path/path.dart';
import 'package:scanify/local/entity/predict_entity.dart';
import 'package:sqflite/sqflite.dart';

class InfoItemDatabase {
  static final InfoItemDatabase instance = InfoItemDatabase._init();

  static Database? _database;

  InfoItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('item.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE $tableInfoItem (
    ${ItemInfoDBFields.id} $idType,
    ${ItemInfoDBFields.averageEnergy} $doubleType,
    ${ItemInfoDBFields.dampakDisposalPanjang} $textType,
    ${ItemInfoDBFields.dampakDisposalPendek} $textType,
    ${ItemInfoDBFields.dampakKonsumsiPanjang} $textType,
    ${ItemInfoDBFields.dampakKonsumsiPendek} $textType,
    ${ItemInfoDBFields.dampakProduksiPanjang} $textType,
    ${ItemInfoDBFields.dampakProduksiPendek} $textType,
    ${ItemInfoDBFields.image} $textType,
    ${ItemInfoDBFields.lokasi} $textType,
    ${ItemInfoDBFields.sumber} $textType,
    ${ItemInfoDBFields.name} $textType,
    ${ItemInfoDBFields.recommendations} $textType,
    ${ItemInfoDBFields.result} $textType,
    ${ItemInfoDBFields.time} $textType,
    ${ItemInfoDBFields.isSaved} $integerType
    )
    ''');
  }

  Future<ItemInfoDB> insertItemInfoDB(ItemInfoDB iteminfo) async {
    final db = await instance.database;

    final id = await db.insert(tableInfoItem, iteminfo.toMap());
    final insertedData = await getItemInfoById(id);

    return insertedData;
  }

  Future<ItemInfoDB> getItemInfoById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableInfoItem, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ItemInfoDB.fromMap(maps.first);
    } else {
      throw Exception("Data with ID $id not found");
    }
  }

  Future<bool> getIsSavedById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      tableInfoItem,
      columns: [ItemInfoDBFields.isSaved],
      where: '${ItemInfoDBFields.id} = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first[ItemInfoDBFields.isSaved] == 1;
    } else {
      return false;
    }
  }

  Future<List<ItemInfoDB>> getAllHistoryItem() async {
    final db = await instance.database;
    final listMap = await db.rawQuery("""
    SELECT * FROM infoitem ORDER BY id DESC
    """);

    List<ItemInfoDB> itemList = listMap.map((itemMap) {
      return ItemInfoDB.fromMap(itemMap);
    }).toList();

    return itemList;
  }

  Future<void> updateIsSaved(int id) async {
    final db = await instance.database;

    await db.update(
      "infoitem",
      {"isSaved": 1},
      where: '$id = ?',
      whereArgs: [id],
    );
  }
}
