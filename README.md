# Hoppy

Hoppy is a personal project aiming to provide statistics about beer.

## About

I try to develop Hoppy as cleaner and efficient as possible with all I learn about Flutter.

Feel free to send me messages or create pull requests if you think I could do better.

## Key features

## Main development concepts used

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Installation

```
flutter pub get
```

### File generation

We used some external libraries to help us, and you need to execute these command before using Hoppy locally :

#### Freezed and JsonSerializable

```bash
flutter packages pub run build_runner build
```

#### Internalization

Hoppy include internalization and localization, that mean that Hoppy can be translated into different language, we use official intl package to handle translations, translation file are automatically generated when launching / building app from lib/i10n/intl_*.arb files, if you don't want to automatically generate these files, please change this line into pubspec.yaml :

```yaml
flutter:
  generate: true
```

to `false`, and generate translation files with :

```bash

```

## Build

### iOS

To build iOS version, please use the following command :

```bash
flutter build ipa --no-sound-null-safety
```

It will create the application archive located in `build/ios/archive/MyApp.xcarchive` 

## License
