;; 13 Задание
;; Реализовть вычисление функции с помощью хвостовой рекурсии и нехвостовой.
;; Вариант: Вычисление элемента ряда фибоначчи; Вычисление факториала числа.

;; sbcl
;; (LOAD "/home/eduard/Projects/iu7/LISP_v1/2.Task1/3.tasks3.lsp")


;; Ряд фибоначчи
;; Нехвостовая рекурсия
(defun fibonacci-non-tail (n)
  (if (<= n 1)
      n
      (+ (fibonacci-non-tail (- n 1))
         (fibonacci-non-tail (- n 2)))))

;; Ряд фибоначчи
;; Хвостовая рекурсия
(defun fibonacci-tail (n)
  (labels ((fib-helper (a b count) ;; локальные функции
             (if (= count 0)
                 a
                 (fib-helper b (+ a b) (- count 1)))))
    (fib-helper 0 1 n)))

;; Факториал
;; Нехвостовая рекурсия
(defun factorial-non-tail (n)
  (if (<= n 1)
      1
      (* n (factorial-non-tail (- n 1)))))

;; Факториал
;; Хвостовая рекурсия
(defun factorial-tail (n)
  (labels ((fact-helper (n acc) 
             (if (<= n 1)
                 acc
                 (fact-helper (- n 1) (* n acc)))))
    (fact-helper n 1)))


;; Пример вызова
;; Нехвостовая рекурсия
;; (fibonacci-non-tail 10)  ; Вернет 55
;; (factorial-non-tail 5)    ; Вернет 120

;; Хвостовая рекурсия
;; (fibonacci-tail 10)       ; Вернет 55
;; (factorial-tail 5)        ; Вернет 120