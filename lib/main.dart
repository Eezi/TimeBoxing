import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tehtävälista',
      home: new TodoList(),
      
      
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed and
      // it will automatically re-render the list
      setState(() => _todoItems.add(task));
      
    }
  }
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Poistetaanko "${_todoItems[index]}" tehtävä?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('EI'),
              
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('KYLLÄ'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText, style: TextStyle(fontSize: 20)), 
      trailing: Icon(Icons.check) ,
      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tehtävälista', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Colors.teal[400]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _pushAddTodoScreen() {
   
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Lisää uusi tehtävä', style: TextStyle(fontSize: 25)),
              centerTitle: true,
              backgroundColor: Colors.teal[400]
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                hintText: 'Lisää tehtävä...',
                contentPadding: const EdgeInsets.all(18.0)
                
              ),
            )
          );
        }
      )
    );
  }
}