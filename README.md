bat-codegen
===========

BDE Attribute Type Code Generator

Why
---

So I can learn the [scheme][guile] programming language.

What
----

A new lisp-based domain specific language for describing "attribute types" as
defined in the [bdlat][bdlat] package of the [BDE][BDE] project, and a scheme
framework for implementing compilers from the DSL into various programming
languages, including at least C++ and python.

More
----

See the proposal sketches for the [domain specific language](docs/schema.md)
and [code generator](docs/codegen.md).

[guile]: https://www.gnu.org/software/guile/manual/guile.html
[bdlat]: https://github.com/bloomberg/bde/blob/master/groups/bdl/bdlat/doc/bdlat.txt
[BDE]: https://github.com/bloomberg/bde
