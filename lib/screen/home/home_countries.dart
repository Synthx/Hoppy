import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/theme/theme.dart';

import 'home_section.dart';

class HomeCountriesList extends StatelessWidget {
  const HomeCountriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final countries = Country.values.take(4).toList();

    return HomeSection(
      title: context.t.homeCountriesTitle,
      subtitle: context.t.homeCountriesSubTitle,
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: countries.length,
          padding: const EdgeInsets.symmetric(
            horizontal: kSafeArea,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
          itemBuilder: (context, index) {
            final country = countries[index];
            return Container(
              height: 200,
              width: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/countries/${country.name}.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25),
                    BlendMode.srcATop,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  context.t.countrySubtitle(country.name),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
