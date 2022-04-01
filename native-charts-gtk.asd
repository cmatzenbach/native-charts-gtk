(defsystem "native-charts-gtk"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "native-charts-gtk/tests"))))

(defsystem "native-charts-gtk/tests"
  :author ""
  :license ""
  :depends-on ("native-charts-gtk"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for native-charts-gtk"
  :perform (test-op (op c) (symbol-call :rove :run c)))
