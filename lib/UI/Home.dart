import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/UI/TextSytles.dart';
import 'package:to_do/UI/postTask.dart';
import 'package:to_do/backend/backend.dart';
import 'package:to_do/backend/list.dart';



class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Database().getData();

  }

  int ind=-1;
  int del=0;
  int ed=0;
  @override
  Widget build(BuildContext context) {

    double w= MediaQuery.of(context).size.width-30;
    return Scaffold(
     drawer: Drawer(
        child: Container(
          color: Colors.yellow,
        ),
      ),
     appBar: AppBar(
       backgroundColor:const Color(0xff331559),
       leading: Builder(
           builder:(context){
             return IconButton(onPressed: (){
               Scaffold.of(context).openDrawer();
             },
                 icon: SvgPicture.asset('asset/images/align-left-solid.svg',width: 21.88,),

                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip);
           }
       ),
       centerTitle: true,
       title: Text('To-Do App',style:Styles() ,),

     ),
     backgroundColor:  const Color(0xffd9d9d9),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>const Post()));
       },
       backgroundColor: const Color(0xff331559),
       child:const Icon(Icons.add),
     ),
        body: Stack(
         children:[
         const SizedBox(height: double.infinity,width: double.infinity,),
         ListView.builder(
         itemCount: list.length,
         itemBuilder: (builder,index){
           return Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
               child: Slidable(
                 endActionPane: end(index),
                 startActionPane: start(index),
                 child: Stack(
                   alignment: Alignment.center,
                   children:[
                     Container(
                     height: 80,
                     width: w,
                     decoration: BoxDecoration(
                         color: const Color(0xff01337f),
                         borderRadius: BorderRadius.circular(5)
                     ),
                   ),
                     Positioned(
                       left: 10,
                       child: Checkbox(
                         checkColor: Colors.yellow,
                         tristate: false,
                         value: ind==index?true:false,
                         onChanged:(newvalue){

                             setState(() {
                              ind=index;


                               Timer(Duration(seconds: 2),(){
                                setState(() {
                                  ind =-1;
                                  list.removeAt(index);
                                  Database().saveData();
                                });
                             });

                             }
                             );
                           },
                             activeColor: Colors.white,
                           ),
                     ),
                     Center(
                         child: Text(list[index],style: Styles(size: 15),)),
                     ]

                    )
                   ),

             ),
           );
         },
       ),
         del==0?const Text('')
             :Center(
               child: Lottie.asset('asset/lottie/Delete.json',
                   repeat: false,width: 200),
             ),
         ed==0?const Text('')
             :Center(
               child: Lottie.asset('asset/lottie/edit.json',
               repeat: false,
               width:300),
         ),
           ind==-1?const Text('')
             :Center(
               child: Lottie.asset('asset/lottie/Approve.json',
               repeat: false,
               width:300),
         ),

      ]
     )
    );
  }
  Future edit(BuildContext context,int index){
    String s=list[index];
    var _edit=TextEditingController();
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Edit'),
        content:TextField(
          controller: _edit,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Color(0xff330063),
                  width: 3

              ),

            ),
            hintText: 'Enter text here',


          ),
          onTap: (){
            _edit.value=TextEditingValue(text: s);
          },

        ),
        actions: [
          TextButton(
              onPressed: (){

                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(onPressed: (){
            setState(() {
              ed=1;
             list[index]=_edit.text.toString();
              Database().saveData();
              Database().getData();

            });
            Navigator.pop(context);
            Timer(Duration(milliseconds: 2500),(){
              setState(() {
                ed=0;
              });
            });

          },
              child: const Text('Confirm'))

        ],

      );
    });
  }
  Future delete(BuildContext context,int index){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(onPressed: (){
            setState(() {
            del=1;
            list.removeAt(index);
            Database().saveData();
            Database().getData();
            });

            Navigator.pop(context);
            Timer(Duration(seconds: 5),(){
              setState(() {
                del=0;
              });
            });
          },
              child: const Text('Confirm'))

        ],

      );
    });
  }
  dynamic end(int index){
    return  ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(onPressed: (context){
          setState(() {
            delete(context, index);
          });
        },
          icon: Icons.delete,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'Delete',
        )
      ],
    );
  }
  dynamic start(int index){
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(onPressed: (context){
          edit(context, index);
        },
          icon: Icons.edit,
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          label: 'Edit',
        )
      ],
    );
}



}
