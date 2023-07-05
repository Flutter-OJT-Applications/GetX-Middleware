import 'package:authentications/services/configs/entity_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

abstract class CRUDRepository<E>{
  Future<List<E>?>  list();
  Future<E?> getById(id);
  Future<int?> create(E data);
  Future<int?> update(id,E data);
  Future<int?> delete(id);
  Database get database => Get.find<EntityService>().database;
}