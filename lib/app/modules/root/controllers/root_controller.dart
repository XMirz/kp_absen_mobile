import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;

  RxInt fragmentIndex = 0.obs;
  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }

  Stream<DatabaseEvent> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* _database.ref('/users').child(uid).onValue;
  }
}
