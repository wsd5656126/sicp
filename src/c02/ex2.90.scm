;; 多项式系统.对稠密多项式和稀疏多项式都非常有效


(define t-list (the-empty-termlist))
(first-term (adjoin-term (make-term 2 3)
                         (adjoin-term (make-term 1 -2)
                                      (adjoin-term (make-term 0 -5) t-list))))

;; 稀疏
(define (install-sparse-term-package)
  (define (=zero? coe)
    (if (= coe 0)
        true
        false))
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (the-empty-termlist)
    '())
  (define (empty-termlist? term-list)
    (null? term-list))
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))
  (define (tag x) (attach-tag 'sparse x))
  (define (tag-list lst) (attach-tag 'sparse-list lst))

  (put 'adjoin-term '(sparse sparse-list)
       (lambda (term term-list)
         (tag-list (adjoin-term term term-list))))
  (put 'the-empty-termlist 'sparse
       (lambda () (tag-list (the-empty-termlist))))
  (put 'empty-termlist? '(sparse-list)
       (lambda (lst) (empty-termlist?)))
  (put 'first-term '(sparse-list)
       (lambda (lst) (tag (first-term lst))))
  (put 'rest-terms '(sparse-list)
       (lambda (lst) (tag (rest-terms lst))))
  (put 'make-from-sparse 'term
       (lambda (order coeff) (tag (make-term order coeff))))
  (put 'order '(sparse) order)
  (put 'coeff '(sparse) coeff)
  'done)
(define sparse-term-package (install-sparse-term-package))



(define (install-dense-term-package)
  ;; 稠密
  (define (adjoin-term term term-list)
    (cons (coeff term) term-list))
  (define (the-empty-termlist) '())
  (define (first-term term-list)
    (make-term (- (length term-list) 1) (car term-list)))
  (define (rest-terms term-list)
    (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))

  (define (make-term order coeff)
    (cons order coeff))
  (define (order term)
    (car term))
  (define (coeff term)
    (cdr term))
  (define (tag x) (attach-tag 'dense x))
  (define (tag-list lst) (attach-tag 'dense-list lst))

  (put 'adjoin-term '(dense dense-list)
       (lambda (term term-list)
         (tag-list (adjoin-term term term-list))))
  (put 'the-empty-termlist 'dense
       (lambda () (tag-list (the-empty-termlist))))
  (put 'empty-termlist? '(dense-list)
       (lambda (lst) (empty-termlist?)))
  (put 'first-term '(dense-list)
       (lambda (lst) (tag (first-term lst))))
  (put 'rest-terms '(dense-list)
       (lambda (lst) (tag (rest-terms lst))))
  (put 'make-from-dense 'term
       (lambda (order coeff) (tag (make-term order coeff))))
  (put 'order '(dense) order)
  (put 'coeff '(dense) coeff)
  'done)
(define dense-term-package (install-dense-term-package))

(define (make-from-dense order coeff)
  ((get 'make-from-dense 'term) order coeff))
(define (make-from-sparse order coeff)
  ((get 'make-from-sparse 'term) order coeff))
(define (order term)
  (apply-generic 'order term))
(define (coeff term)
  (apply-generic 'coeff term))

(define (adjoin-term term term-list)
  (apply-generic 'adjoin-term term term-list))
(define (the-empty-termlist-from-sparse)
  ((get 'the-empty-termlist 'sparse)))
(define (the-empty-termlist-from-dense)
  ((get 'the-empty-termlist 'dense)))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))

(define ss1 (make-from-sparse 0 10))
(adjoin-term ss1 (adjoin-term (make-from-sparse 1 9)
                             (the-empty-termlist-from-sparse)))
(define dt1 (make-from-dense 0 10))
(adjoin-term dt1 (adjoin-term (make-from-dense 1 9)
                              (the-empty-termlist-from-dense)))