import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class BeerService {
  final BeerRepository beerRepository;

  const BeerService({
    required this.beerRepository,
  });

  Future<Beer> create(BeerDto beerDto) async {
    // create beer entity
    final beer = Beer(
      creationDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      name: beerDto.name,
      degree: beerDto.degree,
      color: beerDto.color,
      style: beerDto.style,
      country: beerDto.country,
      title: beerDto.title,
      picturePath: await LocalStorage.save(beerDto.picturePath),
    );

    return beerRepository.insert(beer);
  }

  Future<Beer> update(String id, BeerDto beerDto) async {
    // update beer entity
    var beer = (await beerRepository.find(id))!;
    beer = beer.copyWith(
      name: beerDto.name,
      degree: beerDto.degree,
      color: beerDto.color,
      style: beerDto.style,
      country: beerDto.country,
      title: beerDto.title,
      picturePath: await LocalStorage.save(beerDto.picturePath),
    );

    return beerRepository.update(beer);
  }

  Future<void> delete(Beer beer) async {
    await beerRepository.delete(beer.id!);
    if (beer.picturePath != null) {
      await LocalStorage.delete(beer.picturePath!);
    }
  }

  Future<void> deleteAll() async {
    await beerRepository.deleteAll();
    await LocalStorage.deleteFiles(kBeerAssetsDirectory);
  }
}
