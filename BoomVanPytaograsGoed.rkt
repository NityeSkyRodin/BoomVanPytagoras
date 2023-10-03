#lang racket

(require racket/gui/base)
(require racket/math)

(define pythagoras-canvas%
  (class canvas%
    (super-new)
    (define/override (on-paint)
      (let* ((start-time (current-milliseconds))
             (dc (send this get-dc))
             (canvas-width (send this get-width))
             (base-size 400))
        (draw-pythagoras-tree dc 700 700 150 20 (/ pi 2))
        (let ((end-time (current-milliseconds)))
          (displayln (format "Tijd voor het tekenen: ~a milliseconden" (- end-time start-time)))))))) ; Aantal niveaus van de Boom van Pythagoras aanpassen

(define (draw-pythagoras-tree dc x y size index angle)
  (when (> index 0)
    (define x2 (+ x (* size (cos angle))))
    (define y2 (- y (* size (sin angle))))
    (define x3 (+ x2 (* size (cos (- angle (/ pi 2))))))
    (define y3 (- y2 (* size (sin (- angle (/ pi 2))))))
    (define x4 (+ x (* size (cos (- angle (/ pi 2))))))
    (define y4 (- y (* size (sin (- angle (/ pi 2))))))

    (draw dc x y x2 y2 x3 y3 x4 y4)

    (define new-size (/ size (sqrt 2)))

    (draw-pythagoras-tree dc x2 y2 new-size (- index 1) (+ angle (/ pi 4)))
    (draw-pythagoras-tree dc x3 y3 new-size (- index 1) (- angle (/ pi 4)))))

(define (draw dc x y x2 y2 x3 y3 x4 y4)
  (send dc draw-line x y x2 y2)
  (send dc draw-line x2 y2 x3 y3)
  (send dc draw-line x3 y3 x4 y4)
  (send dc draw-line x4 y4 x y))

(define frame (new frame% [label "Pythagoras Tree"]))

(define canvas (new pythagoras-canvas% [parent frame]))

(send frame show #t)
