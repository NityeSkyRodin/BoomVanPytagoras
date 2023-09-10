#lang racket
(require racket/draw)
(require racket/gui)
(require racket/math)

(define no-pen (new pen% [style 'transparent]))
(define no-brush (new brush% [style 'transparent]))
(define red-brush (new brush% [color "red"]))
(define white-brush (new brush% [color "white"]))
(define red-pen (new pen% [color "black"] [width 2]))
(define inR 20)
(define inL 40)
(define X 100)
(define Y 5)
(define XL 50)
(define YL 50)
(define R 0.005)

(define(main)
(let a ((input (read-line)))
(set! R (+ a))
))
;(main)
(define (draw-face dc)
  ;(send dc rotate 1)
  (send dc scale 0.8 0.8)
  (send dc set-background "red") 
  (send dc draw-rectangle 749 749 403 401)
  (send dc set-pen no-pen)
  (send dc set-brush white-brush)
  (send dc draw-rectangle 750 750 400 400)
  
  (send dc set-brush red-brush)
  (send dc draw-rectangle 750 950 400 400))

(define (For-Loop dc)
  (for([i '12345])
    (send dc draw-rectangle X Y XL YL)
    (set X + 50)
    )
)

(define (recursieLeft dc X Y XL YL R)
(define resultX 0)
(define resultXL_YL 0)
  
  (cond ((> inL 0)
  (send dc rotate R)
 (send dc draw-rectangle X Y XL YL)
 (set! resultX (* X 1))
 (set! resultX (+ resultX 0))
 (set! resultXL_YL (/ XL 1.05))
 (set! R (+ R 0.0009))
 
 (set! inL (- inL 1))
 (recursieLeft dc resultX Y resultXL_YL resultXL_YL R)
         )
        (else
(set! inL 0)
         )
  )
)

(define (recursieRight dc X Y XL YL)
(define resultX 0)
(define resultXL_YL 0)
  (cond ((> inR 0)
 (send dc draw-ellipse X Y XL YL)
 (set! resultX (+ X(random 100)))
 (set! resultXL_YL (/ XL 1.05))
 (set! inR (- inR 1))
 (recursieRight dc resultX Y resultXL_YL resultXL_YL)
         )
        (else
         (set! inR 0)
         )
  )
)
(define target (make-bitmap 1500 1500))
(define dc (new bitmap-dc% [bitmap target]))
 
;(draw-face dc)
;(For-Loop dc)
;(recursieRight dc 100 300 XL YL)
(recursieLeft dc 100 1450 XL YL R)








(make-object image-snip% target)
