import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';

import 'beer_filter_constants.dart';

class BeerFilterOther extends StatelessWidget {
  void _havePictureChanged(BuildContext context, bool selected) {
    context.read<SearchCubit>().setHavePictureFilter(selected ? true : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Localization.of(context).beer_filter_others,
            style: beerFilterTitleStyle(context),
          ),
          const SizedBox(height: 20),
          BlocBuilder<SearchCubit, SearchState>(
            buildWhen: (prev, curr) =>
                prev.filter.havePicture != curr.filter.havePicture,
            builder: (context, state) {
              return ListTile(
                title: Text(
                  Localization.of(context).beer_filter_others_picture_title,
                ),
                subtitle: Text(
                  Localization.of(context).beer_filter_others_picture_content,
                ),
                contentPadding: const EdgeInsets.all(0),
                trailing: CupertinoSwitch(
                  value: state.filter.havePicture ?? false,
                  onChanged: (value) => _havePictureChanged(context, value),
                  trackColor: Theme.of(context).backgroundColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
