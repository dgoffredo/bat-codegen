Schema Description DSL
======================

This is a lisp-flavored domain specific language for describing
schemas of BDE-style attribute types (sequences, enumerations,
etc.). It is case sensitive.

package
-------

    (package <name> 
       <included packages>*
       <types>*)

The `package` is the root element of every schema definition.
`<name>` is a (lisp) symbol. `<included packages>` is zero or
more `include-as` forms. `<types>` is zero or more `type` forms.

include-as
----------

    (include-as <name> <file path>)

The `include-as` form includes as part of the current package
the package defined in the file at `<file path>` and makes it
available in the current package as `<name>`. `<name>` is a
symbol and `<file path>` is a string.

For example, to include the package defined in "foo.scm" as
`foo`, use the following form:
```scheme
(include-as foo "foo.scm")
```
If the package defined in "foo.scm" includes a type called
`Security`, then that type is now accessible in the current
package using the symbol `foo/Security`.

type
----

    (type <name> <description>? <definition>)

The `type` form is what you've been looking for. It defines an
attribute type with the symbol `<name>` and optional string
`<description>`. `<definition>` is one of the type definition
forms, defined below.

sequence
--------

    (sequence
      (<name> <type> <description>?)+)

The `sequence` form defines an ordered sequence of one or more
attributes, each having a string `<name>`, a symbol `<type>`,
and an optional string `<description>`.

The `<type>` may be the name of a user-defined type, possibly
qualified by its package name using a forward slash. For
example, if the current package included the package `foo` as
```scheme
(include-as foo "foo.scm")
```
then to specify an attribute named "paste" of type `Toothpaste`
from the `foo` module, use the form
```scheme
("paste" foo/Toothpaste)
```
or perhaps
```scheme
("paste" foo/Toothpaste "don't forget to brush!")
```
A default value may be specified for a `<type>` by replacing
the type symbol with a form containing first the type symbol
and second the default value. For example, if the `text`
attribute `city` defaults to `"New York"`, this is specified by
the form
```scheme
("city" (text "New York"))
```
`<type>` may also be one of the predefined basic types or a type
modifier, in the "Basic Types" and "Type Modifiers" sections,
respectively.

choice
------

    (choice 
      (<name> <type>)+)

The `choice` form describes a selection of exactly one among a
set of named possible types. For example, if the `Http` type
is a choice among "GET," "PUT," "POST," "PATCH," and "DELETE,"
each of which is described by a different type, then the form
describing `Http` might be the following:
```scheme
(type Http
  (choice
    ("GET" Get "read a resource")
    ("PUT" Put "overwrite a resource")
    ("POST" Post "append to a resource")
    ("PATCH" Patch "modify a resource")
    ("DELETE" Delete "remove a resource")))
```
`<name>` is a string and `<type>` is a symbol or form describing
any type.

enumeration
-----------

    (enumeration <value>+)

The `enumeration` form describes a choice among a set of one or
more strings. `<value>` is a string literal or a form containing
a string literal followed by another string literal as
documentation. For example, the primary colors of light:
```scheme
(type PrimaryColor
  (enumeration 
    "red" 
    ("green" "maybe turquoise for traffic lights")
    "blue"))
```
Basic Types
-----------

### text
`text` is a string.

### integer
`integer` is a signed integer. Its width is not specified.

### real
`real` is a floating point signed number. Its width is not
specified.

### date
`date` is a calendar day on a particular year, such as the 24th
of December, 1943.

### time
`time` is a point in time within a day, without specifying the
particular day. It can be thought of as an offset from midnight.

### datetime
`datetime` is a particular point in time relative to some time
zone.

### timeinterval
`timeinterval` is a high precision duration of time.

### datetimeinterval
`datetimeinterval` is the duration elapsed between two
`datetime`s.

Type Modifiers
--------------

A type modifier is a type that is a function of other types.

### optional

An `optional` type may be present in a message adhering to the
schema described, or may otherwise be absent.

    (optional <type>)

`<type>` is a symbol or form describing any type.

For example, the optional `text` attribute "extra" is defined by
the following form:
```scheme
("extra" (optional text))
```
As another example, the attribute "ageUpdate" describing
the possibility that "age" was updated, including the
possibility that it was nullified, might be expressed as an
optional optional integer:
```scheme
("ageUpdate" (optional (optional integer)))
```
### array

An `array` type represents a sequence of zero or more unnamed
values of its argument type:

    (array <type>)

`<type>` is a symbol or form describing any type.

### dictionary

A dictionary is a mapping from one type to another.

    (dictionary <key-type> <mapped-type>)

`<key-type>` is a symbol or form describing any type, as is
`<mapped-type>` a symbol or form describing any type.

For example, a dictionary describing the amount of precipitation
daily might be described by the following form:
```scheme
(dictionary date units/Inches)
```
or perhaps alternatively as an attribute:
```scheme
("rainfallInches" (dictionary date real))
```
Complete Example
----------------
```scheme
(package weather
  (include-as units "units.scm")
  (include-as geo "location.scm")

  (type Response
    (choice
      ("forecast" Forecast)
      ("stats" Stats)))

  (type Forecast
    "A 'Forecast' is blah blah blah..."
    (sequence
      ("station" text
        "the name blah blah blah")
      ("location" geo/Coordinates
        "gps coordinates, yadda yadda")
      ("hourlyTemperature" (array units/Temperature))
      ("precipitation" Precipitation)
      ("extra" (optional text))
      ("language" (text "English"))))

  (type Precipitation
    (enumeration 
      "rain" 
      ("snow" "includes sleet") 
      "hail"))

  (type Stats
    (sequence
      ("wordFrequencies" WordFrequencies "everywhere")
      ("lastUpdateTime" datetime)))

  (type WordFrequencies
    (dictionary text integer)))
```
