import 'dart:math';

import 'package:aps_motobike/models/bike.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BikeSources {
  static Future<List<Bike>?> fetchFeatureBikes() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('Bikes')
          .where('rating', isGreaterThan: 4.5)
          .orderBy('rating', descending: true);
      final queryDoc = await ref.get();
      return queryDoc.docs.map((doc) => Bike.fromJson(doc.data())).toList();
    } catch (e) {
      log(e.toString() as num);
      return null;
    }
  }

  static Future<List<Bike>?> fetchNewsBikes() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('Bikes')
          .orderBy('release', descending: true)
          .limit(4);
      final queryDoc = await ref.get();
      return queryDoc.docs.map((doc) => Bike.fromJson(doc.data())).toList();
    } catch (e) {
      log(e.toString() as num);
      return null;
    }
  }

   static Future<Bike?> fetchBikes(String bikeId) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('Bikes')
          .doc(bikeId);
      final doc = await ref.get();
      Bike? bike = doc.exists ? Bike.fromJson(doc.data()!) : null;
      return bike; 
    } catch (e) {
      log(e.toString() as num);
      return null;
    }
  }
}
