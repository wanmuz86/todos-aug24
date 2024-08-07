import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var placeEditingController = TextEditingController();
  var descEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Page"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text("Please fill in all info"),
          TextField(
            decoration: InputDecoration(hintText: "Enter task name"),
            controller: nameEditingController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Enter task description"),
            controller: descEditingController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Enter place"),
            controller: placeEditingController,
          ),
          ElevatedButton(
              onPressed: () {
                print(nameEditingController.text);
                print(descEditingController.text);
                print(placeEditingController.text);

                var newItem = {
                  "name": nameEditingController.text,
                  "description": descEditingController.text,
                  "place": placeEditingController.text,
                  "completed": false
                };
                Navigator.pop(context, newItem); // Return to the previous page
              },
              child: Text("Add new item"))
        ],
      ),
    );
  }
}
