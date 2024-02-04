import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/FEES/Stuent_bonafied.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Student_Bonafied_Panel extends StatefulWidget {
  const Student_Bonafied_Panel({super.key});

  @override
  State<Student_Bonafied_Panel> createState() => _Student_Bonafied_PanelState();
}

class _Student_Bonafied_PanelState extends State<Student_Bonafied_Panel> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = FirebaseFirestore.instance.collection('Students').get();
  var search = TextEditingController();
  var fees_detail = "";
  var fee_lable = true;
  var lable = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Bonafied Certificate"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: abc,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;
                String documentId = documents[index].id;
                fees_detail = data['fees'];
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.8,
                          child: TextField(
                            controller: search,
                            decoration:
                                const InputDecoration(labelText: "Search Name"),
                          ),
                        ),
                        CupertinoButton(
                            child: const Text("Search"),
                            onPressed: () {
                              if (search.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Enter Name"),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                abc = FirebaseFirestore.instance
                                    .collection('Students')
                                    .where("name",
                                        isEqualTo:
                                            search.text.trim().toString())
                                    .get();

                                setState(() {});
                                search.clear();
                              }
                            })
                      ],
                    ),
                    SingleChildScrollView(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['Course']),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['photo']),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            print(documentId);
                            try {
                              if (data['fees'] == "unpaid") {
                                await users.doc(documentId).update({
                                  'fees': 'paid',
                                });
                                print('Fees updated successfully!');
                              } else if (data['fees'] == "paid") {
                                print("reciept");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Student_Bonafied(data['email']),
                                    ));
                              }
                            } catch (e) {
                              print('Error updating user name: $e');
                            }
                          },
                          child: (fees_detail == "unpaid")
                              ? const Text("Paid")
                              : const Text("Bonafied"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}