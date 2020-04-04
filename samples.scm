(define axiom-3.2 '(= p q q p))
(define axiom-3.3 '(= true q q))
(define axiom-3.8 '(= false (not true)))
(define axiom-3.9 '(= (not (= p q)) (not p) q))
(define axiom-3.24 '(= (or p q) (or q p)))
(define axiom-3.25 '(= (or (or p q) r) (or p (or q r))))
(define axiom-3.26 '(= (or p p) p))
(define axiom-3.27 '(= (or p (= q r)) (or p q) (or p r)))
(define axiom-3.28 '(or p (not p)))
(define axiom-3.35 '(= (and p q) p q (or p q)))
(define axiom-3.57 '(= (imp p q) (or p q) q))

;;; true
(define theorem-3.4
  (equanimity
   (equanimity
    axiom-3.3
    (leibniz axiom-3.3 '(= true x) 'x 'true))
   (substitution axiom-3.3 'q 'true)))

;;; (= q q)
(define theorem-3.5
  (equanimity theorem-3.4 axiom-3.3))

;;; (= (not p) q p (not q))
(define theorem-3.11
  (equanimity
   (equanimity
    (equanimity
     (substitution theorem-3.5 'q '(not (= p q)))
     (leibniz axiom-3.2 '(= (not (= p q)) (not x)) 'x '(= p q)))
    (leibniz axiom-3.9 '(= x (not (= q p))) 'x '(not (= p q))))
   (leibniz
    (substitution
     (substitution
      (substitution axiom-3.9 'p 'x)
      'q 'p)
     'x 'q)
    '(= (not p) q x) 'x '(not (= q p)))))

;;; (= (not (not p)) p)
(define theorem-3.12
  (equanimity
   (substitution theorem-3.11 'p '(not p))
   (leibniz theorem-3.11 '(= (not (not p)) x) 'x 'p)))

;;; (= (or p true) true)
(define theorem-3.29
  (equanimity
   (equanimity
    (substitution
     (substitution axiom-3.27 'q 'p)
     'r 'p)
    (leibniz
     (substitution axiom-3.3 'q 'p)
     '(= (or p x) (or p p) (or p p)) 'x '(= p p)))
   (leibniz
    (substitution axiom-3.3 'q '(or p p))
    '(= (or p true) x) 'x '(= (or p p) (or p p)))))

;;; (= (or p false) p)
(define theorem-3.30
  (equanimity
   (equanimity
    (equanimity
     (equanimity
      (equanimity
       axiom-3.28
       (substitution
        (substitution axiom-3.27 'q 'p)
        'r '(not p)))
      (leibniz axiom-3.26 '(= (or p (= p (not p))) x) 'x '(or p p)))
     (leibniz
      (substitution axiom-3.9 'q 'p)
      '(= (or p x) p) 'x '(= p (not p))))
    (leibniz
     (substitution axiom-3.3 'q 'p)
     '(= (or p (not x)) p) 'x '(= p p)))
   (leibniz axiom-3.8 '(= (or p x) p) 'x '(not true))))

;;; (= (or p q) (or p (not q)) p)
(define theorem-3.32
  (equanimity
   (equanimity
    (equanimity
     (equanimity
      theorem-3.30
      (leibniz axiom-3.8 '(= (or p x) p) 'x 'false))
     (leibniz axiom-3.3 '(= (or p (not x)) p) 'x 'true))
    (leibniz
     (substitution axiom-3.9 'p 'q)
     '(= (or p x) p) 'x '(not (= q q))))
   (leibniz 
    (substitution
     (substitution axiom-3.27 'q '(not q))
     'r 'q)
    '(= x p) 'x '(or p (= (not q) q)))))

;;; de Morgan
;;; (= (not (and p q)) (or (not p) (not q)))
(define theorem-3.47
  (equanimity
   theorem-3.11
   (equanimity
    (equanimity
     (equanimity
      (leibniz axiom-3.35 '(not x) 'x '(and p q))
      (leibniz
       (substitution axiom-3.9 'q '(= q (or p q)))
       '(= (not (and p q)) x) 'x '(not (= p q (or p q)))))
     (leibniz theorem-3.32
              '(= (not (and p q)) (not p) q x) 'x '(or p q)))
    (leibniz
     (equanimity
      (substitution 
       (substitution 
        (substitution theorem-3.32 'p 'x)
        'q 'p)
       'x '(not q))
      (leibniz
       (substitution axiom-3.24 'q '(not q))
       '(= (or (not q) (not p)) x (not q)) 'x '(or (not q) p)))
     '(= (not (and p q)) (not p) q x p) 'x '(or p (not q))))))

;;; (= (imp p q) (or (not p) q))
(define theorem-3.59
  (equanimity
   axiom-3.57
   (leibniz
    (equanimity
     (equanimity
      (substitution
       (substitution
        (substitution theorem-3.32 'p 'x)
        'q 'p)
       'x 'q)
      (leibniz axiom-3.24 '(= (or q (not p)) x q) 'x '(or q p)))
     (leibniz 
      (substitution axiom-3.24 'p '(not p))
      '(= x (or p q) q) 'x '(or q (not p))))
    '(= (imp p q) x) 'x '(= (or p q) q))))
