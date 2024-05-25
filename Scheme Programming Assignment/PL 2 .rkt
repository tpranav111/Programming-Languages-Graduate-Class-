'---Q1
;Base Case: If L is empty, return 0
;Assumption: (count-numbers M) returns a count of the numbers in M, for
;any list M smaller than L (including (car L) and (cdr L)).
;Recursive logic: Check if the first element in the input (car L) a list or a number.
;If its a list, make recursive call to the function with the sub-lists : (car L) and (cdr L) as parameter and add the individual number count returned
;else if (car L) is a number, add 1 and make recursive call to (cdr L) 

(define (count-numbers L)
  (cond ((null? L) 0)
        ((list? (car L)) ( + (count-numbers (car L)) (count-numbers (cdr L)))
         )
        (else (if (number? (car L)) (+ 1 (count-numbers (cdr L))) (+ 0 (count-numbers (cdr L))))
         )
   )
 )

(count-numbers '(11 (22 (a 33 44) 55) (6 (b 7 8 (9 c) 100 d))))

;-----------------------------------------------------------------
'---Q2
; Base case: L is empty, return the input 'x' as a list
; Assumption: (insert x M) inserts number x in M, for
; any list M smaller than L (including (car L) and (cdr L)).
;Recursion logic: if (car L)  is greater than input x, insert x at current position in the list.
; else make a recursive insert with the remaining list (cdr L) and cons it to first part of the list i.e. (car L)

(define (insert x L)
  (cond ((null? L) (list x) )
   ( (> (car L) x) (cons x L)
  )
  (else (cons  (car L) (insert x (cdr L) )))
  ))

(insert 5 '(1 2 3 4 6 7 8))

;----------------------------------------------------------------
'---Q3
; Base case: If input list L is null, return sorted list M
; Recursion logic: Extract one element at a time using (car L) and insert (using insert proc) it in the sorted list M, return M.
; Simultaneously, make recursive insert-all call for the remaining list (cdr L) with the returned sorted list M

(define (insert-all L M)
  (cond ((null? L) M)
  ( else (insert-all (cdr L) (insert (car L) M))
    )
  )
)

(insert-all '(2 4) '(1 3 5))
(insert-all '(3 6 1 5 2 7 4) '())

;-----------------------------------------------------------------
'---Q4
; Base case; If L is empty, return empty list
; Assumption: procedure insert returns a sorted list for any list M smaller than L (including (car L) & (cdr L))
; Logic: in the insert proc:-if (car L)  is greater than input x, insert x at current position in the list.
; else make a recursive insert with the remaining list (cdr L) and cons it to first part of the list i.e. (car L)
; in the insert-all: Extract one element at a time using (car L) and insert (using insert proc) it in the sorted list M, return M.
; Simultaneously, make recursive insert-all call for the remaining list (cdr L) with the returned sorted list M
; Finally make a call to insert-all function passing the input list and empty list as parameter.
; It recursively updates M until L becomes empty and all elements of L and inserted in M

(define (sort L)
  (letrec ((insert (lambda(x M)
               (cond ((NULL? M) (list x))
                     (( <= x (car M)) (cons x M))
                      (else (cons (car M) (insert x (cdr M)))))))
           (insert-all (lambda (L M)
                (cond ((NULL? L) M)
                      (else (insert-all (cdr L) (insert (car L) M)))))))
    (insert-all L '())))

(sort '(99 3 6 1 5 2 7 4))

;-----------------------------------------------------------------
'---Q5

(define (translate op)
  ( cond ((eq? op '+) +)
         ((eq? op '-) -)
         ((eq? op '*) *)
         ((eq? op '/) /)
  )
 )
(translate '-)
((translate '*) 3 4)

;-----------------------------------------------------------------
'---Q6
; Base case: If L is null, return L
; Recursive logic: check if the first element (car L) in the input is number or list. If number, mathematically evaluate the postfix expression with help of the (translate op ) procedure and return the value
; If (car L) is a list, make recursive call to the function for both sublists: car L and cdr L, and collectively evaluate the values returned

( define (postfix-eval L)
   (cond ((null? L) L)
     ;( (number? (car L)) (car L) )
     ((number? (car L)) ((translate (car (cdr (cdr L)))) (car L) (cadr L)))
         (else ((translate (car (cdr (cdr L)))) (postfix-eval(car L)) (postfix-eval(cadr L)))
      )
   )
)

(postfix-eval '((16 12 *) ((2 6 +) (9 1 -) *) /))

;----------------------------------------------------------------
'---Q7

; Base Case: L is empty, return the set containing the empty set, i.e. '(()).
; Assumption: (powerset M) returns the powerset of M, for any set M
; smaller than L (including (cdr L)).
; Logic: Append the powerset values generated against (cdr L) with the
; lambda that returns first element of L (car L) paired with the powerset of (cdr L)

(define (powerset L) 
  (if (null? L) '(())
      (append (powerset (cdr L))
              (map (lambda (M) (cons (car L) M))
                   (powerset (cdr L))))))

(powerset '(1 2 3 4))
