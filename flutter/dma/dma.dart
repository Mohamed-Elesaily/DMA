import 'package:flutter/material.dart';
import 'dart:io';

class DMA extends StatefulWidget {
  @override
  _DMAState createState() => _DMAState();
}

class _DMAState extends State<DMA> {
  final _address1 = TextEditingController();
  final _address2 = TextEditingController();
  final _address3 = TextEditingController();
  List<Map<String,String>>_arrange = [];
  var _file = File('data.txt');
  final List _inst = [];

  String _dropdownValue = '1';
  String instruction;
  final double raduis = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.arrow_forward_ios),
    
        onPressed: () {
          var file = _file.openWrite();
          for (int i = 0; i < _inst.length; i++) {
            file.write("${_inst[i]}\n");
          }
          if(_dropdownValue == "1"){
          Process.run('python', ['control.py']);}
          else{
            Process.run('python', ['control1.py']);
          }
         
         
        },
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.refresh),
            onPressed: (){
              setState(() {
                _arrange.clear();
                _inst.clear();
              });
              
            },
          ),
           IconButton(
            icon:Icon(Icons.memory),
            onPressed: (){
            Navigator.pushNamed(context, '/ram');
            }
           )
        ],
        title: Text(
          'DMA',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
           SizedBox(
            height: 60,
          ),
          
             Padding(
               padding: const EdgeInsets.only(right: 30),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('opcode'),  
                  Text('address 1'),
                  Text('address 2'),
                  Text('address 3'),
                
            
            ],),
             ),
          
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // DropdownButton<String>(
              //     items: ['Add', 'Equal'].map((String dropDownStringItem) {
              //       return DropdownMenuItem<String>(
              //         value: dropDownStringItem,
              //         child: Text(dropDownStringItem),
              //       );
              //     }).toList(),
              //     // value: '1',

              //     onChanged: (valueSelectedByUser) {
              //       setState(() {
              //         if (valueSelectedByUser == 'Add') {
              //             setState(() {
              //               _dropdownValue = '0';

              //             });
                        
                       
              //         } else {
                        
              //            setState(() {
              //               _dropdownValue = '1';

              //             });
                        
              //         }
              //       });
              //     }),
            
        
            DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  value: "0",
                  child: Text(
                    "Add",
                  ),
                ),
                
                DropdownMenuItem(
                  value: "1",
                  child: Text(
                    "Move",
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
              value: _dropdownValue,
            ),
       
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(raduis))),
                height: 50,
                width: 100,
                child: TextField(
                  // decoration: InputDecoration(
                  //     labelText: 'Distenation',
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0)
                  // )

                  // ),
                  controller: _address1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(raduis))),
                height: 50,
                width: 100,
                child: TextField(
                  controller: _address2,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(raduis))),
                height: 50,
                width: 100,
                child: TextField(
                  controller: _address3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.beenhere,
                  size: 25,
                ),
                tooltip: 'Adding instruction',
                onPressed: () {
                  setState(() {
                    
                    _inst.add(
                        "${_dropdownValue} ${_address1.text} ${_address2.text} ${_address3.text}");
                        _arrange.add({
                          'add1':_address1.text,
                          'add2':_address2.text,
                          'add3':_address3.text,
                        });
                                   
                    print(_arrange);  
                  });
                },
              ),
            ],
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: _inst.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children:<Widget>[
                           opcode(_inst[index][0]),
                            Text('${_arrange[index]['add1']}',style: TextStyle(fontSize: 20), ),
                            Text('${_arrange[index]['add2']}',style: TextStyle(fontSize: 20) ),
                            Text('${_arrange[index]['add3']}',style: TextStyle(fontSize: 20) ),
                       
                         ]
                       ),
                     
                         
                        
                    
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
  CircleAvatar opcode(String op){
    print(op);
    switch(op){

      case '0':return CircleAvatar(
        child: Text('+',style: TextStyle(fontSize: 30,color: Colors.white),),
      
      );

      case '1':return CircleAvatar(
      child: Text('=',style: TextStyle(fontSize: 30,color: Colors.white),),
      
      );            

      default: return CircleAvatar();              
      

      
    }

  }
  void write() {
    _file.writeAsString('');
  }
}
