# Time spent **14h**

# Plumbus
**Release 1.0.0**
Deployment target iOS: **14.0**

## Project Structure

This repo contains the following targets:

- **Plumbus** (iOS): Main app target
	- API: wrapper over *RickMortySwiftApi*
	- Assets: images, string, plists
	- Characters: views and view model for characters screens
	- Episodes: views and view model for episodes screens
	- Generated: generated assets
	- Model: observable models to store and share app data
	- Playback: views and view models for playback screen
	- Utils: extensions, helper and utils classes and functions

## Installing
Requires Xcode 12.5.
Switch to Xcode version if location is different
```
$ xcode-select -s [path_to_new_xcode]
$ xcode-select -p #to make sure all set
```

To get started pwd into codebase directory and run:

```
$ scripts/configure.sh
$ scripts/install.sh
```

Then open generated Xcode project
```
$ xed .
```

## Code Style
To maintain a consistent code style both
[SwiftFormat](https://github.com/nicklockwood/SwiftFormat) and [SwiftLint](https://github.com/realm/SwiftLint) are run as post-build scripts.

#### 3rd party dependencies

[Kingfisher](https://github.com/onevcat/Kingfisher)
[RickMortySwiftApi](https://github.com/benjaminbruch/Rick-and-Morty-Swift-API)
