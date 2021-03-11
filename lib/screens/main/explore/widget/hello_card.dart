import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/store/store.dart';

class HelloCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (prev, curr) => prev.value.name != curr.value.name,
            builder: (context, state) {
              if (state.value.name == null) {
                return Text(
                  'Explorer',
                  style: Theme.of(context).textTheme.headline5,
                );
              }

              return Text(
                'Bienvenue ${state.value.name}',
                style: Theme.of(context).textTheme.headline5,
              );
            },
          ),
          const SizedBox(height: 5),
          Text(
            'Alors, on boit quoi aujourd\'hui ?',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
