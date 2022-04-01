(defpackage native-charts-gtk/tests/main
  (:use :cl
        :native-charts-gtk
        :rove))
(in-package :native-charts-gtk/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :native-charts-gtk)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
