import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_model.dart';
import 'package:flutter_course/widgets/todo_bottom_sheet.dart';
import 'package:flutter_course/widgets/todo_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  int todoNumber = 0;
  void addTodo() {
    //setState(() {
    //  todos.add(TodoModel(text: "Todo numer : $todoNumber"));
    //});

    showModalBottomSheet(
        context: context,
        builder: (context) => TodoBottomSheet()).then((value) => print(value));

    todoNumber++;
  }

  void removeTodo(TodoModel todo) {
    setState(() {
      todos.removeWhere((element) => element.text == todo.text);
    });
  }

  void onTodoChange(TodoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          title: Text("To Do"),
          actions: [
            MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(),
                onPressed: addTodo,
                child: Icon(Icons.add))
          ],
        ),
        // warunek ? true : false
        body: todos.isEmpty
            ? Center(
                child: Text("Dodaj pierwsze ToDo"),
              )
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (contex, index) => TodoWidget(
                      todo: todos[index],
                      removeTodo: (TodoModel todo) {
                        removeTodo(todo);
                      },
                      onTodoChange: (TodoModel todo) {
                        onTodoChange(todo);
                      },
                    )));
  }
}
