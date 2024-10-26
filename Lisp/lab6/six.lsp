;; 12 Задание
;; Написать необходимые функции для решения квадратного уравнения с использованием:
;; + только and и or
;; + только if
;; + только cond
;; учесть множество комплексных чисел

;; Работает


;; sbcl
;; (LOAD "/home/eduard/Projects/iu7/LISP_v1/2.Task1/2.1.task2.lsp")


(defun quadratic-solve-and-or (a b c)
;; Расчет дискриминанта по формуле D = b^2 - 4ac
  (let* ((discriminant (+ (* b b) (* -4 a c)))
      ;; Расчет real part корней
         (real-part (/ (- b) (* 2 a)))
      ;; Расчет мнимой части корней
         (imaginary-part (sqrt (abs discriminant))))
      ;; Проверка на валидность коэффициентов
    (if (or (= a 0) (and (= b 0) (= c 0)))
        (error "Невалидные коэффициенты: a, b, и c")
      ;; проверка если дискриминант положительный, то два корня
        (if (and (> discriminant 0) (not (= a 0)))
            (list (+ real-part (/ imaginary-part (* 2 a))) ; x1 = (-b + sqrt(D)) / (2a)
                  (- real-part (/ imaginary-part (* 2 a))) ; x2 = (-b - sqrt(D)) / (2a)
                  )
            ;; проверка если дискриминант равен нулю, то один корень
            (if (= discriminant 0)
                (list real-part) ; x = -b / (2a)
            ;; если дискриминант отрицательный, то комплексные корни
                (list (complex real-part (/ imaginary-part 2)) ;; x1 = real + i*imaginary
                      (complex real-part (/ (- imaginary-part) 2))))))))  ;; x2 = real - i*imaginary



(defun quadratic-solve-if (a b c)
;; Расчет дискриминанта по формуле  D = b^2 - 4ac
  (let* ((discriminant (+ (* b b) (* -4 a c)))
      ;; Расчет real part корней
         (real-part (/ (- b) (* 2 a)))
      ;; CРасчет мнимой части корней
         (imaginary-part (sqrt (abs discriminant))))
      ;; Check for invalid coefficients
    (if (or (= a 0) (and (= b 0) (= c 0)))
        (error "Невалидные коэффициенты: a, b, и c")
        ;; проверка если дискриминант положительный, то два корня
        (if (> discriminant 0)
            (list (+ real-part (/ imaginary-part (* 2 a))) ; x1 = (-b + sqrt(D)) / (2a)
                  (- real-part (/ imaginary-part (* 2 a))) ; x2 = (-b - sqrt(D)) / (2a)
                  )
            ;; проверка если дискриминант равен нулю, то один корень
            (if (= discriminant 0)
                (list real-part) ; x = -b / (2a)
                ;; если дискриминант отрицательный, то комплексные корни
                (list (complex real-part (/ imaginary-part 2)) ; x1 = real + i*imaginary
                      (complex real-part (/ (- imaginary-part) 2)))))))) ; x2 = real - i*imaginary


(defun quadratic-solve-cond (a b c)
  (let* ((discriminant (+ (* b b) (* -4 a c)))
         (real-part (/ (- b) (* 2 a)))
         (imaginary-part (sqrt (abs discriminant))))
    (cond
      ;; Проверка на валидность коэффициентов
      ((or (= a 0) (and (= b 0) (= c 0))) 
       (error "Невалидные коэффициенты"))
      ;; Два реальных корня
      ((> discriminant 0) 
       (list (+ real-part (/ imaginary-part 2))
             (- real-part (/ imaginary-part 2))))
      ;; Один реальный корень
      ((= discriminant 0) 
       (list real-part))
      ;; Два комплексных корня
      (t 
       (list (complex real-part (/ imaginary-part 2))
             (complex real-part (/ (- imaginary-part) 2)))))))

;; Пример вызова
;; (quadratic-solve-and-or 1 -3 2)       ; Корни: 2 и 1
;; (quadratic-solve-if 1 -3 2)           ; Корни: 2 и 1
;; (quadratic-solve-cond 1 -3 2)         ; Корни: 2 и 1
