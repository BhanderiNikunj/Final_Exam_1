import 'package:final_exam/ModalClass.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  String? name, number,email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Detail"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: txtname,
                decoration: InputDecoration(
                    label: Text("Enter Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtnumber,
                decoration: InputDecoration(
                    label: Text("Enter Mobile Number"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtemail,
                decoration: InputDecoration(
                    label: Text("Enter Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    int i=0;
                    name = txtname.text;
                    number = txtnumber.text;
                    email = txtemail.text;
                    Modal m1 = Modal(Name: name,Email: email,Number: number);
                    AllData.add(m1);
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
