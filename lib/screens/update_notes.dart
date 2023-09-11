import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/sqldb.dart';

class updateNotes extends StatefulWidget {
  final title;
  final note;
  final id;

  updateNotes({super.key, this.title, this.note, this.id});

  @override
  State<updateNotes> createState() => _updateNotesState();
}

class _updateNotesState extends State<updateNotes> {
  sqlDp sqlDb = sqlDp();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0A0F1E),
        title: Text("update note"),
      ),
      body: Container(
        color: Color(0xff0A0F1E),
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff414453),
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: note,
                    decoration: InputDecoration(
                      hintText: "note",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff414453),
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "title",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  color: Color(0xff414453),
                  onPressed: () async {
                    int response = await sqlDb.updateDb('''
    
                            UPDATE NOTES SET
                           note="${note.text}",
                            title="${title.text}"
                            WHERE id =${widget.id}
                                ''');

                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => homeScreen(),
                          ),
                          (route) => false);
                    } else {
                      print(
                          "No rows were updated. Check the ID and database content.");
                    }
                  },
                  child: Text(
                    "update note",
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
