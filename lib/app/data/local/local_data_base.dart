// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class LocalDataBase {
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }
//
//   intialDb() async {
//     String dataBasePath = await getDatabasesPath();
//     String path = join(dataBasePath, "barwy.db");
//     Database barwyDB = await openDatabase(path,
//         onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
//     return barwyDB;
//   }
//
//   _onUpgrade(Database db, int oldVersion, int newversion) async {
//     print(
//         "======================================= UPGRADE DB =======================================");
//   }
//
//   void _onCreate(Database db, int version) async {
//     await db.execute(
//         '''
//         CREATE TABLE productCart (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         item_id INTEGER,
//         variant_id INTEGER,
//         name TEXT,
//         price TEXT,
//         image TEXT,
//         quantity INTEGER,
//         stock INTEGER,
//         options TEXT
//         )
//         ''');
//
//
//     print("Database and table 'productCart' created successfully.");
//   }
//
//   readData(String sql) async {
//     Database? barwyDB = await db;
//     List<Map> response = await barwyDB!.rawQuery(sql);
//     return response;
//   }
//
//   insertData(String sql) async {
//     Database? barwyDB = await db;
//     int response = await barwyDB!.rawInsert(sql);
//     return response;
//   }
//
//   deleteData(String sql) async {
//     Database? barwyDB = await db;
//     int response = await barwyDB!.rawDelete(sql);
//     return response;
//   }
//
//   updateData(String sql) async {
//     Database? barwyDB = await db;
//     int response = await barwyDB!.rawUpdate(sql);
//     return response;
//   }
// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> _initDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "barwyshop.db"); // اسم قاعدة البيانات
    Database database = await openDatabase(
      path,
      version: 2, // لازم تزود الرقم لو عدلت في الجداول
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE productCart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER,
        variant_id INTEGER,
        name TEXT,
        price TEXT,
        image TEXT,
        quantity INTEGER,
        stock INTEGER,
        options TEXT,
        shippingPrice TEXT
      )
      '''
    );
    print("✅ Database and table 'productCart' created successfully.");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("🔄 Upgrading database from version $oldVersion to $newVersion...");
    // نحذف الجدول القديم
    await db.execute("DROP TABLE IF EXISTS productCart");
    // ثم ننشئ الجداول تاني من الصفر
    await _onCreate(db, newVersion);
    print("✅ Database upgraded successfully.");
  }

  // عمليات مساعدة (قراءة، إضافة، حذف، تعديل)

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? database = await db;
    List<Map<String, dynamic>> response = await database!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? database = await db;
    int response = await database!.rawInsert(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? database = await db;
    int response = await database!.rawDelete(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? database = await db;
    int response = await database!.rawUpdate(sql);
    return response;
  }

  // لو حابب تحذف قاعدة البيانات يدويًا (مثلا أثناء التطوير أو التحديث الكامل)
  Future<void> deleteDatabaseFile() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "barwy.db");
    await deleteDatabase(path);
    print("🗑️ Database deleted successfully.");
  }
}



// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class LocalDataBase {
//   static final LocalDataBase _instance = LocalDataBase._internal();
//   static Database? _db;
//
//   factory LocalDataBase() {
//     return _instance;
//   }
//
//   LocalDataBase._internal();
//
//   Future<Database> get db async {
//     if (_db != null) return _db!;
//     _db = await _initDb();
//     return _db!;
//   }
//
//   Future<Database> _initDb() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, "barwy.db");
//
//     return await openDatabase(
//       path,
//       version: 5,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS productCart (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         item_id INTEGER,
//         variant_id INTEGER,
//         name TEXT,
//         price TEXT,
//         image TEXT,
//         quantity INTEGER,
//         stock INTEGER,
//         options TEXT
//       )
//     ''');
//
//     print("✅ Database and table 'productCart' created successfully.");
//   }
//
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     print("🚀 Upgrading database from version $oldVersion to $newVersion...");
//     // Add migration queries here if needed
//   }
//
//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawQuery(sql);
//   }
//
//   Future<int> insertData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawInsert(sql);
//   }
//
//   Future<int> updateData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawUpdate(sql);
//   }
//
//   Future<int> deleteData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawDelete(sql);
//   }
//
//   /// ✅ Deletes the database (useful for testing)
//   Future<void> deleteDatabaseFile() async {
//     String path = join(await getDatabasesPath(), "barwy.db");
//     await deleteDatabase(path);
//     _db = null;
//     print("🗑️ Database deleted successfully.");
//   }
//   void checkAndDeleteOldDb() async {
//     String path = join(await getDatabasesPath(), "barwy.db");
//     bool exists = await databaseExists(path);
//     if (exists) {
//       await deleteDatabase(path);
//       print("🗑️ Old database deleted.");
//     }
//   }
//
// }
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class LocalDataBase {
//   static final LocalDataBase _instance = LocalDataBase._internal();
//   static Database? _db;
//   static const int _dbVersion = 5; // Set your database version
//   static const String _dbName = "barwy.db";
//
//   factory LocalDataBase() {
//     return _instance;
//   }
//
//   LocalDataBase._internal();
//
//   Future<Database> get db async {
//     if (_db != null) return _db!;
//     await _checkForDatabaseReset(); // Check if DB needs to be reset
//     _db = await _initDb();
//     return _db!;
//   }
//
//   /// 🔹 Initialize the database
//   Future<Database> _initDb() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, _dbName);
//
//     return await openDatabase(
//       path,
//       version: _dbVersion,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }
//
//   /// 🔹 Create tables when the database is first created
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS productCart (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         item_id INTEGER,
//         variant_id INTEGER,
//         name TEXT,
//         price TEXT,
//         image TEXT,
//         quantity INTEGER,
//         stock INTEGER,
//         options TEXT
//       )
//     ''');
//     print("✅ Database and table 'productCart' created successfully.");
//   }
//
//   /// 🔹 Handle database upgrades (Delete old DB if version changes)
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     print("🚀 Upgrading database from version $oldVersion to $newVersion...");
//     if (oldVersion < newVersion) {
//       await deleteDatabaseFile();
//       _db = await _initDb();
//     }
//   }
//
//   /// 🛠️ **Check if database should be deleted on app update**
//   Future<void> _checkForDatabaseReset() async {
//     String path = join(await getDatabasesPath(), _dbName);
//     bool exists = await databaseExists(path);
//
//     if (exists) {
//       Database dbInstance = await openDatabase(path);
//       int currentVersion = await dbInstance.getVersion();
//       await dbInstance.close();
//
//       if (currentVersion < _dbVersion) {
//         print("⚠️ Database version changed. Deleting old database...");
//         await deleteDatabaseFile();
//       }
//     }
//   }
//
//   /// 🔹 Read data
//   Future<List<Map<String, dynamic>>> readData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawQuery(sql);
//   }
//
//   /// 🔹 Insert data
//   Future<int> insertData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawInsert(sql);
//   }
//
//   /// 🔹 Update data
//   Future<int> updateData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawUpdate(sql);
//   }
//
//   /// 🔹 Delete data
//   Future<int> deleteData(String sql) async {
//     final dbClient = await db;
//     return await dbClient.rawDelete(sql);
//   }
//
//   /// 🗑️ **Delete the entire database file**
//   Future<void> deleteDatabaseFile() async {
//     String path = join(await getDatabasesPath(), _dbName);
//     await deleteDatabase(path);
//     _db = null;
//     print("🗑️ Database deleted successfully.");
//   }
// }
