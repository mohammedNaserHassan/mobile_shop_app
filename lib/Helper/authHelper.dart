import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_shop_app/Services/customDialog.dart';

class Auth_helper {
  Auth_helper._();

  static Auth_helper auth_helper = Auth_helper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


//////Register User
  Future<UserCredential?> signup(String email, String password) async {
    try {
      UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustom('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustom('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

////////////////////////////////////////////////////
  //////Login User
  Future<UserCredential?> signin(String email, String password) async {
    try {
      UserCredential? userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog.showCustom('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustom('Wrong password provided for that user.');
      }
    }
  }

////////////////////////////////////////////////////////////
  ////////Log out User
  signOut() async {
    await firebaseAuth.signOut();
  }

////////////////////////////////////////////////////////////
  ////Get Current User
  Future<User?> getCurrentUser() async {
    try {
      var currentuser = firebaseAuth.currentUser;
      if (currentuser != null) {
        print(currentuser);
        return firebaseAuth.currentUser;
      }
    } on Exception catch (e) {}
  }

  ////////////////////////////////////////////////////////////
////////Get Id of User
  String? getUserId() {
    try {
      return firebaseAuth.currentUser?.uid;
    } on Exception catch (e) {
      // TODO
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
  ////Check user if found or not
  bool checkUser() {
    if (firebaseAuth.currentUser == null) {
      return false;
    }
    else {
      return true;
    }
  }

////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////Reset Password///////////////////////////////////////
  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustom('Reset password link has been sent to your email');
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


}