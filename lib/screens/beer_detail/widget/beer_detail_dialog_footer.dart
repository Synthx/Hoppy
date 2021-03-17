import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/beer_detail/beer_detail.dart';
import 'package:hoppy/screens/screens.dart';

class BeerDetailDialogFooter extends StatelessWidget {
  Future<void> _openNewCheckInDialog(BuildContext context) async {
    final cubit = context.read<BeerDetailCubit>();
    cubit.setHaveNewCheckIn(false);
    final result = await Navigator.push<CheckIn?>(
      context,
      NewCheckInDialog.route(context.read<BeerDetailCubit>().state.beer!),
    );

    if (result != null) {
      cubit.setHaveNewCheckIn(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeerDetailCubit, BeerDetailState>(
      buildWhen: (prev, curr) => prev.beer != curr.beer,
      builder: (context, state) {
        final beer = state.beer;

        if (beer == null) return Container();

        return BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Container(
              height: kFooterButtonHeight,
              child: ElevatedButton(
                onPressed: () => _openNewCheckInDialog(context),
                child: const Text('Check-in'),
              ),
            ),
          ),
        );
      },
    );
  }
}
