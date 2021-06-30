import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("hello world"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child:
                  Text("create button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String book = "천년의_질문";
                firestore
                    .collection('books')
                    .doc(book)
                    .set({'page': 433, 'purchase?': false, 'title': '천년의_질문'});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("read button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String title = "";
                firestore
                    .collection("books")
                    .doc("on_intelligence")
                    .get()
                    .then((DocumentSnapshot ds) {
                  title = ds["title"];
                  print(title);
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              child:
                  Text("update button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                firestore
                    .collection("books")
                    .doc("chemistry_between_us")
                    .update({"page": 555});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child:
                  Text("delete button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                //특정 document 삭제
                firestore.collection("books").doc("천년의_질문").delete();
                //특정 document 의 field 하나를 삭제
                firestore
                    .collection('books')
                    .doc('chemistry_between_us')
                    .update({'page': FieldValue.delete()});
              },
            ),
          ],
        ),
      ),
    );
  }
}
