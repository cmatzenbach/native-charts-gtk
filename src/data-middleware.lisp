(in-package :data-middleware)

(defun run-sql (sql)
  (dbi:with-connection (conn :postgres :database-name "lightdb" :host "127.0.0.1" :port 5432 :username "postgres" :password "postgres")
    (let* ((query (dbi:prepare conn sql))
           (query (dbi:execute query)))
      (format nil "~a" (dbi:fetch query)))))
