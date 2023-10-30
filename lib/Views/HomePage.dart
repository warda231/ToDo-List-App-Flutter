// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/taskDialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  late User? _currentUser;
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _todo = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController taskController = TextEditingController();
    TextEditingController descController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          'ToDo List App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1000,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 252, 238, 105), Colors.white],
              stops: [0.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.95,
                      height: screenHeight * 0.07,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(108, 158, 158, 158),
                          ),
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        // onChanged: (){},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(_currentUser?.uid)
                        .collection("tasks")
                        .snapshots(),
                    builder: (context, Snapshot) {
                      if (Snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (Snapshot.hasError) {
                        return Text("Error: ${Snapshot.error}");
                      }
                      //var documents = Snapshot.data;

                      return SizedBox(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.8,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              var documentData = Snapshot.data?.docs[index];
                              var task = documentData?['taskName'];
                              var desc = documentData?['taskDesc'];

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: screenHeight * 0.1,
                                  width: screenWidth * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                            child: Text(
                                          task,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: SizedBox(
                                                  height: screenHeight * 0.2,
                                                  width: screenWidth * 0.2,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            final FirebaseAuth
                                                                auth =
                                                                FirebaseAuth
                                                                    .instance;

                                                            final User? user =
                                                                auth.currentUser;
                                                            final uid =
                                                                user?.uid;

                                                            await  FirebaseFirestore
                                                                              .instance
                                                                              .collection('users')
                                                                              .doc(_currentUser?.uid)
                                                                              .collection("tasks")
                                                                              .doc(Snapshot.data?.docs[index].id)
                                                                              .delete(
                                                                            
                                                                          );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Color.fromARGB(
                                                                    255,
                                                                    246,
                                                                    54,
                                                                    54),
                                                          ),
                                                          child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    scrollable:
                                                                        true,
                                                                    title:
                                                                        const Text(
                                                                      'Update Task',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.brown),
                                                                    ),
                                                                    content:
                                                                        SizedBox(
                                                                      height:
                                                                          screenHeight *
                                                                              0.4,
                                                                      width:
                                                                          screenWidth *
                                                                              0.5,
                                                                      child: Form(
                                                                          child: Column(
                                                                        children: [
                                                                          TextFormField(
                                                                            controller:
                                                                                taskController,
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 20,
                                                                                vertical: 20,
                                                                              ),
                                                                              hintText: 'Task',
                                                                              hintStyle: const TextStyle(fontSize: 14),
                                                                              icon: const Icon(CupertinoIcons.square_list, color: Colors.black),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                          TextFormField(
                                                                            controller:
                                                                                descController,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            maxLines:
                                                                                null,
                                                                            style:
                                                                                const TextStyle(fontSize: 14),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 20,
                                                                                vertical: 20,
                                                                              ),
                                                                              hintText: 'Description',
                                                                              hintStyle: const TextStyle(fontSize: 14),
                                                                              icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.black),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                        ],
                                                                      )),
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {},
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          primary:
                                                                              Colors.grey,
                                                                        ),
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          final task =
                                                                              taskController.text;
                                                                          final description =
                                                                              descController.text;

                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection('users')
                                                                              .doc(_currentUser?.uid)
                                                                              .collection("tasks")
                                                                              .doc(Snapshot.data?.docs[index].id)
                                                                              .update(
                                                                            {
                                                                              'taskName': task,
                                                                              'taskDesc': description,
                                                                            },
                                                                          );
                                                                        },
                                                                        child: const Text(
                                                                            'Save'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Color.fromARGB(
                                                                    255,
                                                                    247,
                                                                    244,
                                                                    77),
                                                          ),
                                                          child: const Text(
                                                            'Update',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TaskDialog();
                });
          },
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }
}
