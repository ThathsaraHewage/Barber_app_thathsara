import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: MyBookings(),
    );
  }
}

class MyBookings extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyBookings> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text("Salon Looks", textAlign: TextAlign.center)),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: BookList(),
    );
  }
}

class BookList extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO: Retrive all records in collection from Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('appointments').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children:
                  snapshot.data!.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text("Update Your Appointment"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          labelText: 'Name: ',
                                          labelStyle: TextStyle(fontSize: 20.0),
                                          border: OutlineInputBorder(),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                          hintText: document['name'],
                                        ),
                                        controller: nameController,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          labelText: 'Address: ',
                                          labelStyle: TextStyle(fontSize: 20.0),
                                          border: OutlineInputBorder(),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                          hintText: document['address'],
                                        ),
                                        controller: addressController,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          labelText: 'Age: ',
                                          labelStyle: TextStyle(fontSize: 20.0),
                                          border: OutlineInputBorder(),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                          hintText: document['age'],
                                        ),
                                        controller: ageController,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          labelText: 'Date: ',
                                          labelStyle: TextStyle(fontSize: 20.0),
                                          border: OutlineInputBorder(),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                          hintText: document['date'],
                                        ),
                                        controller: dateController,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      child: TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          labelText: 'Phone Number: ',
                                          labelStyle: TextStyle(fontSize: 20.0),
                                          border: OutlineInputBorder(),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                          hintText: document['phone'],
                                        ),
                                        controller: phoneController,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: RaisedButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // Update Button
                                  RaisedButton(
                                    onPressed: () {
                                      //TODO: Firestore update a record code

                                      Map<String, dynamic> updateAppointment =
                                          new Map<String, dynamic>();
                                      updateAppointment["name"] =
                                          nameController.text;
                                      updateAppointment["address"] =
                                          addressController.text;
                                      updateAppointment["age"] =
                                          ageController.text;
                                      updateAppointment["date"] =
                                          dateController.text;
                                      updateAppointment["phone"] =
                                          phoneController.text;

                                      // Updae Firestore record information regular way
                                      Firestore.instance
                                          .collection("appointments")
                                          .document(document.documentID)
                                          .updateData(updateAppointment)
                                          .whenComplete(() {
                                        Navigator.of(context).pop();
                                      });

                                      // Update firestore record information using a transaction to prevent any conflict in data changed from different sources
                                      Firestore.instance
                                          .runTransaction((transaction) async {
//                                          await transaction.update(document.reference, {'title': nameController.text, 'author': addressController.text })
                                        await transaction.update(
                                            document.reference,
                                            updateAppointment);
                                      });
                                    },
                                    child: Text(
                                      "Update Appointment",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      title: new Text("Name : " + document['name']),
                      subtitle: new Text("Address : " + document['address']),
                      trailing:
                          // Delete Button
                          InkWell(
                        onTap: () {
                          //TODO: Firestore delete a record code
                          Firestore.instance
                              .collection("appointments")
                              .document(document.documentID)
                              .delete()
                              .catchError((e) {
                            print(e);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
