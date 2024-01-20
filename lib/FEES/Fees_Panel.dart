import 'package:cms/FEES/Mobile_Pass_Panel.dart';
import 'package:cms/FEES/Stud_fees.dart';
import 'package:cms/FEES/Student_binafied_panel.dart';
import 'package:cms/FEES/Transfer_Certificate_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fees_panel extends StatefulWidget {
  const Fees_panel({super.key});

  @override
  State<Fees_panel> createState() => _Fees_panelState();
}

class _Fees_panelState extends State<Fees_panel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees Managemnet"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 180,
                  width: 100,
                  child: CupertinoButton(
                    onPressed: () {
                     Navigator.push(context,MaterialPageRoute(builder: (context) => const Student_Bonafied_Panel(),));
                      },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.certificate,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Bonafide Certificate",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 180,
                  width: 100,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Stud_fees(),
                          ));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.moneyBills,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Student Fees",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 180,
                  width: 100,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Transfer_certificate_panel(),));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.moneyBillTransfer,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Transfer Certificate",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 180,
                  width: 100,
                  child: CupertinoButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const Mobile_Pass_Panel(),));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.mobileScreen,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Mobile Pass",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
