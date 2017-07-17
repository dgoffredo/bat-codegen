(use-modules (ice-9 match))

(define (is-package form)
  (match form
    ((package name (import-as _ ...) _ ...) "with import")
    ((package name _ ...) "without import")))

