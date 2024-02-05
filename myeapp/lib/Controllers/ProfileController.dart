import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myeapp/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{
  var profileImgPath=''.obs;
  var profileimagelink ='';
  var isloading =false.obs;
  var namecontroller =TextEditingController();
  var oldpasscontroller =TextEditingController();
  var newpasscontroller = TextEditingController();
  changeimage(context)async{
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery ,imageQuality: 70);
      // ignore: unnecessary_null_comparison
      if(img == null) return null;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
uploadProfileimage()async{
  // ignore: unused_local_variable
  var filename = basename(profileImgPath.value);
  var destination = 'images/${currentuser!.uid}/filename';  
  Reference ref=FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(File(profileImgPath.value));
  profileimagelink = await ref.getDownloadURL();
}
  updateProfile({name,password,imgUrl}) async {
var store = firestore.collection(userCollection).doc(currentuser!.uid);
 await store.set({
    'name':name,
    'password':password,
    'imageurl':imgUrl,
  },SetOptions(merge: true));
  isloading(false);
  }

  changeAuthPassword({email,password,newpassword})async{
    final cred= EmailAuthProvider.credential(email: email, password: password);
    await currentuser!.reauthenticateWithCredential(cred).then((value){
      currentuser!.updatePassword(newpassword);
    }).catchError((Error){
      print(Error.toString());
    });
    
  }
}