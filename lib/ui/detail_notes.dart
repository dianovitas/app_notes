import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:aplikasi_notes/model/notes.dart';

class DetailNotesPage extends StatelessWidget {
  final Notes? notes;

  DetailNotesPage(this.notes);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NOTES'),
          backgroundColor: Color.fromARGB(255, 175, 234, 250),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Judul',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${notes!.judul}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sub judul',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${notes!.subjudul}'),
                  Text(
                    'Tanggal',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${notes!.tanggal}'),
                  Text(
                    'Isi',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text('${notes!.isi}'),
                ],
              ),
            )
          ]),
        ));
  }
}
