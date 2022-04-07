(defpackage native-charts-gtk
  (:use :gtk :gdk :gdk-pixbuf :gobject :glib :gio :pango :cairo :common-lisp))

(defpackage server
  (:use :thrift :thrift-generated :thrift-generated-implementation))
