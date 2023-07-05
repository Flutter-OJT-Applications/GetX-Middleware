import 'package:authentications/services/commons/password_utils.dart';
import 'package:authentications/utils/logger_utils.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EntityService extends GetxController{
  late Database _database;

  @override
  onInit() async{
    await initialize();
    super.onInit();
  }

  EntityService();

  Future<void> initialize() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myDb.db');
    _database = await openDatabase(path, version: 1, onCreate: _onDbCreate); //
  }

  Future<void> _onDbCreate(Database db, int version) async{

    // create a role table
    logger.i('Creating role table...');
    await db.execute(
        '''
          CREATE TABLE IF NOT EXISTS `role` (
            id INTEGER PRIMARY KEY,
            name STRING NOT NULL
          )
        '''
    );
    logger.i('Role table created.\n');
    // add a admin role
    logger.i('Adding admin role...');
    await db.insert('role', {
      'name':'admin',
    });
    logger.i('Admin role has been added.\n');
    // add a user role
    logger.i('Adding user role...');
    await db.insert('role', {
      'name':'user',
    });
    logger.i('User role has been added.\n');
    // create a user table
    logger.i('Creating user table...');
    await db.execute(
        '''
          CREATE TABLE IF NOT EXISTS user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            role_id INTEGER,
            name STRING NOT NULL, 
            email STRING NOT NULL UNIQUE,
            password STRING NOT NULL, 
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (role_id) REFERENCES `role` (id)
          )
        ''');
    logger.i('User table is created.\n');
    // add admin user
    logger.i('Adding admin user...');
    await db.insert('user', {
      'name': 'admin',
      'email': 'admin@gmail.com',
      'password': PasswordUtil.encryptPassword('111111'),
      'role_id': 1,
    });
    logger.i('Admin user has been added.\n');
  }
  Database get database => _database;
}