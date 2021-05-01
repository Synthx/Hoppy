import 'package:flutter/services.dart';
import 'package:hoppy/data/data.dart';
import 'package:logging/logging.dart';

class BeerColorProvider {
  final BeerColorRepository beerColorRepository;
  final BeerColorService beerColorService;

  final _logger = Logger('BeerColorProvider');

  BeerColorProvider({
    required this.beerColorRepository,
    required this.beerColorService,
  });

  Future<void> check() async {
    // load last synchronization date from database
    final count = await beerColorRepository.count();
    if (count != 0) {
      // get last verification date
      // check for new update
    } else {
      _logger.info('');
      final bytes = await rootBundle.load('assets/data/beer-color.json');
    }
  }

  Future<List<BeerColor>> findAll() async {
    return beerColorRepository.findAll();
  }
}
