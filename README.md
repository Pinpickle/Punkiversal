# Punkiversal

A Haxe port of the [FlashPunk](http://useflashpunk.net) AS3 library. There are a few additions/differences from the original.

* Builds for Flash, Windows, Mac, Linux, iOS, Android, and Ouya
* Circle/Polygon masks
* Hardware acceleration for native targets
* Joystick and multi-touch input
* Texture atlases for native targets (supports TexturePacker xml)

[![Build Status](https://travis-ci.org/Punkiversal/Punkiversal.png?branch=dev)](https://travis-ci.org/Punkiversal/Punkiversal)

## Release build

First, make sure you have [Haxe](http://haxe.org) 3.0 or higher, we recommend you to update to Haxe 3.1.3 if you haven't already. Then execute the following commands below to get started with your first Punkiversal project.
If you are using Haxe 2 the last version supporting it was [v2.3.0](https://github.com/Punkiversal/Punkiversal/releases/tag/v2.3.0) `haxelib install Punkiversal 2.3.0`.

```bash
haxelib install Punkiversal
haxelib run Punkiversal setup
haxelib run Punkiversal new MyProject # creates a new project
```

## Development build

You need to have ant installed to build a development version of Punkiversal. Make sure you set a default program for swf files to view the debug output. You will also need a C++ compiler for native builds (Xcode, Visual Studio, g++).

```bash
git clone https://github.com/Punkiversal/Punkiversal.git
ant
```

This will install a dev version of Punkiversal through haxelib, run unit tests, and build an example project for flash/neko/native. If you fix an issue, feel free to create a pull request.

Generating documentation is just as simple. Run the commands below to create a new set of docs with haxedoc
The documentation will be located in doc/docs/, simply open doc/docs/index.html with your web browser to see the doc.

```bash
ant doc
```

## Have questions or looking to get involved?

There are a few ways you can get involved with Punkiversal.

*	Drop by the [Punkiversal forum](http://forum.punkiversal.com) to ask a question or show off what you've created.
*	Create an issue or pull request or take part in the discussion.
*	Follow us on Twitter: [@Punkiversal](https://twitter.com/intent/user?screen_name=Punkiversal)

## Credits

*	Chevy Ray Johnston for creating the original FlashPunk.
*	[OpenFL](http://www.openfl.org/) makes native targets possible and simplifies asset management in Flash. Thanks guys!
*	All the awesome people who have [contributed](https://github.com/Punkiversal/Punkiversal/graphs/contributors) to Punkiversal and joined in the discussions on the [forum](http://forum.punkiversal.com).

## MIT License

Copyright (C) 2012-2014 Matt Tuttle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
