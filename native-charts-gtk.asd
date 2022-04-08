(defsystem "native-charts-gtk"
  :version "0.1.0"
  :author "Chris Matzenbach"
  :license ""
  :depends-on (:cl-cffi-gtk :mito :cl-dbi)
  :components ((:file "packages")
               (:file "src/main" :depends-on ("packages"))
               (:file "src/data-middleware" :depends-on ("packages"))
               (:file "src/bar-chart" :depends-on ("packages")))
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
