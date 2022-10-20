import 'package:flutter/material.dart';
import 'package:aplikasi_notes/db/db_helper.dart';
import 'package:aplikasi_notes/model/notes.dart';

class FormNotes extends StatefulWidget {
  final Notes? notes;

  FormNotes({this.notes});

  @override
  _FormNotesState createState() => _FormNotesState();
}

class _FormNotesState extends State<FormNotes> {
  DBHelper db = DBHelper();

  TextEditingController? judul;
  TextEditingController? subjudul;
  TextEditingController? tanggal;
  TextEditingController? isi;

  @override
  void initState() {
    judul = TextEditingController(
        text: widget.notes == null ? '' : widget.notes!.judul);
    subjudul = TextEditingController(
        text: widget.notes == null ? '' : widget.notes!.subjudul);
    tanggal = TextEditingController(
        text: widget.notes == null ? '' : widget.notes!.tanggal);
    isi = TextEditingController(
        text: widget.notes == null ? '' : widget.notes!.isi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES'),
        actions: [
          IconButton(
            onPressed: () {
              upsertNotes();
            },
            icon: Icon(Icons.save_as_sharp),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 0, 74, 142),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Column(children: [
                  TextFormField(
                    controller: judul,
                    decoration: InputDecoration(hintText: 'Judul'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: subjudul,
                    decoration: InputDecoration(hintText: 'Jenis Notes'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tanggal,
                    decoration: InputDecoration(hintText: 'Tanggal'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: isi,
                    decoration: InputDecoration(hintText: 'Isi'),
                    maxLines: null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          )),
    );
  }

  //update insert notes
  Future<void> upsertNotes() async {
    if (widget.notes != null) {
      //insert
      await db.updateNotes(Notes.fromMap({
        'id': widget.notes!.id,
        'judul': judul!.text,
        'subjudul': subjudul!.text,
        'tanggal': tanggal!.text,
        'isi': isi!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //update
      await db.saveNotes(Notes(
        judul: judul!.text,
        subjudul: subjudul!.text,
        tanggal: tanggal!.text,
        isi: isi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
