;Задача
;работу функций mapcar и reduce. Реализуйте:
;+ векторное произведение;
;+ декартово произведение;
;+ перевод из N-ричной системы счисления в 10-чную;

; Векторное произведение
(defun vector-product (vec1 vec2)
  (if (and (= (length vec1) (length vec2))
           (not (zerop (length vec1))))
      (mapcar #'* vec1 vec2)
      (error "Вектор не должен быть нулевым")))

(let ((vector1 '(1 2 3))
      (vector2 '(4 5 6)))
  (print (vector-product vector1 vector2)))

; => (4 10 18)

; Декартово произведение
(defun cartesian-product (list1 list2)
  (apply 'append
         (mapcar (lambda (x)
                     (mapcar (lambda (y) (list x y)) list2))
                  list1)))
;; Пример декартова произведения
(print (cartesian-product '(1 2) '(3 4))) 
; => ((1 3) (1 4) (2 3) (2 4))

; Перевод из N-ричной системы счисления в 10-чную
(defun n-ary-to-decimal (n digits)
  (let ((length (length digits))) 
    (reduce (lambda (acc digit)
              (+ acc (* digit (expt n (1- length)))))
            digits
            :initial-value 0)))

(print (n-ary-to-decimal 2 '(1 0 1)))
; => 5

(print (n-ary-to-decimal 3 '(1 0 2)))
; => 11


(defun n-ary-to-decimal (n-ary base)
  (reduce (lambda (acc digit)
            (+ (* acc base) digit))
          n-ary
          :initial-value 0))

;; Example usage:
(print (n-ary-to-decimal '(1 0 1) 2) )


