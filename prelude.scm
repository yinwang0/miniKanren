(define all-member
  (lambda (ls1 ls2)
    (cond
      [(null? ls1) #t]
      [(member (car ls1) ls2)
       (all-member (cdr ls1) ls2)]
      [else #f])))

(define set-equal?
  (lambda (ls1 ls2)
    (cond
      [(and (list? ls1) (list? ls2))
       (and (all-member ls1 ls2)
            (all-member ls2 ls1))]
      [else
       (equal? ls1 ls2)])))

(define-syntax test-check
  (syntax-rules ()
    ((_ title tested-expression expected-result)
     (begin
       (printf "Testing ~s\n" title)
       (let* ((expected expected-result)
              (produced tested-expression))
         (or (set-equal? expected produced)
             (errorf 'test-check
               "Failed: ~a\nExpected: ~a\nComputed: ~a\n"
               'tested-expression expected produced)))))))

;;;  Max fuel for engines
(define max-ticks 10000000)

(define-syntax test-divergence
  (syntax-rules ()
    ((_ title tested-expression)
     (begin
       (printf "Testing ~s (engine with ~s ticks fuel)\n" title max-ticks)
       ((make-engine (lambda () tested-expression))
        max-ticks
        (lambda (t v)
	  (error title "infinite loop returned ~s after ~s ticks" v (- max-ticks t)))
        (lambda (e^) (void)))))))

