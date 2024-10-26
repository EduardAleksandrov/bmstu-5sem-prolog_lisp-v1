;Задача
;работу функций mapcar и reduce. Реализуйте:
;+ векторное произведение;
;+ декартово произведение;
;+ перевод из N-ричной системы счисления в 10-чную;

; Векторное произведение 
(defun vector-cross-product (v1 v2)
  (let* ((components (mapcar 'list v1 v2))
         (x1 (nth 0 (nth 0 components)))
         (y1 (nth 0 (nth 1 components)))
         (z1 (nth 0 (nth 2 components)))
         (x2 (nth 1 (nth 0 components)))
         (y2 (nth 1 (nth 1 components)))
         (z2 (nth 1 (nth 2 components))))
    (list (- (* y1 z2) (* z1 y2))
          (- (* z1 x2) (* x1 z2))
          (- (* x1 y2) (* y1 x2)))))
;; Пример векторного произведения
(print (vector-cross-product '(1 2 3) '(4 5 6))) ; => (-3 6 -3)


; Декартово произведение
(defun cartesian-product (list1 list2)
  (apply 'append
         (mapcar (lambda (x)
                     (mapcar (lambda (y) (list x y)) list2))
                  list1)))
;; Пример декартова произведения
(print (cartesian-product '(1 2) '(3 4))) ; => ((1 3) (1 4) (2 3) (2 4))


; Перевод из N-ричной системы счисления в 10-чную
(defun n-ary-to-decimal (digits base)
  (reduce #'+
          (mapcar (lambda (digit index)
                    (* digit (expt base index)))
                  (reverse digits) ; Reverse to get the correct powers
                  (loop for i from 0 below (length digits) collect i))))
; Пример перевода из N-ричной в 10-ую
(print (n-ary-to-decimal '(1 0 1) 2)) ; => 5
(print (n-ary-to-decimal '(15 0 1) 16)) ; => 3841

; Перевод из N-ричной системы счисления в 10-чную
(defun n-ary-to-decimal (digits base)
  (reduce #'+
          (mapcar (lambda (digit index)
                    (let ((value (case digit
                                        (#\0 0) (#\1 1) (#\2 2) (#\3 3)
                                        (#\4 4) (#\5 5) (#\6 6) (#\7 7)
                                        (#\8 8) (#\9 9) (#\A 10) (#\B 11)
                                        (#\C 12) (#\D 13) (#\E 14) (#\F 15)
                                        (t (error "Character ~A is not supported." digit)))))
                      (* value (expt base index))))
                  (reverse digits) ; Reverse to get the correct powers
                  (loop for i from 0 below (length digits) collect i))))

; Пример перевода из N-ричной в 10-ую
(print (n-ary-to-decimal '(#\A #\F) 16)) ; => 175
(print (n-ary-to-decimal '(#\1 #\0) 2)) ; => 2
