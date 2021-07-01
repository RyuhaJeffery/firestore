import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDRoute extends StatefulWidget {
  const CRUDRoute({Key? key}) : super(key: key);

  @override
  _CRUDRouteState createState() => _CRUDRouteState();
}

class _CRUDRouteState extends State<CRUDRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Color(0xff67666b),
              child: Text("member 추가", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String n_member = "Heo";
                firestore
                    .collection('member')
                    .doc(n_member)
                    .set({'age': 21, 'attendance?': false, 'part': 'Design'});
              },
            ),
            FlatButton(
              color: Color(0xffaf0022),
              child:
                  Text("member 한명 가져오기", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String title = "";
                firestore
                    .collection("member")
                    .doc("Ryu")
                    .get()
                    .then((DocumentSnapshot ds) {
                  title = ds["part"];
                  print(title);
                  print(ds["age"]);
                });
              },
            ),
            FlatButton(
              color: Color(0xffd1cfd2),
              child: Text("member update",
                  style: TextStyle(color: Colors.black87)),
              onPressed: () {
                firestore
                    .collection("member")
                    .doc("Ryu")
                    .update({"part": "Desgramming"});
              },
            ),
            FlatButton(
              color: Color(0xff212345),
              child: Text("member 삭제", style: TextStyle(color: Colors.white)),
              onPressed: () {
                //특정 member 삭제
                firestore.collection("member").doc("Heo").delete();
                //특정 member에서 하나의 field만 삭제
                firestore
                    .collection('member')
                    .doc('Ryu')
                    .update({'part': FieldValue.delete()});
              },
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back to main'),
            ),
          ],
        ),
      ),
    );
  }
}
