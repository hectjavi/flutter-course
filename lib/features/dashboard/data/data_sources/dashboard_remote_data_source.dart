import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/dashboard/data/models/account_model.dart';

class DashboardRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<List<AccountModel>> getAccountSummary() async {
  try {
    final snapshot = await _firestore.collection('cuentas').get();

    return snapshot.docs.map((doc) {
      return AccountModel.fromJson({
        ...doc.data(),
        'id': doc.id,
      });
    }).toList();
  } catch (e) {
    throw Exception('Error al obtener cuentas: $e');
  }
}
}