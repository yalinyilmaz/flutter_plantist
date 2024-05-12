import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plantist_app/view/pages/sign_in_page.dart';
import 'package:flutter_plantist_app/view/pages/todo_list_page.dart';
import 'package:go_router/go_router.dart';

class AuthManager {
  FirebaseAuth auth = FirebaseAuth.instance;
  void createAccount(String email, String password) async {
    try{
      var userCredentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          print(userCredentials.toString());
    }catch(e){
      print(e.toString());
    }
  }

  void login(String email, String password,BuildContext ctx) async {
    try {
      var userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      log(userCredentials.toString());
      ctx.push(TodoListPage.routeName);
    } catch (e) {
      print(e.toString());
    }
  }
}
