(define (delete1 x xs)
  (cond ((null? xs) 
         (error "not found" x))
        ((equal? x (car xs))
         (cdr xs))
        (else
         (cons (car xs)
               (delete1 x (cdr xs))))))

;; (delete1 2 '(0 1 2 3 4 5 2 6))
;; (delete1 9 '(0 1 2 3 4 5 2 6))

(define (consume bag1 bag2)
  (if (null? bag2)
      bag1
      (consume (delete1 (car bag2) bag1) (cdr bag2))))

;; (consume '(a b c p p d) '(p c d))

(define (equiv-expr? x)
  (and (pair? x) (eq? (car x) '=)))

(define (flatten-equiv x)
  (if (equiv-expr? x)
      (let ((r (append-map
                 (lambda (y)
                   (let ((z (flatten-equiv y)))
                     (if (equiv-expr? z)
                         (cdr z)
                         (list z))))
                 (cdr x))))
        (if (null? (cdr r))
            (car r)
            (cons '= r)))
      x))

;; (flatten-equiv '(= (= a b) c))
;; (flatten-equiv '(= p))
;; (flatten-equiv '(or p (not p)))

;;; theorem ==> theorem[var := expr]
(define (substitution theorem var expr)
  (flatten-equiv
   (cond ((eq? theorem var) expr)
         ((pair? theorem)
          (cons (substitution (car theorem) var expr)
                (substitution (cdr theorem) var expr)))
         (else theorem))))

;; (substitution '(= (not (= p q)) (not p) q) 'q 'p)

;;; P, P = Q ==> Q
(define (equanimity P theorem)
  (if (equiv-expr? theorem)
      (flatten-equiv
       (cons '= 
             (consume
              (cdr theorem)
              (if (and (pair? P) (eq? (car P) '=))
                  (cdr P)
                  (list P)))))
      (error "theorem must be an equation" theorem)))

;; (equanimity 'p '(= p true))
;; (equanimity '(= q r) '(= p q r s))

;;; P = Q ==> expr[var:=P] = expr[var:=Q]
(define (leibniz theorem expr var P)
  (let ((Q (equanimity P theorem)))
    (flatten-equiv
     (list '= 
           (substitution expr var P)
           (substitution expr var Q)))))

;; (leibniz '(= a b c d) '(or p (not p)) 'p 'b)
;; (leibniz '(= a b c d) '(or p (not p)) 'p '(= c a))
;; (leibniz '(= a b c d) '(or p (not p)) 'p '(= b d c))
