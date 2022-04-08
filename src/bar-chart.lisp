(in-package :bar-chart)

;; should pass in these args once I have data: x-max y-max bar-data
(defun render-bar-chart ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Cairo Drawing Caps"
                                 :default-width 400
                                 :default-height 300))
          (area (make-instance 'gtk-drawing-area))
          )
      ;; Signal handler for the drawing area
      (gobject:g-signal-connect area "draw" #'cairo-draw-bar-chart)
      ;; Signal handler for the window to handle the signal "destroy".
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))
      ;; Show the window.
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

;; also should add these args once I pass in data: x-max y-max bar-data
(defun cairo-draw-bar-chart (widget cr)
  (let* ((cr (pointer cr))
         (width (gtk:gtk-widget-get-allocated-width widget))
         (height (- (gtk:gtk-widget-get-allocated-height widget) 100))
         (line-width (truncate (/ height 10)))
         (margin 40)
         (number-bars 5)
         (data (data-middleware:run-sql "SELECT master.firstname, master.lastname, scoring.tmid, year, g FROM hockey.scoring inner join hockey.master on hockey.master.playerid = hockey.scoring.playerid WHERE scoring.pos = 'D' ORDER BY g DESC nulls last LIMIT 5")))

    (format t "width: ~d | height: ~d" width height)
    (loop for i in data do (format t " ~a " (getf i :|g|)))
    ;; (print data)

    ;; draw x-axis
    (cairo:cairo-move-to cr 15 (+ 2 height))
    (cairo:cairo-line-to cr (- width (- margin 30)) (+ 2 height))
    (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
    (cairo:cairo-set-line-width cr 3)
    (cairo:cairo-stroke cr)

    ;; draw y-axis
    (cairo:cairo-move-to cr 15 margin)
    (cairo:cairo-line-to cr 15 height)
    (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
    (cairo:cairo-set-line-width cr 3)
    (cairo:cairo-stroke cr)

    ;; draw bars and labels
    (draw-bars cr width height margin number-bars data)
    ))

(defun draw-bars (cr width height margin number-bars data)
  (loop for row in data
        for i from 0 to number-bars
        do (progn 
             (cairo:cairo-rectangle cr
                                    (if (= i 0)
                                        margin
                                        (+ (* (/ i number-bars) width) margin))
                                    (- height (* 17 (getf row :|g|)))
                                    (- (/ width number-bars) (* margin 2))
                                    (* 17 (getf row :|g|)))
             (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
             (cairo:cairo-fill cr)
             (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
             (cairo:cairo-select-font-face cr "Georgia" :normal :normal)
             (cairo:cairo-set-font-size cr 20.0)
             (cairo:cairo-move-to cr
                                  (if (= i 0)
                                      (+ margin 15)
                                      (+ (* (/ i number-bars) width) margin 15))
                                  (+ 25 height))
             (print (getf row :|lastname|))
             (cairo:cairo-show-text cr (getf row :|lastname|)))))
