import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todos/widgets/add.dart';
import 'package:todos/widgets/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _todos = [
    // {
    //   "name": "Learn Navigation",
    //   "description": "Learn Basic Navigation",
    //   "place": "Online meet",
    //   "completed":true
    // },
    // {
    //   "name": "Learn ListView",
    //   "description": "ListView and ListTile",
    //   "place": "Online Meet",
    //   "completed":true
    // },
    // {
    //   "name": "Have Lunch",
    //   "description": "1h lunch break",
    //   "place": "Own home/office",
    //   "completed":true
    // },
    // {
    //   "name": "Storage",
    //   "description": "Using shared pref",
    //   "place": "Online meet",
    //   "completed":false
    // }
  ];



  // Override initstate to do intialization in this page
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async{
    // Get the file manager
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringTodos = prefs.getString("todos");
    if (stringTodos != null){
      setState(() {
        _todos = jsonDecode(stringTodos); // Transform String to List<dynamic>
      });
    }

  }

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance(); // RETRIEVE THE FILE MANAGER
    // SAVEE!!

// setString (Save as String)
    // Shared pref can only be stored in String, int, double , List<String>
    // If you want to store List<Map<String,dynamic> we use jsonEncode to transform List<Map<String,dynamic> to String
    prefs.setString("todos", jsonEncode(_todos));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),backgroundColor: Colors.red,),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          // How many rows are there? -> 4 / _todos.length
          itemCount: _todos.length,
          // What to show on each row?
          itemBuilder: (BuildContext context, int index) {
            // For each row (index)
            // I will create a Container (Box), of height 50, color amber
            // The child, will show Centered-Text
            // That will show the name of _todos in each row _todos[index]["name"];
            // return Container(
            //   height: 50,
            //   color: Colors.amber,
            //   child: Center(child: Text(_todos[index]["name"]!)),
            // );

            return Card(
              color: Colors.blue,
              child: ListTile(
                leading: _todos[index]["completed"] == true ? Icon(Icons.check, color: Colors.white,) : SizedBox(),
                title: Text(_todos[index]["name"]!, style: TextStyle(color: Colors.white),),
                subtitle: Text(_todos[index]["place"]!, style: TextStyle(color: Colors.yellow),),
                trailing: Icon(Icons.chevron_right, color: Colors.white,),
                onTap: () async {
                 var response = await Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>DetailPage(item: _todos[index],index: index,)));

                 if (response != null){
                   if (response["action"] == 1){
                     // Delete
                     _todos.removeAt(response["index"]);

                     saveData();

                     setState(() {
                       _todos;
                     });

                   }
                   else {
                     // Mark as complete
                     //  if it is true, change to false, if it false, change to true
                     _todos[response["index"]]["completed"] = ! _todos[response["index"]]["completed"];

                     saveData();
                     setState(() {
                       _todos;
                     });
                   }
                 }
                },
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () async {
          print("Add pressed");
          var item = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));

          if (item != null){
            _todos.add(item);
            saveData();

            setState(() {
              _todos ; // same as _todos = _todos (refresh the UI)
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
