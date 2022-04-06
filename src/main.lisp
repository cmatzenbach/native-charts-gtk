(in-package :native-charts-gtk)


;; simple app with a slider
(defun demo-simple-slider ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:gtk-window :type :toplevel :title "Bleep"))
          (vbox (make-instance 'gtk:gtk-box :orientation :vertical
                                            :spacing 25
                                            :margin 25))
          (slider (make-instance 'gtk:gtk-scale
                                 :orientation :horizontal
                                 :draw-value nil
                                 :width-request 200
                                 :adjustment
                                 (make-instance 'gtk:gtk-adjustment
                                                :value 440
                                                :lower 20
                                                :upper 20000
                                                :step-increment 1))))
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      (gtk:gtk-box-pack-start vbox slider)
      (gtk:gtk-container-add window vbox)
      (gtk:gtk-widget-show-all window))))



;; simple app with two buttons, each of which fires an event handler
(defun demo-clickable-buttons-with-event-handlers ()
  ;; in the docs, this is example-upgraded-hello-world-2.
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Hello Buttons"
                                 :default-width 250
                                 :default-height 75
                                 :border-width 12))
          (box (make-instance 'gtk-box
                              :orientation :horizontal
                              :spacing 6)))
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      (let ((button (gtk:gtk-button-new-with-label "Button 1")))
        (gobject:g-signal-connect button "clicked"
                          (lambda (widget)
                            (declare (ignore widget))
                            (button-clicked 1)))
        (gtk:gtk-box-pack-start box button))
      (let ((button (gtk:gtk-button-new-with-label "Button 2")))
        (gobject:g-signal-connect button "clicked"
                          (lambda (widget)
                            (declare (ignore widget))
                            (button-clicked 2)))
        (gtk:gtk-box-pack-start box button))
      (gtk:gtk-container-add window box)
      (gtk:gtk-widget-show-all window))))

(defun button-clicked (btn-num)
  (format t "Button ~A was pressed my dude!~%" btn-num))



;; makes a thick red square in the middle of the window
(defun demo-cairo-stroke ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Demo Cairo Stroke"
                                 :border-width 12
                                 :default-width 400
                                 :default-height 400))
          (area (make-instance 'gtk-drawing-area)))
      (gobject:g-signal-connect area "draw" #'cairo-stroke-callback)
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

(defun cairo-stroke-callback (widget cr)
  (let ((cr (pointer cr))
        ;; Get the GdkWindow for the widget
        (window (gtk:gtk-widget-window widget)))
    ;; Clear surface
    (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
    (cairo:cairo-paint cr)
    ;; Example is in 1.0 x 1.0 coordinate space
    (cairo:cairo-scale cr
                       (gdk:gdk-window-get-width window)
                       (gdk:gdk-window-get-height window))
    ;; Drawing code goes here
    (cairo:cairo-set-line-width cr 0.1)
    (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    (cairo:cairo-rectangle cr 0.25 0.25 0.5 0.5)
    (cairo:cairo-stroke cr)))


;; draws a giant x in middle of screen with four colored quadrants, x gets tinted per quadrant color
(defun demo-cairo-set-source-rgba ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Demo Cairo Set Source RGBA"
                                 :border-width 12
                                 :default-width 400
                                 :default-height 400))
          (area (make-instance 'gtk-drawing-area)))
      (gobject:g-signal-connect area "draw" #'cairo-set-source-rgba-callback)
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

(defun cairo-set-source-rgba-callback (widget cr)
  (let ((cr (pointer cr))
        ;; Get the GdkWindow for the widget
        (window (gtk:gtk-widget-window widget)))
    ;; Clear surface
    (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
    (cairo:cairo-paint cr)
    ;; Example is in 1.0 x 1.0 coordinate space
    (cairo:cairo-scale cr
                       (gdk:gdk-window-get-width window)
                       (gdk:gdk-window-get-height window))
    ;; Drawing code goes here
    (cairo:cairo-set-source-rgb cr 0 0 0)
    (cairo:cairo-move-to cr 0 0)
    (cairo:cairo-line-to cr 1 1)
    (cairo:cairo-move-to cr 1 0)
    (cairo:cairo-line-to cr 0 1)
    (cairo:cairo-set-line-width cr 0.2)
    (cairo:cairo-stroke cr)
    (cairo:cairo-rectangle cr 0 0 0.5 0.5)
    (cairo:cairo-set-source-rgba cr 1 0 0 0.80)
    (cairo:cairo-fill cr)
    (cairo:cairo-rectangle cr 0 0.5 0.5 0.5)
    (cairo:cairo-set-source-rgba cr 0 1 0 0.60)
    (cairo:cairo-fill cr)
    (cairo:cairo-rectangle cr 0.5 0 0.5 0.5)
    (cairo:cairo-set-source-rgba cr 0 0 1 0.40)
    (cairo:cairo-fill cr)))


;; demonstrates the effect of adding a gradient over existing colored components
(defun demo-cairo-set-source-gradient ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Demo Cairo Set Source Gradient"
                                 :border-width 12
                                 :default-width 400
                                 :default-height 400))
          (area (make-instance 'gtk-drawing-area)))
      (gobject:g-signal-connect area "draw" #'cairo-set-source-gradient)
      (gobject:g-signal-connect window "destroy"
                                (lambda (widget)
                                  (declare (ignore widget))
                                  (gtk:leave-gtk-main)))
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

(defun cairo-set-source-gradient (widget cr)
  (let ((cr (pointer cr))
        ;; Get the GdkWindow for the widget
        (window (gtk:gtk-widget-window widget)))
    ;; Clear surface
    (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
    (cairo:cairo-paint cr)
    ;; Example is in 1.0 x 1.0 coordinate space
    (cairo:cairo-scale cr
                       (gdk:gdk-window-get-width window)
                       (gdk:gdk-window-get-height window))
    ;; Drawing code goes here
    (let ((radpat (cairo:cairo-pattern-create-radial 0.25 0.25 0.10
                                                     0.50 0.50 0.50))
          (linpat (cairo:cairo-pattern-create-linear 0.25 0.35 0.75 0.65)))
      (cairo:cairo-pattern-add-color-stop-rgb radpat 0.00 1.00 0.80 0.80)
      (cairo:cairo-pattern-add-color-stop-rgb radpat 1.00 0.90 0.00 0.00)
      (loop for i from 1 below 10 do
        (loop for j from 1 below 10 do
          (cairo:cairo-rectangle cr
                                 (- (/ i 10.0) 0.04)
                                 (- (/ j 10.0) 0.04)
                                 0.08
                                 0.08)))
      (cairo:cairo-set-source cr radpat)
      (cairo:cairo-fill cr)
      (cairo:cairo-pattern-add-color-stop-rgba linpat 0.00 1.0 1.0 1.0 0.0)
      (cairo:cairo-pattern-add-color-stop-rgba linpat 0.25 0.0 1.0 0.0 0.5)
      (cairo:cairo-pattern-add-color-stop-rgba linpat 0.50 1.0 1.0 1.0 0.0)
      (cairo:cairo-pattern-add-color-stop-rgba linpat 0.75 0.0 0.0 1.0 0.5)
      (cairo:cairo-pattern-add-color-stop-rgba linpat 1.00 1.0 1.0 1.0 0.0)
      (cairo:cairo-rectangle cr 0.0 0.0 1.0 1.0)
      (cairo:cairo-set-source cr linpat)
      (cairo:cairo-fill cr))))


;; demonstrates creating different mods of retangular shapes and how to align them to lines drawn on screen
(defun demo-cairo-drawing-caps ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Cairo Drawing Caps"
                                 :default-width 400
                                 :default-height 300))
          (area (make-instance 'gtk-drawing-area)))
      ;; Signal handler for the drawing area
      (gobject:g-signal-connect area "draw" #'cairo-drawing-caps)
      ;; Signal handler for the window to handle the signal "destroy".
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      ;; Show the window.
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

(defun cairo-drawing-caps (widget cr)
  (let* ((cr (pointer cr))
         (width (gtk:gtk-widget-get-allocated-width widget))
         (height (gtk:gtk-widget-get-allocated-height widget))
         (offset (truncate (/ height 4)))
         (border (truncate (/ width 5)))
         (line-width (truncate (/ height 10))))
    ;; Draw in black ink.
    (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
    ;; Set the line width
    (cairo:cairo-set-line-width cr line-width)
    ;; First line with butt caps
    (cairo:cairo-set-line-cap cr :butt)
    (cairo:cairo-move-to cr border offset)
    (cairo:cairo-line-to cr (- width border) offset)
    (cairo:cairo-stroke cr)

    ;; Second line with round caps.
    (cairo:cairo-set-line-cap cr :round)
    (cairo:cairo-move-to cr border (* 2 offset))
    (cairo:cairo-line-to cr (- width border) (* 2 offset))
    (cairo:cairo-stroke cr)

    ;; Third line with square caps.
    (cairo:cairo-set-line-cap cr :square)
    (cairo:cairo-move-to cr border (* 3 offset))
    (cairo:cairo-line-to cr (- width border) (* 3 offset))
    (cairo:cairo-stroke cr)

    ;; Helper lines to show the line length.
    (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    (cairo:cairo-set-line-width cr 1.0)
    ;; Line on the left side.
    (cairo:cairo-move-to cr border (- offset line-width))
    (cairo:cairo-line-to cr border (+ (* 3 offset) line-width))
    (cairo:cairo-stroke cr)
    ;; Two lines on the right side.
    (cairo:cairo-move-to cr (- width border) (- offset line-width))
    (cairo:cairo-line-to cr (- width border) (+ (* 3 offset) line-width))
    (cairo:cairo-stroke cr)

    (cairo:cairo-move-to cr (+ (- width border) (/ line-width 2))
                      (- offset line-width))
    (cairo:cairo-line-to cr (+ (- width border) (/ line-width 2))
                      (+ (* 3 offset) line-width))
    (cairo:cairo-stroke cr)))

;; (defun demo-cairo-fill ()
;;   (gtk:within-main-loop
;;     (let ((window (make-instance 'gtk-window
;;                                  :type :toplevel
;;                                  :title "Demo Cairo Fill"
;;                                  :border-width 12
;;                                  :default-width 400
;;                                  :default-height 400)))
;;       (gobject:g-signal-connect window "destroy"
;;                         (lambda (widget)
;;                           (declare (ignore widget))
;;                           (leave-gtk-main)))
;;       ;; Signals used to handle the backing surface
;;       (gobject:g-signal-connect window "draw"
;;          (lambda (widget cr)
;;            (let ((cr (pointer cr))
;;                  ;; Get the GdkWindow for the widget
;;                  (window (gtk-widget-window widget)))
;;            ;; Clear surface
;;            (cairo-set-source-rgb cr 1.0 1.0 1.0)
;;            (cairo-paint cr)
;;            ;; Example is in 1.0 x 1.0 coordinate space
;;            (cairo-scale cr
;;                         (gdk:gdk-window-width window)
;;                         (gdk-window-height window))
;;            ;; Drawing code goes here
;;            (cairo-set-source-rgb cr 1.0 0.0 0.0)
;;            (cairo-rectangle cr 0.25 0.25 0.5 0.5)
;;            (cairo-fill cr)
;;            ;; Destroy the Cairo context
;;            (cairo-destroy cr)
;;            t)))
;;         (gtk-widget-show-all window))))

;; (defun demo-cairo-text ()
;;   (gtk:within-main-loop
;;     (let ((window (make-instance 'gtk-window
;;                                  :type :toplevel
;;                                  :title "Demo Cairo Text"
;;                                  :border-width 12
;;                                  :default-width 400
;;                                  :default-height 400)))
;;       (gobject:g-signal-connect window "destroy"
;;                         (lambda (widget)
;;                           (declare (ignore widget))
;;                           (leave-gtk-main)))
;;       ;; Signals used to handle the backing surface
;;       (gobject:g-signal-connect window "draw"
;;          (lambda (widget cr)
;;            (let ((cr (pointer cr))
;;                  ;; Get the GdkWindow for the widget
;;                  (window (gtk-widget-window widget)))
;;            ;; Clear surface
;;            (cairo-set-source-rgb cr 1.0 1.0 1.0)
;;            (cairo-paint cr)
;;            ;; Example is in 1.0 x 1.0 coordinate space
;;            (cairo-scale cr
;;                         (gdk:gdk-window-width window)
;;                         (gdk-window-height window))
;;            ;; Drawing code goes here
;;            (cairo-set-source-rgb cr 0.0 0.0 0.0)
;;            (cairo-select-font-face cr "Georgia" :weight :bold)
;;            (cairo-set-font-size cr 1.2)
;;            (let ((text-extents (cairo-text-extents cr "a")))
;;              (cairo-move-to cr
;;                             (- 0.5
;;                                (/ (cairo-text-extents-width text-extents) 2)
;;                                (cairo-text-extents-x-bearing text-extents))
;;                             (- 0.5
;;                                (/ (cairo-text-extents-height text-extents) 2)
;;                                (cairo-text-extents-y-bearing text-extents)))
;;              (cairo-show-text cr "a"))
;;            ;; Destroy the Cairo context
;;            (cairo-destroy cr)
;;            t)))
;;         (gtk-widget-show-all window))))

;; (defun demo-cairo-paint ()
;;   (gtk:within-main-loop
;;     (let ((window (make-instance 'gtk-window
;;                                  :type :toplevel
;;                                  :title "Demo Cairo Paint"
;;                                  :border-width 12
;;                                  :default-width 400
;;                                  :default-height 400)))
;;       (gobject:g-signal-connect window "destroy"
;;                         (lambda (widget)
;;                           (declare (ignore widget))
;;                           (leave-gtk-main)))
;;       ;; Signals used to handle the backing surface
;;       (gobject:g-signal-connect window "draw"
;;          (lambda (widget cr)
;;            (let ((cr (pointer cr))
;;                  ;; Get the GdkWindow for the widget
;;                  (window (gtk-widget-window widget)))
;;            ;; Clear surface
;;            (cairo-set-source-rgb cr 1.0 1.0 1.0)
;;            (cairo-paint cr)
;;            ;; Example is in 1.0 x 1.0 coordinate space
;;            (cairo-scale cr
;;                         (gdk:gdk-window-width window)
;;                         (gdk-window-height window))
;;            ;; Drawing code goes here
;;            (cairo-set-source-rgb cr 0.0 0.0 0.0)
;;            (cairo-paint-with-alpha cr 0.5d0)
;;            ;; Destroy the Cairo context
;;            (cairo-destroy cr)
;;            t)))
;;         (gtk-widget-show-all window))))

;; (defun demo-cairo-mask ()
;;   (gtk:within-main-loop
;;     (let ((window (make-instance 'gtk-window
;;                                  :type :toplevel
;;                                  :title "Demo Cairo Mask"
;;                                  :border-width 12
;;                                  :default-width 400
;;                                  :default-height 400)))
;;       (gobject:g-signal-connect window "destroy"
;;                         (lambda (widget)
;;                           (declare (ignore widget))
;;                           (leave-gtk-main)))
;;       ;; Signals used to handle the backing surface
;;       (gobject:g-signal-connect window "draw"
;;          (lambda (widget cr)
;;            (let ((cr (pointer cr))
;;                  ;; Get the GdkWindow for the widget
;;                  (window (gtk-widget-window widget)))
;;            ;; Clear surface
;;            (cairo-set-source-rgb cr 1.0 1.0 1.0)
;;            (cairo-paint cr)
;;            ;; Example is in 1.0 x 1.0 coordinate space
;;            (cairo-scale cr
;;                         (gdk:gdk-window-width window)
;;                         (gdk-window-height window))
;;            ;; Drawing code goes here
;;            (let ((linpat (cairo-pattern-create-linear 0 0 1 1))
;;                  (radpat (cairo-pattern-create-radial 0.5 0.5 0.25
;;                                                       0.5 0.5 0.75)))
;;              (cairo-pattern-add-color-stop-rgb linpat 0 0 0.3 0.8)
;;              (cairo-pattern-add-color-stop-rgb linpat 1 0 0.8 0.3)
;;              (cairo-pattern-add-color-stop-rgba radpat 0 0 0 0 1)
;;              (cairo-pattern-add-color-stop-rgba radpat 0.5 0 0 0 0)
;;              (cairo-set-source cr linpat)
;;              (cairo-mask cr radpat))
;;            (cairo-destroy cr)
;;            t)))
;;         (gtk-widget-show-all window))))



;; (defun demo-cairo-path ()
;;   (gtk:within-main-loop
;;     (let ((window (make-instance 'gtk-window
;;                                  :type :toplevel
;;                                  :title "Demo Cairo Path"
;;                                  :border-width 12
;;                                  :default-width 400
;;                                  :default-height 400)))
;;       (gobject:g-signal-connect window "destroy"
;;                         (lambda (widget)
;;                           (declare (ignore widget))
;;                           (leave-gtk-main)))
;;       ;; Signals used to handle the backing surface
;;       (gobject:g-signal-connect window "draw"
;;          (lambda (widget cr)
;;            (let (;; Get the GdkWindow for the widget
;;                  (window (gtk-widget-window widget)))
;;            ;; Clear surface
;;            (cairo-set-source-rgb (pointer cr) 1.0d0 1.0d0 1.0d0)
;;            (cairo-paint (pointer cr))
;;            ;; Example is in 1.0 x 1.0 coordinate space
;;            (cairo-scale (pointer cr)
;;                         (gdk:gdk-window-get-width window)
;;                         (gdk-window-height window))
;;            ;; Drawing code goes here
;;            (cairo-set-line-width (pointer cr) 0.01d0)
;;            (cairo-set-source-rgb (pointer cr) 1.0d0 0.0d0 0.0d0)
;;            (cairo-move-to (pointer cr) 0.25 0.25)
;;            (cairo-line-to (pointer cr) 0.5 0.375)
;;            (cairo-rel-line-to (pointer cr) 0.25 -0.125)
;;            (cairo-arc (pointer cr)
;;                       0.5 0.5 (* 0.25 (sqrt 2)) (* -0.25 pi) (* 0.25 pi))
;;            (cairo-rel-curve-to (pointer cr) -0.25 -0.125 -0.25 0.125 -0.5 0)
;;            (cairo-close-path (pointer cr))
;;            (cairo-stroke (pointer cr))
;;            ;; Destroy the Cairo context
;;            (cairo-destroy (pointer cr))
;;            t)))
;;         (gtk-widget-show-all window))))

;;; --- Cairo Examples ---------------------------------------------------------

(defun demo-cairo-dash ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Demo Cairo Stroke"
                                 :border-width 12
                                 :default-width 400
                                 :default-height 400)))
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      ;; Signals used to handle the backing surface
      (gobject:g-signal-connect window "draw"
         (lambda (widget cr)
           (let ((cr (pointer cr))
                 ;; Get the GdkWindow for the widget
                 (window (gtk:gtk-widget-window widget)))
           ;; Clear surface
           (cairo:cairo-set-source-rgb cr 1.0 1.0 1.0)
           (cairo:cairo-paint cr)
           ;; Example is in 1.0 x 1.0 coordinate space
           (cairo:cairo-scale cr
                        (gdk:gdk-window-get-width window)
                        (gdk:gdk-window-get-height window))
           ;; Drawing code goes here
           (let* ((scale 500)
                  (dashes (list (/ 50.0 scale)
                                (/ 10.0 scale)
                                (/ 10.0 scale)
                                (/ 10.0 scale)))
                  (offset (/ -50.0 scale)))
             (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
             (cairo:cairo-set-dash cr dashes offset)
             (cairo:cairo-set-line-width cr (/ 10.0 scale))
             (cairo:cairo-move-to cr (/ 128.0 scale) (/ 25.6 scale))
             (cairo:cairo-line-to cr (/ 230.4 scale) (/ 230.4 scale))
             (cairo:cairo-rel-line-to cr (/ -102.4 scale) 0.0)
             (cairo:cairo-curve-to cr (/ 51.2 scale)
                                (/ 230.4 scale)
                                (/ 51.2 scale)
                                (/ 128.0 scale)
                                (/ 128.0 scale)
                                (/ 128.0 scale))
              (cairo:cairo-stroke cr))
           ;; Destroy the Cario context
           (cairo:cairo-destroy cr)
           t)))
      (gtk:gtk-widget-show-all window))))
