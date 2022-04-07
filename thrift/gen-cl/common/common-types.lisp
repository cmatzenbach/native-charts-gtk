;;; Autogenerated by Thrift
;;; DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
;;; options string: cl

(thrift:def-package :thrift-generated)

(cl:in-package :thrift-generated)

(thrift:def-enum "TDeviceType"
  (("CPU" . 0)
   ("GPU" . 1)))

(thrift:def-enum "TDatumType"
  (("SMALLINT" . 0)
   ("INT" . 1)
   ("BIGINT" . 2)
   ("FLOAT" . 3)
   ("DECIMAL" . 4)
   ("DOUBLE" . 5)
   ("STR" . 6)
   ("TIME" . 7)
   ("TIMESTAMP" . 8)
   ("DATE" . 9)
   ("BOOL" . 10)
   ("INTERVAL_DAY_TIME" . 11)
   ("INTERVAL_YEAR_MONTH" . 12)
   ("POINT" . 13)
   ("LINESTRING" . 14)
   ("POLYGON" . 15)
   ("MULTIPOLYGON" . 16)
   ("TINYINT" . 17)
   ("GEOMETRY" . 18)
   ("GEOGRAPHY" . 19)))

(thrift:def-enum "TEncodingType"
  (("NONE" . 0)
   ("FIXED" . 1)
   ("RL" . 2)
   ("DIFF" . 3)
   ("DICT" . 4)
   ("SPARSE" . 5)
   ("GEOINT" . 6)
   ("DATE_IN_DAYS" . 7)))

(thrift:def-struct "ttypeinfo"
  (("type" nil :id 1 :type (enum "TDatumType"))
   ("encoding" nil :id 4 :type (enum "TEncodingType"))
   ("nullable" nil :id 2 :type bool)
   ("is_array" nil :id 3 :type bool)
   ("precision" nil :id 5 :type i32)
   ("scale" nil :id 6 :type i32)
   ("comp_param" nil :id 7 :type i32)
   ("size" -1 :id 8 :type i32 :optional t)))

