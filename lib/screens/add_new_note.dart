import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/sqldb.dart';

class addNote extends StatefulWidget {
  const addNote({super.key});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  sqlDp sqlDb = sqlDp();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff0A0F1E), title: Text("Add note")),
      body: Container(
        color: Color(0xff0A0F1E),
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff414453),
                  ),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff414453),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: note,
                    decoration: InputDecoration(
                        hintText: "Note",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23)),
                  ),
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  color: Color(0xff414453),
                  onPressed: () async {
                    int response =
                        await sqlDb.insetDb('''INSERT INTO NOTES('note','title')
                        VALUES('${note.text}','${title.text}')
                        ''');
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => homeScreen(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text(
                    "Add note",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
