(defsystem "native-charts-gtk"
  :version "0.1.0"
  :author "Chris Matzenbach"
  :license ""
  :depends-on ("cl-cffi-gtk")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "HEAVY.AI 2022 Hackathon Project"
  :in-order-to ((test-op (test-op "native-charts-gtk/tests"))))

(defsystem "native-charts-gtk/tests"
  :author "Chris Matzenbach"
  :license ""
  :depends-on ("native-charts-gtk"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for native-charts-gtk"
  :perform (test-op (op c) (symbol-call :rove :run c)))
