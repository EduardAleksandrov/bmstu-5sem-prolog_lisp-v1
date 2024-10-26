;; 11 Задание
;; Составить описание в виде списковых ячеек заданного по варианту списка. 
;; Написать функции создания списка заданной структуры (по варианту) тремя способами:
;; с помощью только cons
;; с помощью только list
;; с помощью только quote
;;  (1 (2 3 (4) 5) 6 ((7)) (8) (9 0))

;; sbcl
;; (LOAD "/home/eduard/Projects/iu7/LISP_v1/2.Task1/1.task1.lsp")


(defun my-list-cons () (cons 1 
                        (cons (cons 2 
                                (cons 3 
                                    (cons (cons 4 nil) 
                                          (cons 5 nil))) )
                          (cons 6 
                                (cons (cons (cons 7 nil) nil) 
                                      (cons (cons 8 nil) 
                                            (cons (cons 9 
                                                        (cons 0 nil)) 
                                                  nil)))))))

(defun my-list-list () (list 1 
                    (list 2 3 (list 4) 5) 
                    6 
                    (list (list 7)) 
                    (list 8) 
                    (list 9 0)))


(defun my-list-quote () '(1 (2 3 (4) 5) 6 ((7)) (8) (9 0)))