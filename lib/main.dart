import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());


class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
  bool pressed = false;
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

  void _addLinethrough(int index) {
    setState(() => pressed = !pressed
    );}

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
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    
    return new ListTile(
      //trailing: Icon(Icons.check_box_outline_blank),
      title: new Text(todoText, style:TextStyle(fontSize: 21, 
       decoration:
        pressed ? TextDecoration.lineThrough : TextDecoration.none)),
      trailing: new IconButton(icon: Icon(Icons.delete_outline, color: Colors.red, size: 30.0),
       onPressed: () => _promptRemoveTodoItem(index)),
      leading: new IconButton(icon: Icon(Icons.check_circle, color: Colors.green[500], size: 30.0),
       onPressed: () => _addLinethrough(index)),
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
                fillColor: Colors.white,
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