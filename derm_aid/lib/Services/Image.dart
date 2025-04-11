import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Screens/Dashboard.dart';
import 'package:SparshAI/Services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFile {
  Future<void> uploadImageToFirebase(BuildContext context, File image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Patient/${UserProfileData.email.toString()}');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => print('Image uploaded'));

    // Get download URL
    String imageUrl = await storageReference.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('Patient')
        .doc(UserProfileData.email)
        .update({'img': imageUrl});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }
}
