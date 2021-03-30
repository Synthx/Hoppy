import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/beer_detail/beer_detail.dart';
import 'package:intl/intl.dart';

class BeerDetailDialogBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeerDetailCubit, BeerDetailState>(
      buildWhen: (prev, curr) => prev.beer != curr.beer,
      builder: (context, state) {
        if (state.beer == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final beer = state.beer!;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kFooterButtonHeight + 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeerImage(
                  beer: beer,
                ),
                const SizedBox(height: 40),
                BeerInformation(
                  beer: beer,
                ),
                const SizedBox(height: 20),
                BeerStatistic(
                  beer: beer,
                ),
                const SizedBox(height: 20),
                BeerActions(
                  beer: beer,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Localization.of(context).creation_date(
                            DateFormat.yMd().format(beer.creationDate)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Localization.of(context).last_modified_date(
                            DateFormat.yMd().format(beer.lastModifiedDate)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
