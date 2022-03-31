import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saloncrud/CustomerBookings/book_list.dart';
import 'package:saloncrud/test.dart';
import '../constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(ExampleApp());
// }

Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 2,
                  child: Text('About Us'),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        // child: Icon(Icons.bungalow_rounded, size: 90.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Your Proffesional Hair Studio'),
                            Text(
                              'Salon Looks',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Text('Colombo 005, Sri Lanka'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(height: 3.0),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.auto_stories,
                      text: 'Hair Styles',
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const SecondRoute()),
                        // );
                      },
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.person_pin_circle_rounded,
                      text: 'Make Appointment',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text("Fill Your Appointment"),
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
                                        ),
                                        controller: nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your Name';
                                          }
                                          return null;
                                        },
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
                                        ),
                                        controller: addressController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your Address';
                                          }
                                          return null;
                                        },
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
                                        ),
                                        controller: ageController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your Age';
                                          }
                                          return null;
                                        },
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
                                        ),
                                        controller: dateController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Appointment Date';
                                          }
                                          return null;
                                        },
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
                                        ),
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Your Phone Number';
                                          }
                                          return null;
                                        },
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

                                  //Add Button

                                  RaisedButton(
                                    onPressed: () {
                                      //TODO: Firestore create a new record code

                                      Map<String, dynamic> newBook =
                                          new Map<String, dynamic>();
                                      newBook["name"] = nameController.text;
                                      newBook["address"] =
                                          addressController.text;
                                      newBook["age"] = ageController.text;
                                      newBook["date"] = dateController.text;
                                      newBook["phone"] = phoneController.text;

                                      Firestore.instance
                                          .collection("appointments")
                                          .add(newBook)
                                          .whenComplete(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Text(
                                      "Make Appointment",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Expanded(
                    child: DashboardButton(
                      icon: Icons.list_rounded,
                      text: 'Your Appointments',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyBookings()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Salon Looks'),
                Text(
                  'Explore the trends',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  FeaturePlantCard(
                    image: "assets/images/cr2.jpg",
                    press: () {},
                  ),
                  FeaturePlantCard(
                    image: "assets/images/cr3.jpg",
                    press: () {},
                  ),
                  FeaturePlantCard(
                    image: "assets/images/cr4.jpg",
                    press: () {},
                  ),
                  FeaturePlantCard(
                    image: "assets/images/cr5.jpg",
                    press: () {},
                  ),
                  FeaturePlantCard(
                    image: "assets/images/cr6.webp",
                    press: () {},
                  ),
                  FeaturePlantCard(
                    image: "assets/images/cr7.jpg",
                    press: () {},
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Row(
            //     children: <Widget>[],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.6,
              child: FittedBox(
                child: Icon(icon),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textScaleFactor: 0.8,
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    Key? key,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}

// import 'package:badges/badges.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:salon_app/Forms/make_appointment.dart';
// import 'package:salon_app/screens/Manage_appointments/appointment_home.dart';
// import 'package:salon_app/screens/profile_page.dart';

// import '../Manage_appointments/Appointment_home.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _ProductListState createState() => _ProductListState();
// }

// class _ProductListState extends State<HomePage> {
//   List<String> productName = [
//     'Shoe 1',
//     'Shoe 2',
//     'Shoe 3',
//     'Shoe 4',
//   ];
//   List<String> productUnit = ['KG', 'Dozen', 'KG', 'DG'];
//   List<int> productPrice = [4090, 6990, 7990, 8990];
//   List<String> productImage = [
//     'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
//     'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
//     'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
//     'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Salon Looks",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.purple,
//           centerTitle: true,
//           actions: [
//             ElevatedButton(
//               // onTap: () {
//               //   Navigator.push(context,
//               //       MaterialPageRoute(builder: (context) => AppointmentHome()));
//               // },

//               onPressed: () {},
//               child: Center(
//                 child: Badge(
//                   badgeColor: Colors.black,
//                   animationDuration: Duration(milliseconds: 300),
//                   child: Icon(Icons.book_online),
//                 ),
//               ),
//             ),
//             SizedBox(width: 20.0)
//           ],
//         ),
//         body: GridView.builder(
//           itemCount: productImage.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 4.0 / 10.0,
//             crossAxisCount: 2,
//           ),
//           padding: EdgeInsets.all(5),
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//                 padding: EdgeInsets.all(5),
//                 child: Card(
//                     semanticContainer: true,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Expanded(
//                             child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: NetworkImage(
//                                     productImage[index].toString()),
//                                 fit: BoxFit.fill),
//                           ),
//                         )),
//                         Center(
//                           child: Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Text(
//                                 productName[index].toString(),
//                                 style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                         Center(
//                           child: Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Text(
//                                 productPrice[index].toString() + "" + " LKR",
//                                 style: TextStyle(fontSize: 18.0),
//                               )),
//                         ),
//                         Container(
//                           height: 100,
//                           alignment: Alignment.center,
//                           // padding: EdgeInsets.all(20),
//                           child: ElevatedButton.icon(
//                             onPressed: () {},
//                             icon: Icon(Icons
//                                 .shopping_basket), //icon data for elevated button
//                             label: Text("Add to Cart"), //label text
//                             style: ElevatedButton.styleFrom(
//                                 primary: Colors
//                                     .grey //elevated btton background color
//                                 ),
//                           ),
//                         )
//                       ],
//                     )));
//           },
//         ));
//   }
// }
