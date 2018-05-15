; needs xdotool to work
(define actionperformed 0)

(define (first-binding)
"First binding"
;; Front Shoulder Button
(xbindkey-function '("b:9") b9-second-binding)
)


(define (reset-first-binding)
"reset first binding"
(ungrab-all-keys)
(remove-all-keys)
;; Set Action Performed state back to 0
(set! actionperformed 0)

(first-binding)
(grab-all-keys))


(define (b9-second-binding)
"Front Shoulder Button Extra Functions"
(ungrab-all-keys)
(remove-all-keys)

;; Scroll Up
(xbindkey-function '("b:3")
                (lambda ()
;; Emulate Ctrl+Alt+Up (Workspace Up)
                (run-command "qdbus org.kde.kglobalaccel /component/kwin invokeShortcut 'Switch One Desktop to the Right'")
		(set! actionperformed 1)
))

(xbindkey-function '(release "b:9") (lambda ()
;; Perform Action if Button 8 is pressed and released by itself
(if (= actionperformed 0) (run-command "xdotool key --clearmodifiers XF86Forward"))
(reset-first-binding)))
(grab-all-keys))

(first-binding)
