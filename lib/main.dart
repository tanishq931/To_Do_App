import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/UI/Home.dart';



void main() async{

await Hive.initFlutter();
var box = await Hive.openBox('Tasks');

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override



  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
     const Duration(seconds: 4),
        (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff002244),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Lottie.asset('asset/lottie/Splash.json'),
           Text('TO-DO APP', style: GoogleFonts.actor(

           textStyle:const TextStyle(
              color: Color(0xff7FFFD4),
              fontSize: 33,
              fontWeight: FontWeight.bold,

             ),


           ),
        ),


        ]
       )
      )

    );
  }

}
