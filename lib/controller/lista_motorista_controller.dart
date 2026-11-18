import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/presenca_model.dart';

class ListaMotoristaController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream em tempo real da coleção 'presencas' (RF004 - Segunda coleção)
  Stream<List<PresencaModel>> streamPresencas() {
    return _firestore.collection('presencas').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PresencaModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}