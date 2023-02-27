import 'dart:io';

import 'package:final_exam/ModalClass.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtemail = TextEditingController();

  String Images = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(Icons.arrow_back),
          actions: [Icon(Icons.menu)],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "MY CONTECT",
                style: TextStyle(color: Colors.black26, fontSize: 25),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Type Name Or Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AllData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: FileImage(
                              File("${AllData[index].Images}"),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${AllData[index].Name}",style: TextStyle(fontSize: 15),),
                              Text("${AllData[index].Number}",style: TextStyle(fontSize: 15),),
                              Text("${AllData[index].Email}",style: TextStyle(fontSize: 10),),
                            ],
                          ),
                          Row(
                            children: [
                              call("${AllData[index].Number}"),
                              sms("${AllData[index].Number}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            actions: [
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        ImagePicker pick = ImagePicker();
                                        XFile? image = await pick.pickImage(
                                            source: ImageSource.gallery);
                                        setState(() {
                                          Images = image!.path;
                                        });
                                      },
                                      icon: Icon(Icons.camera_alt),
                                    ),
                                    CircleAvatar(
                                      radius: 100,
                                      backgroundImage: FileImage(File("$Images"),),
                                    ),
                                  ],
                                ),
                              ),
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
                                keyboardType: TextInputType.phone,
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
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Modal m1 = Modal(
                                            Name: txtname.text,
                                            Number: txtnumber.text,
                                            Email: txtemail.text,
                                          Images: Images,
                                        );
                                        AllData.add(m1);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text("Submit"),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text("Back"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget call(String call) {
    return InkWell(
      onTap: () async {
        Uri lanchUri = Uri(
          scheme: "tel",
          path: call,
        );
        await launchUrl(lanchUri);
      },
      child: Container(
        height: 50,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          "Call",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  Widget sms(String call) {
    return InkWell(
      onTap: () async {
        Uri lanchUri = Uri(
          scheme: "sms",
          path: call,
        );
        await launchUrl(lanchUri);
      },
      child: Container(
        height: 50,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          "SMS",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
