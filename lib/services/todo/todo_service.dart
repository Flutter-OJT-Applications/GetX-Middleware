import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/todo/todo_model.dart';
import '../../repositories/todo/todo_repository.dart';
import '../user/user_service.dart';

class TodoService extends GetxController{

  final _detailModel = TodoModel.empty().obs;
  final _createdUser = UserModel.empty().obs;

  final TodoRepository _repository = TodoRepository();
  final List<TodoModel> _todoList = <TodoModel>[].obs;
  final formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController().obs;
  final _descriptionController = TextEditingController().obs;

  final _isLoading = true.obs;

  final ScrollController scrollController = ScrollController();

  final _offset = 0.obs;
  final _limit = 10.obs;
  final _isLoadMore = false.obs;

  @override
  void onInit() async{
    super.onInit();
    await fetchTodo();
    _isLoading.value = false;
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels){
        if(!isLoadMore){
          isLoadMore = !isLoadMore;
          offset += limit;
          fetchTodo(offsetP: offset);
        }
      }
    });
  }

  fetchTodo({int? limitP, int? offsetP}) async {
    final data = await getTodoList(limitP??limit, offsetP??offset);
    if(data != null) {
      _todoList.addAll(data);
    }
    isLoadMore = false;
  }

  Future<List<TodoModel>?> getTodoList(int limit, int offset) async{
    await Future.delayed(const Duration(seconds: 2));
    print(offset);
    if(authService.isAdmin){
      return await _repository.list(where: 'user_id!="" ORDER BY created_at limit ? offset ?', whereArgs: [limit, offset]);
    }
    return await _repository.list(where: 'user_id = ? ORDER BY created_at LIMIT ? OFFSET ? ', whereArgs: [authService.principal.id, limit, offset]);
  }

  Future<TodoModel?> createTodo(TodoModel model) async{
    model.userId = authService.principal.id;
    final id = await _repository.create(model);
    if(id == null){
      return null;
    }
    model.id = id;
    _todoList.add(model);
    return model;
  }

  Future<TodoModel?> getTodoById(int id){
    return _repository.getById(id);
  }

  Future<TodoModel?> updateTodo(int id, TodoModel model) async{
    model.userId = authService.principal.id;
    final count = await _repository.update(id, model);
    if(count == null) {
      return null;
    }
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if(index == -1) {
      return null;
    }
    _todoList[index] = model;
    return model;
  }

  Future<bool> deleteTodo(int id) async{
    final count = await _repository.delete(id);
    if(count == null) return false;
    _todoList.removeWhere((todo) => todo.id == id);
    return true;
  }

  List<TodoModel> get  todoList => _todoList;

  set setTodoList(List<TodoModel> modelList) => _todoList.addAll(modelList);

  set addTodo(TodoModel model){
    _todoList.add(model);
  }

  AuthService get authService => Get.find<AuthService>();
  UserService get userService => Get.find<UserService>();

  TextEditingController get titleController => _titleController.value;
  TextEditingController get descriptionController => _descriptionController.value;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  TodoModel get detailModel => _detailModel.value;
  UserModel get createdUser => _createdUser.value;

  set detailModel(TodoModel model) => _detailModel.value = model;
  set createdUser(UserModel model) => _createdUser.value = model;

  int get offset => _offset.value;
  int get limit => _limit.value;

  set offset(int value) => _offset.value = value;
  set limit(int value) => _limit.value = value;
  
  bool get isLoadMore => _isLoadMore.value;
  set isLoadMore(bool value) => _isLoadMore.value = value;
}