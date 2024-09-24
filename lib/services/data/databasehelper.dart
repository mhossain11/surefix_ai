

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surefix_ai/models/DashModel.dart';

class DatabaseHelper{

  static const String _tableName = 'OwnPostItem';
  static const int _databaseVersion = 1;

  static const id ='id';
  static const title ='title';
  static const description ='description';
  static const descriptionOld ='description_old';
  static const createdAt ='createdAt';
  static const updatedAt ='updatedAt';
  static const requestedBy ='requestedby';
  static const requestFile ='requestFile';
  static const attachFile ='attachFile';
  static const make ='make';
  static const model ='model';
  static const yearOfMake ='yearofmake';
  static const faultCode ='faultCode';
  static const isSolved ='isSolved';
  static const registrationNumber ='registrationnumber';
  static const issueResponsesCount ='issueResponsesCount';
  static const message ='message';
  static Database? _database;

 static Future<void>  initDB() async {
   final dbpath = await getDatabasesPath();
   const String dbName = 'OwnPostItem.db';
   final path = join(dbpath,dbName);
   final dbExists = await databaseExists(path);

   if(!dbExists){
     print("Database does not exist. Creating a new one...");
     _database = await openDatabase(
       path,
       version: _databaseVersion,
       onCreate: _onCreate
     );
     print("Database created successfully.");
   }else{
     print("Database already exists. Opening the database...");
     _database = await openDatabase(path);
   }

  }

 static Future _onCreate(Database db, int version) async{
   await db.execute('''
        CREATE TABLE ownPostItem (
            auto_id INT  AUTO_INCREMEN,
            id INT NOT NULL,
            title VARCHAR(255),
            descriptionOld VARCHAR(255),
            description VARCHAR(255),
            requestedby INT,
            createdAt VARCHAR(255), 
            updatedAt VARCHAR(255), 
            requestFile VARCHAR(255),
            attachFile VARCHAR(255),
            make VARCHAR(255),
            model VARCHAR(255),
            yearofmake INT,
            registrationnumber VARCHAR(255),
            faultCode VARCHAR(255),
            isSolved INT
            );
        ''');
  }

  static Future<bool> checkIfExists(int itemId)async{
   final db = _database;
   if(db == null) return false;
   final List<Map<String,dynamic>> result = await db.rawQuery(
     '''
     SELECT * FROM ownPostItem where id =?;
     ''', [itemId]);
   return result.isNotEmpty;
  }
  static Future insertItem(Requests requests) async {
    final db = _database;
    if (requests.id != null) {
      bool exists = await checkIfExists(int.parse(requests.id.toString()));
      print("exists empty: $exists");
      if (!exists) {
        print(" empty: $exists");
        await db!.execute('''
    INSERT INTO ownPostItem (
      id,
      title,
      descriptionOld,
      description,
      requestedby,
      createdAt,
      updatedAt,
      requestFile,
      attachFile,
      make,
      model,
      yearofmake,
      registrationnumber,
      faultCode,
      isSolved
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
  ''', [
          requests.id,
          requests.title,
          requests.descriptionOld,
          requests.description,
          requests.requestedby,
          requests.createdAt != null
              ? requests.createdAt!.toIso8601String()
              : null,
          requests.updatedAt != null
              ? requests.updatedAt!.toIso8601String()
              : null,
          requests.requestFile,
          requests.attachFile,
          requests.make,
          requests.model,
          requests.yearofmake,
          requests.registrationnumber,
          requests.faultCode,
          requests.isSolved,
        ]);
      }
    }
  }


  // Delete all
  Future  deleteData() async {
    final db = _database;
    final res = await db?.delete('ownPostItem');

    return res;
  }


 static Future<List<Map<String,dynamic>>>  getUserData() async {
    var db = await _database;
    final List<Map<String,dynamic>>  data = await db!.query('ownPostItem');
    return data;
  }

  static Future<void> close() async{
   final db = await _database;
   await db?.close();
   print("Database closed.");
  }




}