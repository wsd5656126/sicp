;; 带点尾部记法: 最后一个前面带点为任意个数实际参数(body当成list处理)
;; (define (f x y . z) <body>)
;;         (f 1 2 3 4 5 6) z:(3 4 5 6)
;; (define (g . w) <body>)
;;         (g 1 2 3 4) w:(1 2 3 4)

;; 写出same-parity过程,以一个或多个整数为参数,返回所有与第一个参数相同奇偶性的表
;; (same-parity 1 2 3 4 5 6 7) -> (1 3 5 7)
;; (same-parity  2 3 4 5 6 7) -> (2 4 6)
(same-parity 1 2 3 4 5 6 7)
(same-parity  2 3 4 5 6 7)
(define (same-parity . w)
  (define (remain x) (remainder x 2))
  (define first-remain (remain (car w)))
  (define (iter tmp)
    (cond ((null? tmp) ())
          ((= (remain (car tmp)) first-remain) (cons (car tmp) (iter (cdr tmp))))
          (else (iter (cdr tmp)))))
  (iter w))

;; 改进
;; 1. 检查第一个参数奇偶性
(odd? 10)
;; 2. 检查所有参数,保留和第一个奇偶相同的参数
(filter lst)

(define (same-parity sample . others)
  (filter (if (even? sample)
              even?
              odd?)
          (cons sample others)))
