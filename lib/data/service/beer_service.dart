import 'package:flutter/foundation.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerService {
  final collection = db.collection('beers');

  Future<int> count() async {
    final snapshot =
        await collection.where('verified', isEqualTo: true).count().get();

    return snapshot.count;
  }

  Future<List<Beer>> findLastAdded() async {
    final snapshot = await collection
        .where('verified', isEqualTo: true)
        .orderBy('_createdAt', descending: true)
        .limit(6)
        .get();

    return compute(
      parseDocuments,
      ParseDocumentsArg(
        documents: snapshot.docs,
        fromJson: Beer.fromJson,
      ),
    );
  }

  Future<Beer?> findFeatured() async {
    final snapshot =
        await collection.where('featured', isEqualTo: true).limit(1).get();
    if (snapshot.docs.isEmpty) {
      return null;
    }

    return Beer.fromJson(snapshot.docs.first.data());
  }
}
