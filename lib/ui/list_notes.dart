import 'package:flutter/material.dart';
import 'package:aplikasi_notes/db/db_helper.dart';
import 'package:aplikasi_notes/model/notes.dart';
import 'package:aplikasi_notes/ui/detail_notes.dart';
import 'package:aplikasi_notes/ui/form_notes.dart';

class ListNotesPage extends StatefulWidget {
  const ListNotesPage({Key? key}) : super(key: key);

  @override
  _ListNotesPageState createState() => _ListNotesPageState();
}

class _ListNotesPageState extends State<ListNotesPage> {
  List<Notes> listNotes = [];
  DBHelper db = DBHelper();

  @override
  void initState() {
    _getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ui tampilan awal
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 137, 159),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 81, 121),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(327.0),
              )),
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 215, 234, 236),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listNotes.length,
        itemBuilder: (context, index) {
          Notes notes = listNotes[index];
          return Container(
              child: Column(children: [
            ListTile(
                onTap: () {
                  //edit
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNotesPage(notes),
                      ));
                },
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "${notes.judul}",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 53, 75, 101),
                  ),
                ),
                //overflow: TextOverflow.ellipsis(pada text…)
                subtitle: Text(
                  '${notes.isi}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          _openFormEdit(notes);
                        },
                        icon: Icon(Icons.edit_note)),
                    IconButton(
                        onPressed: () {
                          _deleteNotes(notes, index);
                        },
                        icon: Icon(Icons.delete_forever))
                  ],
                ))
          ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        backgroundColor: Color.fromARGB(255, 3, 39, 56),
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllNotes() async {
    var list = await db.getAllNotes();
    setState(() {
      listNotes.clear();
      list!.forEach((notes) {
        listNotes.add(Notes.fromMap(notes));
      });
    });
  }

  //form create
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormNotes()));
    if (result == 'save') {
      await _getAllNotes();
    }
  }

  Future<void> _deleteNotes(Notes notes, int position) async {
    await db.deleteNotes(notes.id!);

    setState(() {
      listNotes.removeAt(position);
    });
  }

  //form edit
  Future<void> _openFormEdit(Notes notes) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormNotes(notes: notes)));

    if (result == 'update') {
      await _getAllNotes();
    }
  }
}
