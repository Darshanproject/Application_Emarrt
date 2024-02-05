import 'package:myeapp/consts/consts.dart';

class FirestoreServices {
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
}