import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInServingStyleSelector extends StatefulWidget {
  final FormGroup form;

  const CheckInServingStyleSelector({
    required this.form,
  });

  @override
  State createState() => _CheckInServingStyleSelectorState();
}

class _CheckInServingStyleSelectorState
    extends State<CheckInServingStyleSelector> {
  ServingStyle? _selectedServingStyle;

  void _selectServingStyle(ServingStyle servingStyle) {
    widget.form.control('servingStyle').value = servingStyle;
    setState(() {
      _selectedServingStyle = servingStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final servingStyles = ServingStyle.values;
    return Container(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Style *",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: servingStyles.length,
              itemBuilder: (context, index) {
                final servingStyle = servingStyles[index];
                return _CheckInServingStylePreview(
                  servingStyle: servingStyle,
                  isSelected: _selectedServingStyle == servingStyle,
                  onTap: () => _selectServingStyle(servingStyle),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckInServingStylePreview extends StatelessWidget {
  final ServingStyle servingStyle;
  final bool isSelected;
  final VoidCallback onTap;

  const _CheckInServingStylePreview({
    required this.servingStyle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyText2!.color;
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color!,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Center(
          child: Text(
            '${servingStyle.name}',
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
