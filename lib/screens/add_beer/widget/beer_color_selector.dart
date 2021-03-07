import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BeerColorSelector extends StatefulWidget {
  final FormGroup form;

  const BeerColorSelector({
    required this.form,
  });

  @override
  State createState() => _BeerColorSelectorState();
}

class _BeerColorSelectorState extends State<BeerColorSelector> {
  final beerColors = BeerColor.values;
  BeerColor? selectedColor;

  void _selectBeerColor(BeerColor color) {
    widget.form.control('color').value = color;
    widget.form.control('color').markAsDirty();
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Couleur *',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 12);
              },
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: beerColors.length,
              itemBuilder: (context, index) {
                final beerColor = beerColors[index];
                return BeerColorPreview(
                  beerColor: beerColor,
                  isSelected: selectedColor == beerColor,
                  onTap: () => _selectBeerColor(beerColor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BeerColorPreview extends StatelessWidget {
  final BeerColor beerColor;
  final bool isSelected;
  final VoidCallback onTap;

  const BeerColorPreview({
    required this.beerColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: beerColor.color,
              borderRadius: BorderRadius.circular(42),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: isSelected ? Colors.white : beerColor.color,
              ),
            ),
          ),
          Text(
            '${beerColor.name}',
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ],
      ),
    );
  }
}
