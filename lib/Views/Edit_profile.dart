import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController usernameController=TextEditingController();
        TextEditingController emailController=TextEditingController();

        final FirebaseAuth auth = FirebaseAuth.instance;

        final User? user=auth.currentUser;
        final uid=user?.uid;



    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Profile',
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
              controller: usernameController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: ' Update Username',
                hintStyle: const TextStyle(fontSize: 14),
                icon:
                    const Icon(CupertinoIcons.person, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintText: ' Update Email',
                hintStyle: const TextStyle(fontSize: 14),
                icon: const Icon(CupertinoIcons.mail,
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
            final username=usernameController.text;
            final email=emailController.text;
            await FirebaseFirestore.
            instance.collection('users').doc(uid).update(
  {
    'username': username,
    'email': email,
  },
  
);

          },
          child: const Text('Save'),
        ),
      ],
    );
  }
  
}