import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  Map<String, dynamic> item;
  int index;

  // super.key // calling the constructor super()
  DetailPage({required this.item, required this.index}); // Format of a constructor with item as required argument

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Detail Page"),backgroundColor: Colors.red,),
    body: Center(
      child: Column(
        children: [
          Text(item["name"]!),
          const SizedBox(height: 10,),
          Text(item["description"]!),
          const SizedBox(height: 10,),
          Text(item["place"]!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                print("todo will delete item at  $index later");

                var response = {
                  "index":index,
                  "action":1 // 1 is DELETE, 2 Mark as complete
                };

                Navigator.pop(context, response);

              }, child: Text("Delete an item")),
              TextButton(onPressed: (){
                var response = {
                  "index":index,
                  "action":2
                };
                Navigator.pop(context,response);

              },child: Text(item["completed"] == true ? "Unmark completion" : "Mark as completed"),)
            ],
          )
        ],
      ),
    ),);
  }
}
