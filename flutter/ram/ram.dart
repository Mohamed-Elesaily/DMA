import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';


class Ram extends StatefulWidget {
 
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Ram> {
  
  List<String> _memory=[]; 
  void _getData() async{
    // elemnts.clear();
    final memory = new File('ram.txt');
   await memory.openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      _memory.add(l);
    });
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  
  @override
  Widget build(BuildContext context) {
    //  sleep(Duration(seconds: 5));
    return Scaffold(
      
      appBar: AppBar(
         centerTitle: true,
        title: Text('Ram'),
        

      ),
      
      body:  ListView.builder(
        itemCount: _memory.length,
        itemBuilder: (BuildContext context, index){
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
                      child: ListTile(
                      title:Text('$index:  ${_memory[index]} '),
                    ),
            ),
          );
        
        },
      )
      
    );
  }
}