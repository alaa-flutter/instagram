import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';


class UserFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.uId)
        .set(userModel.toMap());
  }

  // Stream<QuerySnapshot> readUser() async* {
  //   yield* _firestore
  //       .collection('users')
  //       .where('uId',
  //           isEqualTo: SharedPreferencesController()
  //               .getter(type: String, key: SpKeys.uId)
  //               .toString())
  //       .snapshots();
  // }

  Future<void> updateUser(UserModel userModel) async {
    await _firestore.collection('users').doc(userModel.uId).update({
      'username': userModel.username,
      'avatar': userModel.avatar,
    });
  }

  Future<void> updateFCMToken(String uId, String fcm) async {
    await _firestore.collection('users').doc(uId).update({'fcmToken': fcm});
  }

  Future<void> deleteUser(UserModel userModel) async {
    await _firestore.collection('users').doc(userModel.uId).delete();
  }
}


