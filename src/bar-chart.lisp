(in-package :bar-chart)

;; should pass in these args once I have data: x-max y-max bar-data
(defun render-bar-chart ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Cairo Drawing Caps"
                                 :default-width 400
                                 :default-height 300))
          (area (make-instance 'gtk-drawing-area)))
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
         (height (gtk:gtk-widget-get-allocated-height widget))
         (line-width (truncate (/ height 10))))
    ;; color of bars
    ;; (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    ;; set bar width, this will depend on how many bars i want to display
    ;; (cairo:cairo-set-line-width cr line-width)
    (format t "width: ~d | height: ~d" width height)
    ;; (cairo:cairo-move-to cr 20 20)
    ;; x and y will represent where the top of the bar is
    ;; the width and height tell how far to draw DOWN the screen to
    ;; thus, once i calculate the size of a bar, to figure out it's y I will need to do:
    ;; will need to store the data in lists with width and height properties
    (cairo:cairo-rectangle cr 25 (- height 500) (- (/ width 2) 25) 500)
    (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    (cairo:cairo-fill cr)
    (cairo:cairo-rectangle cr (+ (/ width 2) 25) (- height 300) (- width 25) 300)
    (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    (cairo:cairo-fill cr)
    ;; lets try and draw our first bar
    ;; (cairo:cairo-set-line-cap cr :butt)
    ;; (cairo:cairo-move-to cr 200 100)
    ;; (cairo:cairo-line-to cr 400 30)
    ;; (cairo:cairo-stroke cr)
    ))

(defun cairo-draw-cb (widget cr)
  (let* ((cr (pointer cr))
         (width (gtk:gtk-widget-get-allocated-width widget))
         (height (gtk:gtk-widget-get-allocated-height widget))
         (offset (truncate (/ height 4)))
         (border (truncate (/ width 5)))
         (line-width (truncate (/ height 10))))
    (format t "width: ~d | height: ~d | offset: ~d | border: ~d | linewidth: ~d" width height offset border line-width)
    ;; Draw in black ink.
    (cairo:cairo-set-source-rgb cr 0.0 0.0 0.0)
    ;; Set the line width
    (cairo:cairo-set-line-width cr 20)
    ;; First line with butt caps
    (cairo:cairo-set-line-cap cr :butt)
    (cairo:cairo-move-to cr border offset)
    (cairo:cairo-line-to cr (- width border) offset)
    (cairo:cairo-stroke cr)

    ;; ;; Second line with round caps.
    ;; (cairo:cairo-set-line-cap cr :round)
    ;; (cairo:cairo-move-to cr border (* 2 offset))
    ;; (cairo:cairo-line-to cr (- width border) (* 2 offset))
    ;; (cairo:cairo-stroke cr)

    ;; ;; Third line with square caps.
    ;; (cairo:cairo-set-line-cap cr :square)
    ;; (cairo:cairo-move-to cr border (* 3 offset))
    ;; (cairo:cairo-line-to cr (- width border) (* 3 offset))
    ;; (cairo:cairo-stroke cr)

    ;; ;; Helper lines to show the line length.
    ;; (cairo:cairo-set-source-rgb cr 1.0 0.0 0.0)
    ;; (cairo:cairo-set-line-width cr 1.0)
    ;; ;; Line on the left side.
    ;; (cairo:cairo-move-to cr border (- offset line-width))
    ;; (cairo:cairo-line-to cr border (+ (* 3 offset) line-width))
    ;; (cairo:cairo-stroke cr)
    ;; ;; Two lines on the right side.
    ;; (cairo:cairo-move-to cr (- width border) (- offset line-width))
    ;; (cairo:cairo-line-to cr (- width border) (+ (* 3 offset) line-width))
    ;; (cairo:cairo-stroke cr)

    ;; (cairo:cairo-move-to cr (+ (- width border) (/ line-width 2))
    ;;                   (- offset line-width))
    ;; (cairo:cairo-line-to cr (+ (- width border) (/ line-width 2))
    ;;                   (+ (* 3 offset) line-width))
    ;; (cairo:cairo-stroke cr)

    ))

(defun test-cairo-draw ()
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Cairo Drawing Caps"
                                 :default-width 400
                                 :default-height 300))
          (area (make-instance 'gtk-drawing-area)))
      ;; Signal handler for the drawing area
      (gobject:g-signal-connect area "draw" #'cairo-draw-cb)
      ;; Signal handler for the window to handle the signal "destroy".
      (gobject:g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      ;; Show the window.
      (gtk:gtk-container-add window area)
      (gtk:gtk-widget-show-all window))))

