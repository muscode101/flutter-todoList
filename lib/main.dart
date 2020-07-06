import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertodolist/model/todo.dart';
import 'package:fluttertodolist/util/DbHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var todo;
  var todoMap =
  Todo("new", "this is a db test", DateTime.now().toString(), 1);


  void testDb() {
    var helper = DbHelper();
    helper
        .initializeDb()
        .then((result) => helper.getTodos().then((result) => todo = result));
    var result = helper.insertTodo(todoMap);

    print('hello'+ result.toString());
    print('mus'+ result.toString());
    print(todo);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
//    testDb();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: testDb,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
