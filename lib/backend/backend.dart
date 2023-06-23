import 'package:hive/hive.dart';
import 'package:to_do/backend/list.dart';

class Database{
   final box = Hive.box('Tasks');

  getData(){
     list=box.get('tasks');
     if(list.isEmpty){
       list.add('Open the App');
       list.add('Set your Goals or Works Here');

     }
  }
  saveData(){

    box.put('tasks',list);
  }
}