import 'dart:io';
import "dart:async";
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper
{

  static final _dbname ="myDatabase.db";
  static final _dbversion =1;
  static final _tableName ="userDetails";

  static final columnUsername ="_username";
  static final columnfirstName ="_firstName";
  static final columnlastName ="_lastName";
  static final columngender = "_gender";
  static final columndob = "_dob";
  static final columnexperience = "_experience";
  static final columnpassword ="_password";


// making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;


  Future<Database> get database async
  {
      if(_database != null)  return _database;

      _database = await _initateDatabase();
            return _database;
            
        }
      
        _initateDatabase() async 
        {
          Directory directory = await getApplicationDocumentsDirectory();
          String path = join(directory.path,_dbname);
          return await openDatabase(path,version:_dbversion,onCreate: _onCreate);

        }

        // create a table in the database 

          Future _onCreate(Database db, int version)
            async {
           await db.execute(

              '''
            CREATE TABLE $_tableName(
              $columnUsername TEXT Not NULL,
              $columnfirstName TEXT Not NULL,
              $columnlastName TEXT Not NULL,
              $columngender TEXT Not NULL,
              $columndob TEXT Not NULL,
              $columnexperience INTEGER Not NULL,
              $columnpassword TEXT Not NULL
              
              )

              '''
            );
          }

          // insert a row in the table

          // ignore: unused_element
          Future insert(Map<String,dynamic> row) async
          {
            Database db = await instance.database;
            return await db.insert(_tableName,row);
          }


          // returns all the data in the form of list

          Future<List<Map<String,dynamic>>> queryAll() async
          {
            Database db = await instance.database;
            return await db.query(_tableName);
          }

        


}

