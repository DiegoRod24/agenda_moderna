import 'package:firebase_core/firebase_core.dart';

class FirebaseBootstrapService {
  FirebaseBootstrapService._();

  static final instance = FirebaseBootstrapService._();

  bool _ready = false;
  bool get ready => _ready;

  Future<bool> initialize() async {
    try {
      await Firebase.initializeApp();
      _ready = true;
    } catch (_) {
      _ready = false;
    }
    return _ready;
  }
}
