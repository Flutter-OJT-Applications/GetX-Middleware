import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/repositories/crud_repository.dart';
import 'package:authentications/services/commons/password_utils.dart';

class UserRepository extends CRUDRepository<UserModel>{

  Future<UserModel?> getUserByEmail(String email) async{
    final data = await database.query('user', where: 'email=?', whereArgs: [email]);
    if(data.isEmpty) return null;
    return UserModel.fromJson(data.first);
  }

  @override
  Future<int?> create(UserModel data) async{
    data.password = PasswordUtil.encryptPassword(data.password!);
    return await database.insert('user', data.toJson());
  }

  @override
  Future<int?> delete(id) async{
    return await database.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<UserModel?> getById(id) async{
    final data = await database.query('user', where: 'id = ?', whereArgs: [id]);
    final user = UserModel.fromJson(data.first);
    return user;
  }

  @override
  Future<List<UserModel>?> list({String? where, List<Object?>? whereArgs}) async{
    final data = await database.query('user', where: where, whereArgs: whereArgs);
    return data.map((user) => UserModel.fromJson(user)).toList();
  }

  @override
  Future<int?> update(id, UserModel data) async{
    data.id = id;
    return await database.update('user', data.toJson(), where: 'id = ?', whereArgs: [id]);
  }

}