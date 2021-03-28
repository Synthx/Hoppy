import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:intl/intl.dart';

class BeerLastCheckIns extends StatelessWidget {
  final List<CheckIn> checkIns;

  const BeerLastCheckIns({
    required this.checkIns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            'Derniers check-ins',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, _) => const Divider(height: 0),
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: checkIns.length,
          itemBuilder: (context, index) {
            final checkIn = checkIns[index];
            return Container(
              height: 80,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  if (checkIn.location != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Text(
                        '${checkIn.location!.icon}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  Text(DateFormat.yMd().format(checkIn.date)),
                  const Spacer(flex: 1),
                  const SizedBox(width: 20),
                  Text('${checkIn.rating} ⭐'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
