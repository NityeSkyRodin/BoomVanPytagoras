#lang racket

(require racket/gui/base)
(require racket/math)

(define pythagoras-canvas%
  (class canvas%
    (super-new)
    (define/override (on-paint)
      (let* ((dc (send this get-dc))
             (canvas-width (send this get-width))
             (base-size 400))
        (draw-pythagoras-tree dc 700 700 150 13 (/ pi 2))))) ; Aantal niveaus van de Boom van Pythagoras aanpassen
    )

(define (draw-pythagoras-tree dc x y size index angle)
  (define (helper x y size index angle)
    (cond ((<= index 0) #t)
          (else
           (define x2 (+ x (* size (cos angle))))
           (define y2 (- y (* size (sin angle))))
           (define x3 (+ x2 (* size (cos (- angle (/ pi 2))))))
           (define y3 (- y2 (* size (sin (- angle (/ pi 2))))))
           (define x4 (+ x (* size (cos (- angle (/ pi 2))))))
           (define y4 (- y (* size (sin (- angle (/ pi 2))))))

           (draw dc x y x2 y2 x3 y3 x4 y4)

           (define new-size (/ size (sqrt 2)))

           (helper x2 y2 new-size (- index 1) (+ angle (/ pi 4)))
           (helper x3 y3 new-size (- index 1) (- angle (/ pi 4))))))

  (helper x y size index angle))

    
(define (draw dc x y x2 y2 x3 y3 x4 y4)
  (send dc draw-line x y x2 y2)
  (send dc draw-line x2 y2 x3 y3)
  (send dc draw-line x3 y3 x4 y4)
  (send dc draw-line x4 y4 x y))

(define frame (new frame% [label "Pythagoras Tree"]))

(define canvas (new pythagoras-canvas% [parent frame]))

(send frame show #t)