import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/UI/Home.dart';
import 'package:to_do/UI/TextSytles.dart';
import 'package:to_do/UI/toast.dart';
import 'package:to_do/backend/backend.dart';
import 'package:to_do/backend/list.dart';


class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final edit=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text('Crate New Task 😍')),
      backgroundColor: const Color(0xffd9d9d9),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              TextField(
            controller: edit,
             maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:const BorderSide(
                      color:Colors.blueGrey,
                      width: 3
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:const BorderSide(
                          color: Colors.blue,
                          width: 3
                      )
                  ),
                  hintText: 'Enter Task'
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  String s= edit.text.toString().trim();
                  if(s.isNotEmpty) {
                    toastmsg(context);
                    list.add(edit.text.toString().trim());
                    Database().saveData();
                    setState(() {

                      });

                  }},
                child: Container(

                  height: 50,
                  width: 100,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.shade900,
                  ),
                  child: Center(child: Text('Post',style: Styles(),)),
                ),
              )
          ],
    ),
        ),
      ) ,

    );
  }
}
