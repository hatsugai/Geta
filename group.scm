(define axiom-group-assoc '(= (* (* x y) z) (* x (* y z))))
(define axiom-group-right-identity '(= (* x e) x))
(define axiom-group-right-inverse '(= (* x (r x)) e))

(define theorem-left-identity
  (equanimity
   (equanimity
    (equanimity
     (equanimity
      (equanimity
       (equanimity
        (equanimity
         (equanimity
          (equanimity
           (equanimity
            (leibniz axiom-group-right-identity '(* e x) 'x '(* x e))
            (leibniz axiom-group-right-inverse '(= (* P (* x e)) (* e x)) 'P 'e))
           (leibniz
            (substitution axiom-group-right-inverse 'x '(r x))
            '(= (* (* x (r x)) (* x P)) (* e x)) 'P 'e))
          (leibniz
           (substitution
            (substitution axiom-group-assoc 'y '(r x))
            'z '(r (r x)))
           '(= (* (* x (r x)) P) (* e x)) 'P '(* x (* (r x) (r (r x))))))
         (leibniz
          axiom-group-right-inverse
          '(= (* (* x (r x)) (* P (r (r x)))) (* e x)) 'P '(* x (r x))))
        (leibniz
         (substitution
          (substitution
           (substitution
            axiom-group-assoc 'x '(* x (r x)))
           'y 'e)
          'z '(r (r x)))
         '(= P (* e x)) 'P '(* (* x (r x)) (* e (r (r x))))))
       (leibniz
        (substitution
         (substitution
          axiom-group-assoc 'y '(r x))
         'z 'e)
        '(= (* P (r (r x))) (* e x)) 'P '(* (* x (r x)) e)))
      (leibniz
       (substitution axiom-group-right-identity 'x '(r x))
       '(= (* (* x P) (r (r x))) (* e x)) 'P '(* (r x) e)))
     (leibniz
      (substitution
       (substitution
        axiom-group-assoc 'y '(r x))
       'z '(r (r x)))
      '(= P (* e x)) 'P '(* (* x (r x)) (r (r x)))))
    (leibniz
     (substitution axiom-group-right-inverse 'x '(r x))
     '(= (* x P) (* e x)) 'P '(* (r x) (r (r x)))))
   (leibniz axiom-group-right-identity '(= P (* e x)) 'P '(* x e))))
