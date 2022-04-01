(defpackage native-charts-gtk
  (:use :cl))
(in-package :native-charts-gtk)

;; main window
(defvar window (make-instance 'gtk:gtk-window :type :toplevel :title "Bleep"))
(defvar vbox (make-instance 'gtk:gtk-box :orientation :vertical
                                         :spacing 25
                                         :margin 25))

(gtk:within-main-loop
 ;; quit program when window closed
 (gobject:g-signal-connect window "destroy" (lambda (widget)
                                              (declare (ignore widget))
                                              (gtk:leave-gtk-main)))
 ;; display gui
 (gtk:gtk-container-add window vbox)
 (gtk:gtk-widget-show-all window))
