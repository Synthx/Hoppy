<p align="center">
    <img src="assets/images/logo.png" title="Hoppy" alt="Hoppy logo">
</p>

# Hoppy

Hoppy is a personal project aiming to provide statistics about my drunken beers, follow my consummation, my most drunken
one, the style I love, etc...

So I decided to share my work and hope someone will enjoy it.

## About

I try to develop Hoppy as cleaner and efficient as possible with all I learn about Flutter and app development.

Feel free to send me messages or create pull requests if you think I could ameliorate my code. You can also send message
if you have a good functionality I can develop.

Hoppy is a standalone app, it means that it's not require any internet connection to work, all your data are stored
inside your localstorage.

## Key features

* Search beers
* Favorites
* Add / edit / delete beer
* Obtain statistics about drunken beers (number, type / color repartition, average degree, etc...)
* Dark mode

## Future features

* Check-in location
* Beer detailed more statistics
* Change application language
* On board screen
* Simple legal age verification
* Change statistics range
* Give idea form
* Online beer / check-in attributes management
* Online beers management
* Authentication
* Poll

## Main development concepts used

* Dependency Injection - Using [GetIt](https://pub.dev/packages/get_it) package
* StateManagement - Using [Bloc](https://bloclibrary.dev/#/) library
* Internationalization & Translation - Using recommended [Intl](https://pub.dev/packages/intl) package
* Unit tests - Using [Mockito](https://pub.dev/packages/mockito) and flutter test packages
* Continuous deployment - Using Github actions running code checking
* Personal error handler - Heavily inspired by [Catcher](https://pub.dev/packages/catcher) package

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

Hoppy include internalization and localization, that mean that Hoppy can be translated into different language, we use
official intl package to handle translations, translation file are automatically generated when launching / building app
from lib/i10n/intl_*.arb files, if you don't want to automatically generate these files, please change this line into
pubspec.yaml :

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
