Code Generation Compiler
========================

    +--------+         +-----------+        +--------------+
    | schema | --+---> | component | -----> | py-component |
    +--------+   |     +-----------+        +--------------+
                 |                                  |
                 |                                  V
                 |                            +-----------+
                 |                            | py-module | ----> *.py
                 |                            +-----------+
                 |
                 |     +-----------+        +---------------+
                 +---> | component | -----> | c++-component |
                       +-----------+        +---------------+
                                                   |
                                      +------------+-------------+
                                      |                          |
                               +------------+              +------------+
                               | c++-header |              | c++-source |
                               +------------+              +------------+
                                      |                          |
                                      V                          V
                                     *.h                        *.cpp

Each box is a lisp form. Only at the very end is the target language's source
code produced.

Each box is an intermediate language that contains an increasingly
language-specific description of the "component" artifact to be
produced (e.g. a "header file" or a "module").

The C++ portions of the diagram above can be thought of as a set of scheme
functions:

Convert an input schema file into a list of component forms:

```scheme
(define (schema->components schema-file)
  ...
  (component1 component2 ...))
```
Convert a component form into a C++-specific component form:

```scheme
(define (c++-component component)
  ...)
```
Convert a C++-specific component form into a "header" form and a "source" form:

```scheme
(define (c++-files c++-component)
  ...
  (c++-header c++-source))

```
Render a file from a C++-specific-file form:

```scheme
(define (render-c++-header form)
  ...
  "./package_component.h")

(define (render-c++-source form)
  ...
  "./package_component.cpp")
```

So to produce two C++ files for the first type defined in a schema file
`"config.scm"`, a scheme implementation might do the following:

```scheme
(let* ((component (c++-component (first (schema->components "config.scm"))))
       (files (c++-files component))
       (header (first files))
       (source (second files)))
  (render-c++-header header)
  (render-c++-source source))
```
