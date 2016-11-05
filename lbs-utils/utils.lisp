;; Tarpit LBS utility library

; This assumes pathnames are absolute to *lbs-base*
(defun post-relative-pathname (pathname)
  (enough-namestring pathname (pathname *lbs-base*)))

(defun post-out-extension (in-pathname)
  (make-pathname :type "html" :defaults in-pathname))     

(defmacro load-rel (rel-path)
  `(load (concatenate 'string *lbs-base* ,rel-path)))

(defun concat-pathnames (path1 path2)
  (make-pathname
   :directory (append (pathname-directory path1)
                      ; assuming path2 is relative
                      (cdr (pathname-directory path2)))
   :name (pathname-name path2)
   :type (pathname-type path2)))

;; General utility functions
(defun but-last (L)
  (let ((ret nil))
    (do ((L L (cdr L)))
        ((not (cdr L)))
      (push (car L) ret))
    (nreverse ret)))

(defun just-last (L)
  (car (reverse L)))

(defun take (n list)
  (if (or (= 0 n) (null list))
      '()
      (cons (car list) (take (- n 1) (cdr list)))))

(defun count->string (L)
  (write-to-string (length L)))

(defvar *months*
  '("January" "February" "March" "April" "May" "June" "July"
    "August" "September" "October" "November" "December"))

(defvar *months-abbrv*
  (mapcar #'(lambda (str) (subseq str 0 3)) *months*))

(defvar *days-of-week*
  '("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun"))
  
; Date utilities
(defun decode-post-date (string)
  ;; Decode date in format "Month Date, Year"
  (let* ((atoms (cl-ppcre:split "[ ,]" string))
         (month (1+ (position (car atoms) *months* :test 'equal)))
         (date (parse-integer (cadr atoms)))
         (year (parse-integer (cadddr atoms))))
    (encode-universal-time 0 0 0 date month year 0)))

(defun post-date->build-date (string)
  ;; Turn a post date to an RSS-XML buildDate item
  (let ((universal-time (decode-post-date string)))
    (multiple-value-bind (second minute hour date month year dow)
        (decode-universal-time universal-time 0)
      (with-output-to-string (str)
        (format str "~A, ~2,'0D ~A ~4,'0D "
                (nth dow *days-of-week*)
                date
                (nth (- month 1) *months-abbrv*)
                year)
        (format str "~2,'0D:~2,'0D:~2,'0d UT"
                hour minute second)))))
