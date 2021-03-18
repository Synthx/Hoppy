import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/widget/widget.dart';

import '../beer_detail_cubit.dart';

class BeerActions extends StatelessWidget {
  final Beer beer;

  const BeerActions({
    required this.beer,
  });

  Future<void> _openEditBeerDialog(BuildContext context) async {
    final result = await Navigator.push<Beer?>(
      context,
      EditBeerDialog.route(beer),
    );

    if (result != null) {
      context.read<BeerDetailCubit>().setBeer(result);
    }
  }

  Future<void> _deleteBeer(BuildContext context) async {
    final result = await showCupertinoDialog<bool?>(
      context: context,
      builder: (_) => ConfirmActionDialog(
        content:
            'Cette action est irréversible, êtes-vous sur de vouloir continuer ?',
      ),
    );

    if (result != null && result) {
      await context.read<BeerDetailCubit>().delete(beer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        children: [
          Flexible(
            child: _RoundedButton(
              iconData: Icons.edit,
              color: Theme.of(context).textTheme.bodyText2!.color!,
              onTap: () => _openEditBeerDialog(context),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: _RoundedButton(
              iconData: Icons.delete,
              color: Colors.red,
              onTap: () => _deleteBeer(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;
  final Color color;

  const _RoundedButton({
    required this.iconData,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: BorderSide(
          color: color,
        ),
      ),
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }
}
