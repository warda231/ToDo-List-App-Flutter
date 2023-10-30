import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController taskController=TextEditingController();
        TextEditingController descController=TextEditingController();

        final FirebaseAuth auth = FirebaseAuth.instance;

        final User? user=auth.currentUser;
        final uid=user?.uid;



    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Enter New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: screenHeight * 0.4,
        width: screenWidth * 0.5,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: taskController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: ' Task',
                hintStyle: const TextStyle(fontSize: 14),
                icon:
                    const Icon(CupertinoIcons.square_list, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: descController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: ' Description',
                hintStyle: const TextStyle(fontSize: 14),
                icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                    color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final task=taskController.text;
            final description=descController.text;
            DocumentReference docRef = await FirebaseFirestore.
            instance.collection('users').doc(uid).collection('tasks').
            
            add(
  {
    'taskName': task,
    'taskDesc': description,
  },
  
);

          },
          child: const Text('Save'),
        ),
      ],
    );
  }
  
}
