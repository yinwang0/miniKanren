#lang racket

(provide run* run exist conde succeed fail == display-code)

(define display-code (lambda (x) (void)))

(include "mk.scm")
