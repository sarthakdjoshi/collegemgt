import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms_student/Login_Page.dart';
import 'package:cms_student/student/Idcard.dart';
import 'package:cms_student/student/Upload_Assignmnet_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Fees_Reciept.dart';
import 'Mobile_Pass.dart';

class Profile_Stud extends StatefulWidget {

  const Profile_Stud({super.key});

  @override
  State<Profile_Stud> createState() => _Profile_StudState();
}

class _Profile_StudState extends State<Profile_Stud> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var icon = const Icon(Icons.verified);
  var icon2 = const FaIcon(FontAwesomeIcons.cross);
  var u_email;
  void getdata()async{
    var prefs=await SharedPreferences.getInstance();
    u_email=prefs.get("email");
  }


  void sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        print("Email verification sent successfully");
      } else {
        print("User is already verified or not signed in");
      }
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()async {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login_Page(),
                    ));
                var prefs=await SharedPreferences.getInstance();
               await prefs.clear();
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logout Succefully"),duration: Duration(seconds: 2),));
              },
              icon: const Icon(Icons.logout)),
        ],
        title: const Text("Stud_profile"),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Welcome :-${u_email.toString()}"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Upload_Assignmnet(),
                    ));
              },
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.pager),
                  Text("     "),
                  Text(
                    "View Assignment",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Id_Card(u_email),
                    ));
              },
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.idCard),
                  Text("     "),
                  Text(
                    "ID Card",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.where("email", isEqualTo:u_email).get(),
        builder: (context, snapshot) {
          print(u_email);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                var date = data['PresentDate'].toString();
                String ldate;
                if (date.length > 10 || date.isNotEmpty) {
                  ldate = date.substring(date.length - 10);
                } else {
                  ldate = "No Present Added";
                }

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
                              documentId,
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
                              "Sem",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['CurrentSem'],
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
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Address",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['address'],
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
                              "Last Present Date",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              ldate.toString(),
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
                                child: (data['fees'] == "unpaid")
                                    ? Text(
                                        data['fees'],
                                        style: const TextStyle(fontSize: 24),
                                      )
                                    : CupertinoButton(
                                        child: const Text("View Reciept"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FeesReceipt(
                                                        data['email']),
                                              ));
                                        })),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Email-Verified",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: (FirebaseAuth.instance.currentUser
                                            ?.emailVerified !=
                                        true)
                                    ? CupertinoButton(
                                        child:
                                            const Text("Verify Your Email"),
                                        onPressed: () {
                                          sendEmailVerification();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Email Verification Link Has Been Sent"),
                                            duration: Duration(seconds: 2),
                                          ));
                                        })
                                    : icon),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Mobile Pass",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                              child: (data['mobilepass'] != "yes")
                                  ? const Text(
                                      "You are Not Allow To Mobile Pass",
                                      style: TextStyle(fontSize: 24),
                                    )
                                  : CupertinoButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Mobile_Pass(
                                                        data['email'])));
                                      },
                                      child: const Text("Show Pass"),
                                    ),
                            )
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
