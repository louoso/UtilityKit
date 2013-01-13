# UtilityKit

UtilityKit is a library containing code that is useful across projects. It is licensed under the Apache License, Version 2.0.

## Functional Collections

Categories found under f(x) contain functional extensions to common data structures.

* Map
* Reduce
* Filter
* Create from a generator function

Additionally, UKFunctions.h contains methods that allow for map and filter composition.

## Encoders

Categories found under net contain categories for encoding & decoding text.

* Base64
* Url
* ISO8601

## Model

Boilerplate implementations for objects composed using properties.

* isEqual
* hash
* description
* copyWithZone

## Other

* Easy hash from NSData

## Getting Started

* The best instructions are available [here](http://www.amateurinmotion.com/articles/2009/02/08/creating-a-static-library-for-iphone.html)
* To use the Categories contained in libUtilityKit you must add -all_load under "Other Linker Flags". For more information see [Technical Q&A QA1490](https://developer.apple.com/library/mac/#qa/qa1490/_index.html).
