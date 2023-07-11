import '../../models/todo/todo_model.dart';
import '../crud_repository.dart';

class TodoRepository extends CRUDRepository<TodoModel> {
  @override
  Future<int?> create(TodoModel data) async {
    return await database.insert('todo', data.toObject());
  }

  @override
  Future<int?> delete(id) async {
    return await database.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<TodoModel?> getById(id) async {
    final data = await database.query('todo', where: 'id = ?', whereArgs: [id]);
    if(data.isEmpty) return null;
    return TodoModel.fromDB(data.single);
  }

  @override
  Future<List<TodoModel>?> list({String? where, List<Object?>? whereArgs}) async{
    final data = await database.query('todo', where: where, whereArgs: whereArgs);
    return data.map((e) => TodoModel.fromDB(e)).toList();
  }

  @override
  Future<int?> update(id,TodoModel data) async{
    return await database.update('todo', data.toObject(), where: 'id = ?', whereArgs: [id]);
  }
}