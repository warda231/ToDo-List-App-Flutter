import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage =FirebaseStorage.instance;
final FirebaseFirestore store =FirebaseFirestore.instance;



class saveimg{
  Future<String> uploadimg(String child,Uint8List file) async{
    Reference ref=_storage.ref().child(child);
    UploadTask task= ref.putData(file);
    TaskSnapshot snapshot=await task;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
Future<String> saveData({
    required Uint8List file,
  }) async {
    String resp = " Some Error Occurred";
    try{
      
        String imageUrl = await uploadimg('users', file);
        await store.collection('user').add({
          'imageLink': imageUrl,
        });

        resp = 'success';
      
    }
        catch(err){
          resp =err.toString();
        }
        return resp;
  }

}