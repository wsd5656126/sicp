(load "./ex1.21-smallest-divisor.scm")
(define (timed-prime-test n)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (display start-time)
  (if (prime? n)
      (report-prime (- (runtime)
                       start-time))))

(define (report-prime elapsed-time)
  (display "***")
  (newline)
  (display elapsed-time))

(define (search-for-primes min)
  (search-for-primes-odd (if (even? min)
                             (+ min 1)
                             min)))

(define (search-for-primes-odd odd)
  (if (prime? odd)
      (timed-prime-test odd)
      (search-for-primes-odd (+ odd 2))))

(search-for-primes 199)
(search-for-primes 1999)
(search-for-primes 19999)

