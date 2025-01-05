import 'package:basic_utils/basic_utils.dart';
import 'package:sorting_hat/model/base/base_entity.dart';
import 'package:sorting_hat/repository/base/interface.dart';

import '../../dependencies.dart';
import '../../utilities/database_factory.dart';

abstract class BaseReadRepository<T extends CoreReadEntity> implements IBaseReadRepository<T> {
  final dbFactory = injector.get<DatabaseFactory>();

  BaseReadRepository();

  @override
  Future<T?> getById(String? id) async {
    if (StringUtils.isNullOrEmpty(id)) return null;
    var condition = "Id = '$id'";
    var items = await list(condition, null, null, null, null);
    return items.isEmpty ? null : items[0];
  }

  @override
  Future<List<T>?> listAll() async {
    return await list(null, null, null, null, null, []);
  }

  @override
  Future<List<T>> list(String? where, String? orderBy, bool? asc, int? pageIndex, int? pageSize,
      [final List<String> args = const <String>[]]) async {
    return await listSelected(null, where, orderBy, asc, pageIndex, pageSize, args);
  }

  Future<List<T>> listSelected(String? columns, String? where, String? orderBy, bool? asc, int? pageIndex, int? pageSize,
      [final List<String> args = const <String>[]]) async {
    var item = injector.get<T>();
    var selected = StringUtils.isNullOrEmpty(columns) ? "*" : columns;
    var query = "select $selected from ${item.table} ";

    if (where != null) {
      query += "where $where ";
    }

    if (orderBy != null) {
      var direction = asc == true ? "ASC" : "DESC";
      query += "order by $orderBy $direction ";
    }

    if (pageIndex != null && pageSize != null) {
      var skip = (pageIndex - 1) * pageSize;
      var limit = pageSize;
      query += "LIMIT $limit OFFSET $skip ";
    }
    return await listRaw(query, item.fromJsonConvert, args);
  }

  @override
  Future<List<T>> listRaw<T>(
      String query,
      T Function(
        Map<String, dynamic>,
      ) mapper,
      [final List<String> args = const <String>[]]) async {
    final database = await dbFactory.getMasterData();
    var list = await database.list(query, args);
    return list.map((f) => mapper(f)).toList();
  }
}
