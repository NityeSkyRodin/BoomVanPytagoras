#lang racket

(require racket/gui/base)
(require racket/math)

(define pythagoras-canvas%
  (class canvas%
    (super-new)
    (define/override (on-paint)
      (let* ((dc (send this get-dc))
             (canvas-width 1000))
        (draw dc)))) ; Moved this line inside the let* scope
    )

(define (draw dc)
  (send dc set-brush "green" 'solid)
  (send dc draw-rectangle 0 0 100 100))

(define frame (new frame% [label "Pythagoras Tree"]))

(define canvas (new pythagoras-canvas% [parent frame]))

(send frame show #t)
