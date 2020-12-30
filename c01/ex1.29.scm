;;deps on sum
(define (integeral-sum a b)
  (define n 1000)
  (define h (/ (- b a) n))
  (define (now-x k)
    (+ a
       (* k h)))
  (define (term k)
    (cond ((or (= k 0) (= k n)) (cube (now-x k)))
	  (2 * (+ 1 (remainder k 2)) (cube (now-x k)))))
  (* (/ h 3) (sum term 0 1+ n)))

(integeral-sum 0 1.0)
