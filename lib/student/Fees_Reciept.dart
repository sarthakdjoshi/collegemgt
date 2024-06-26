import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeesReceipt extends StatefulWidget {
  final String u_email;

  const FeesReceipt(this.u_email, {super.key});

  @override
  State<FeesReceipt> createState() => _FeesReceiptState();
}

class _FeesReceiptState extends State<FeesReceipt> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  late List<Map<String, dynamic>> studentData;
  var paid_fess = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees Receipt"),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.where("email", isEqualTo: widget.u_email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            studentData = [];
            for (var document in documents) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String documentId = document.id;
              if (data['Course'] == "Bca") {
                paid_fess = "13,500";
              } else if (data['Course'] == "B.com") {
                paid_fess = "9,000";
              } else if (data['Course'] == "M.com") {
                paid_fess = "12,000";
              } else if (data['Course'] == "MSC.IT") {
                paid_fess = "18,000";
              } else if (data['Course'] == "Mca") {
                paid_fess = "19,000";
              }
              studentData.add({
                'documentId': documentId,
                'name': data['name'],
                'Course': data['Course'],
                'email': data['email'],
                'gender': data['gender'],
                'photo': data['photo'],
                'addharcard': data['addharcard'],
                'city': data['city'],
                'state': data['state'],
                'dob': data['dob'],
                'fees': data['fees'],
                'paid_fess': paid_fess,
              });
            }
            return ListView.builder(
              itemCount: studentData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = studentData[index];
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        data['photo'],
                        width: 200,
                        height: 200,
                      ),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "APP_ID",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['documentId'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Name",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['name'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Stream",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['Course'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Email",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(child: Text(data['email'])),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Gender",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['gender'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              children: [
                                const TableCell(
                                    child: Text(
                                  "Student Paid fee",
                                  style: TextStyle(fontSize: 24),
                                )),
                                TableCell(
                                    child: Text(
                                  data['paid_fess'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                              ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Addharcard No.",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['addharcard'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "city",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['city'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "State",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['state'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Date Of Birth",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['dob'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "fees",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['fees'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
