import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class sem_prg extends StatefulWidget{
  final  String name;
  final  String id;
   final  String photo;
  @override
  State<sem_prg> createState() => _sem_prgState();

  sem_prg(this.name, this.id, this.photo);
}

class _sem_prgState extends State<sem_prg> {
  String Sem = "1"; //dropdown
  List<String> SemOption = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cheange Sem"),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.photo),
            ),
            Text("Name : ${widget.name}",style: TextStyle(fontSize: 32),),
            DropdownButton<String>(
              value: Sem,
              onChanged: (String? newValue) {
                setState(() {
                  Sem = newValue!;
                });
              },
              items: SemOption
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: TextStyle(fontSize: 30),),
                );
              }).toList(),
            ),
            CupertinoButton(child: Text("Change Sem"), onPressed: (){
              FirebaseFirestore.instance
                  .collection("Students")
                  .doc(widget.id)
                  .update({
                'CurrentSem': Sem.toString(),
                "fees": "unpaid",
                "mobilepass": "no",
                "mobile_pass_gen_date": "notgenerate",
                "PresentDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Semester Change")));

            }),

          ],
        ),
      ),
    );
  }
}