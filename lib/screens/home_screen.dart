import 'package:flutter/material.dart';
import 'package:restsimple/controller/todo_controler.dart';
import 'package:restsimple/repository/todo_repository.dart';

import '../models/todo.dart';

class HomeScreen extends StatelessWidget {
 const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var todoControler = TodoControler(TodoRepository());

    //mengecek ststus
    //todoController.fetchTodoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Restful API'),
      ),
      body:     FutureBuilder<List<Todo>>(
        future: todoControler.fetchTodoList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError){
            return Center(
              child: Text('eror'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index){
              var todo = snapshot.data?[index];
              return Container(
                height: 100.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 3, child: Text('${todo?.title}')),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            todoControler
                                .updatePatchCompleted(todo!)
                                .then((value) => {
                                  ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                          duration: const Duration(
                                            milliseconds: 500),
                                          content: Text('$value'),
                                        ))
                                });
                          },
                          child: buildCallContainer('patch', Colors.orange),
                        ),
                        InkWell(
                          onTap: () {
                            todoControler.updatePutCompleted(todo!);
                          },
                          child: buildCallContainer('del', Colors.blueAccent),
                        ),
                        InkWell(
                          onTap: () {
                            todoControler
                                .deleteTodo(todo!)
                                .then((value) => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                        duration: const Duration(
                                          milliseconds: 500),
                                        content: Text('$value'),
                                      ))
                                });
                          },
                          child: buildCallContainer('del', Colors.teal),
                        )
                      ],
                    ),
                  )
                ]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
              );
            },
            itemCount: snapshot.data?.length ?? 0);
        }
        ),
        ),
        floatingActionButton: FloatingActionButton (
          onPressed: () {
            Todo todo = 
                Todo(userId: 5, title: 'test post data', completed: false);
            todoControler.postTodo(todo);
          },
          child: Icon(Icons.add),
        ),
    );
  }
}

Container buildCallContainer(String title, Color color) {
  return Container(
    width: 40.0,
    height: 40.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Center(child: Text('$title')),
  );
}