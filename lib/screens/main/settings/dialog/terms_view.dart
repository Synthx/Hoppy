import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';

class TermsView extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => TermsView(),
      );

  void _back(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).settings_terms),
        leading: IconButton(
          onPressed: () => _back(context),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localization.of(context).settings_terms_definition_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_definition_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_presentation_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_presentation_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_object_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_object_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_access_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_access_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_property_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_property_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_responsibility_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_responsibility_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_data_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_data_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_link_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_link_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_language_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_language_content,
              ),
              const SizedBox(height: 40),
              Text(
                Localization.of(context).settings_terms_right_title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                Localization.of(context).settings_terms_right_content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
