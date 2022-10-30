import 'package:restsimple/models/todo.dart';
import 'package:restsimple/repository/repository.dart';

class TodoControler {
  final Repository _repository;

  TodoControler (this._repository);

  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }
  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }
  Future<String> deleteTodo(Todo todo) async {
    return _repository.deleteComplete(todo);
  }
  Future<String> postTodo (Todo todo) async {
    return _repository.postCompleted(todo);
  }
}