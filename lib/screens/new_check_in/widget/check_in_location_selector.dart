import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInLocationSelector extends StatefulWidget {
  final FormGroup form;

  const CheckInLocationSelector({
    required this.form,
  });

  @override
  State createState() => _CheckInLocationSelectorState();
}

class _CheckInLocationSelectorState extends State<CheckInLocationSelector> {
  CheckInLocation? _selectedLocation;

  void _selectServingStyle(CheckInLocation location) {
    widget.form.control('location').value = location;
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locations = CheckInLocation.values;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Text(
              "Location",
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
                return SizedBox(width: 15);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return _CheckInLocationPreview(
                  location: location,
                  isSelected: _selectedLocation == location,
                  onTap: () => _selectServingStyle(location),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckInLocationPreview extends StatelessWidget {
  final CheckInLocation location;
  final bool isSelected;
  final VoidCallback onTap;

  const _CheckInLocationPreview({
    required this.location,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).textTheme.bodyText2!.color!;
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Center(
          child: Text(
            '${location.name}',
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
