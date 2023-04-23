import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:training_newwave/model/note_entity.dart';

class FireBaseHelper {
  static final db = FirebaseFirestore.instance;

  Future<List<NoteEntity>> getAllNote() async {
    List<NoteEntity> listNote = [];
    try {
      await Firebase.initializeApp();
      await db.collection('notes').get().then((QuerySnapshot querySnapshot) {
        for ( int i =0 ; i< querySnapshot.docs.length ; i++) {
          listNote.add(NoteEntity.fromDbMap(querySnapshot.docs[i].data()));
        }
      });
      // for (int i = 0; i < data.length; i++) {
      //   final note = NoteEntity.fromDbMap(data[i]);
      //   listNote.add(note);
      // }
      return listNote;
    } catch (e) {
      return [];
    }
  }

  Future<void> addNote({
    required String title,
    required String describe,
    required int color,
  }) async {
    await Firebase.initializeApp();
    final docRef = db.collection('notes').doc();
    NoteEntity noteEntity = NoteEntity(
      id: docRef.id,
      title: title,
      describe: describe,
      color: color,
    );

    try{
      await docRef.set(noteEntity.toDbMap());
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteNote(String id) async {
    try{
      await db.collection('notes').doc(id).delete();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
