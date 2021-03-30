import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';
import 'package:mockito/mockito.dart';

class MockBeerRepository extends Fake implements BeerRepository {
  @override
  Future<Beer> update(Beer object) async {
    return object;
  }
}

void main() {
  group('FavoriteCubit', () {
    late FavoriteCubit favoriteCubit;
    late MockBeerRepository mockBeerRepository;

    setUp(() {
      mockBeerRepository = MockBeerRepository();
      favoriteCubit = FavoriteCubit(
        beerRepository: mockBeerRepository,
      );
    });

    test('initial state', () {});

    var beer = Beer(
      name: 'test',
      degree: 0,
      color: BeerColor.BLOND,
      style: BeerStyle.IPA,
      country: BeerCountry.FRANCE,
      creationDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'should add new beer',
      build: () => favoriteCubit,
      act: (cubit) async => cubit.addBeer(beer),
    );
  });
}
