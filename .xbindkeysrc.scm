; needs xdotool to work
(define actionperformed #f)

(define (first-binding)
  ;; G502 DPI Up button
  (xbindkey-function '("b:12") second-binding))


(define (reset-first-binding)
  (ungrab-all-keys)
  (remove-all-keys)
  (set! actionperformed #f)

  (first-binding)
  (grab-all-keys))


(define (second-binding)
  (ungrab-all-keys)
  (remove-all-keys)

  ;; DPI Up button + Right Click
  (xbindkey-function '("b:3")
                     (lambda ()
                       (run-command "qdbus org.kde.kglobalaccel /component/kwin invokeShortcut 'Switch One Desktop to the Right'")
                       (set! actionperformed #t)))

  (xbindkey-function '(release "b:12") 
                     (lambda ()
                       ;; Perform Action if Button is pressed and released by itself
                       ;(if (not actionperformed) (run-command "xdotool click --clearmodifiers 9"))
                       (reset-first-binding)))
  (grab-all-keys))

(first-binding)
