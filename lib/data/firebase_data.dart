import 'package:firebase_database/firebase_database.dart';

class FirebaseData {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('dataModelDB');

  createInstance(String? queryDb) {
    reference = FirebaseDatabase.instance.ref().child('dataModelDB');
  }

  Future insertDb(dynamic data) async {
    await reference.set(data);
  }

  Future readData() async {
    DatabaseEvent event = await reference.once();
    if(event.previousChildKey!.isNotEmpty){
      return event.snapshot.value;
    }
  }

  Future remove() async {
    await reference.remove();
  }

  Future update(Map<String, dynamic> data) async {
    await reference.update(data);
  }
}
