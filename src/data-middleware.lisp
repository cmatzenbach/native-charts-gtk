(in-package :data-middleware)

(defun find-first-goalie ()
  (dbi:with-connection (conn :postgres :database-name "lightdb" :host "127.0.0.1" :port 5432 :username "postgres" :password "postgres")
    (let* ((query (dbi:prepare conn "SELECT * FROM hockey.goalies WHERE goalies_pk = 1"))
           (query (dbi:execute query)))
      (format nil "~a" (dbi:fetch query)))))
