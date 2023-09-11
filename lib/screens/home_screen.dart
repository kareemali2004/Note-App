import 'package:flutter/material.dart';
import 'package:note_app/screens/update_notes.dart';
import 'package:note_app/sqldb.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  sqlDp sqlDb = sqlDp();
  List notes = [];
  bool isLoading = true;
  Future readDb() async {
    List<Map> response = await sqlDb.readDb("SELECT * FROM NOTES");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    readDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0A0F1E),
        title: Center(
            child: Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Color(0xff414453),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text("Note App")))),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff414453),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          }),
      body: Container(
          color: Color(0xff0A0F1E),
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              ListView.builder(
                itemCount: notes.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    color: Color(0xff414453),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                          title: Text(
                            "${notes[i]['title']}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ), // Remove the extra curly braces
                          subtitle: Text(
                            "${notes[i]['note']}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlDb.deleteDb(
                                      "DELETE FROM NOTES WHERE id = ${notes[i]['id']} ");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => updateNotes(
                                            title: notes[i]['title'],
                                            note: notes[i]['note'],
                                            id: notes[i]['id'],
                                          )));
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ],
                          )
                          // Remove the extra curly braces
                          ),
                    ),
                  );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: MaterialButton(
              //       height: 50,
              //       color: Colors.blue,
              //       child: Text(
              //         "delete database",
              //         style: TextStyle(fontSize: 24),
              //       ),
              //       onPressed: () async {
              //         await sqlDb.myDeleteDtaBase();
              //       }),
              // ),
            ],
          )),
    );
  }
}
