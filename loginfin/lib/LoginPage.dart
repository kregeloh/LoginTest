import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'dart:async';
import 'dart:io';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginState();
  }
}

enum PageType{
  login,
  register
}

class _LoginState extends State<LoginPage>{

  String _email;
  String _pw;
  PageType _pageType = PageType.login;
  final loginKey = new GlobalKey<FormState>();

  bool validateandsave(){
    final form = loginKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateSubmit() async {
    if(validateandsave()){
      try {
        if(_pageType == PageType.login) {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _pw);
          print('Signed in: ${user.uid}');
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (context){
              return new HomePage();
            })
          );
        }else{
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _email, password: _pw);
            print('Registered user:${user.uid}');
            setState(() {
              _pageType = PageType.login;
            });
        }
      }
      catch(e){
        print('Error: $e');
      }
    }
  }

  void switchLogin(){
    loginKey.currentState.reset();
    setState(() {
      _pageType = PageType.login;
    });
  }

  void switchRegister(){
    loginKey.currentState.reset();
    setState(() {
      _pageType = PageType.register;
    });
  }

  @override
      Widget build(BuildContext context) {
      // TODO: implement build
        return new Scaffold(
          appBar: new AppBar(
              centerTitle: true,
              title: new Text("Login Demo"),
          ),
          body: new Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs()+buildButtons()
                ),
            ),
          )
        );
      }

      List<Widget> buildInputs(){
        return[
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Email'),
            validator: (value) => value.isEmpty ? "Email can't be empty": null,
            onSaved: (value) => _email = value,
          ),
          new TextFormField(
          decoration: new InputDecoration(
          labelText: 'Password'
          ),
          obscureText: true,
          validator: (value) => value.isEmpty ? "Password can't be empty": null,
          onSaved: (value) => _pw = value,
          )
        ];
      }

      List<Widget> buildButtons(){
        if(_pageType == PageType.login) {
          return [
            new RaisedButton(
                child: new Text('Login', style: new TextStyle(fontSize: 20.0),),
                onPressed: validateSubmit
            ),
            new FlatButton(
                onPressed: switchRegister,
                child: new Text(
                    'Register New User', style: new TextStyle(fontSize: 20.0))
            )
          ];
        } else{
          return[
            new RaisedButton(
                child: new Text('Register User', style: new TextStyle(fontSize: 20.0)),
                onPressed: validateSubmit
            ),
            new FlatButton(
              onPressed: switchLogin,
              child: new Text('Already have an Account?', style: new TextStyle(fontSize: 20.0)))
          ];
        }
      }
  }