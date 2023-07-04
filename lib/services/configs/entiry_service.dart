import 'package:authentications/services/commons/password_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EntityService {
  late Database _database;

  EntityService();

  Future<void> initialize() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myDb.db');
    _database = await openDatabase(path, version: 1, onCreate: _onDbCreate); //
  }

  Future<void> _onDbCreate(Database db, int version) async{

    // create a role table
    await db.execute(
        '''
          CREATE TABLE IF NOT EXISTS `role` (
            id INTEGER PRIMARY KEY,
            name STRING NOT NULL
          )
        '''
    );

    // add a admin role
    await db.insert('role', {
      'name':'admin',
    });

    // add a user role
    await db.insert('role', {
      'name':'user',
    });

    // create a user table
    await db.execute(
        '''
          CREATE TABLE IF NOT EXISTS user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            role_id INTEGER,
            name STRING NOT NULL, 
            email STRING NOT NULL,
            password STRING NOT NULL, 
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (role_id) REFERENCES `role` (id)
          )
        ''');
    // add admin user
    await db.insert('user', {
      'name': 'admin',
      'email': 'admin@gmail.com',
      'password': PasswordUtil.encryptPassword('111111'),
      'role_id': 1,
    });

  }
  get database => _database;
}
