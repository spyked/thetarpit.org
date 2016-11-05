;; Tarpit Lisp Blog Scaffolding
;;
;; A static blog generator
;;
;; blog.lisp assumes that the following variables are defined:
;;
;; - *lbs-base*: the site's base/current working directory
;; - *lbs-path*: an emulation of unix's PATH envvar
;; - *lbs-site*: directory where the output files will be stored

;; Add LBS dependencies
(push (concatenate 'string *lbs-base* "cl-who/") *lbs-path*) ; cl-who
(push (concatenate 'string *lbs-base* "cl-ppcre/") *lbs-path*) ; cl-ppcre
(push (concatenate 'string *lbs-base* "lbs-utils/") *lbs-path*) ; cl-ppcre

; Set paths and change dir (SBCL-specific)
(dolist (path *lbs-path*)
  (if (not (member path asdf:*central-registry*))
      (push path asdf:*central-registry*)))
(sb-posix:chdir *lbs-base*)
(setq *default-pathname-defaults* (pathname *lbs-base*))

; Load libraries
(require 'asdf)
(asdf:load-system :cl-who)
(asdf:load-system :cl-ppcre)
(asdf:load-system :lbs-utils)

; TLBS global variables
(defvar *posts* nil) ; list of post blists
(defvar *pages* nil)
(defvar *tags* nil)

; Load template definitions
(load (concatenate 'string *lbs-base* "templates/default.lisp"))
(load (concatenate 'string *lbs-base* "templates/index.lisp"))
(load (concatenate 'string *lbs-base* "templates/post.lisp"))
(load (concatenate 'string *lbs-base* "templates/archive.lisp"))
(load (concatenate 'string *lbs-base* "templates/rss.lisp"))

;; TLBS functions
;;
;; TODO: Move them to an ASDF project
(defun get-plain-text (path)
  (let ((blist (make-hash-table :test 'equal)))
    (with-open-file (stream path)
      ; First read the header: ignore everything until the first line
      ; with three dashes
      (do ((line (read-line stream) (read-line stream)))
          ((equal line "---")))

      ; Now read variables and add them to the blist
      (do ((line (read-line stream) (read-line stream)))
          ((equal line "---"))
        (let ((pair (cl-ppcre:split ":\\s*" line :limit 2)))
          (if (not (cdr pair))
              (format t "Error parsing line: ~a" line)
              (setf (gethash (car pair) blist) (cadr pair)))))

      ; Now all that's left to read is the page body
      ;
      ; Note that we build a new string with the length exactly equal to
      ; the file's length minus what we have read so far.
      (let ((body (make-string (file-length stream))))
        (read-sequence body stream)
        (setf (gethash "body" blist) (string-trim '(#\Nul) body)))

      ; Return the new blist
      blist)))

(defun tlbs-make-blist (relative-pathname)
  (let* ((in-path (concat-pathnames (pathname *lbs-base*)
                                   relative-pathname))
         (out-path (post-out-extension
                    (concat-pathnames (pathname *lbs-site*)
                                      relative-pathname)))
         (uri (namestring (post-out-extension
                           (concat-pathnames #p"/" relative-pathname))))
         (blist (get-plain-text in-path)))
    (setf (gethash "in-path" blist) in-path)
    (setf (gethash "out-path" blist) out-path)
    (setf (gethash "uri" blist) uri)
    blist))

(defun tlbs-write-blist (blist)
  (with-open-file (out (ensure-directories-exist (gethash "out-path" blist))
                       :direction :output
                       :if-exists :supersede)
    (write-string (gethash "body" blist) out))
  blist)

(defun tlbs-process-posts ()
  (format t "Processing posts...~%")
  ; clean up old posts first...
  (setq *posts* nil
        *tags* nil)
  (dolist (x (directory (concatenate 'string *lbs-base* "posts/**/*.markdown")))
    (format t "[proc] ~s~%" x)
    (let* ((relative-pathname (post-relative-pathname x))
           (blist (tlbs-make-blist relative-pathname)))
      ; markdown -> html
      (pipe-through-pandoc blist)
      ; process tags
      (tlbs-make-tagids blist)
      ; post template
      (tlbs-make-post blist)
      ; default page template
      (tlbs-make-default blist)
      ; write to file
      (tlbs-write-blist blist)
      ; make sure body is erased when done writing
      ; XXX: the body might still be needed when generating RSS
      (setf (gethash "body" blist) nil)
      ; add to post list
      (push blist *posts*)))
  nil)

(defun tlbs-process-page (out-path blist)
  (format t "[proc] ~s~%" out-path)
  ; out path
  (setf (gethash "out-path" blist) out-path)
  ; default page template
  (tlbs-make-default blist)
  ; write to file
  (tlbs-write-blist blist)
  ; erase body
  (setf (gethash "body" blist) nil)
  ; maybe add to page list
  ; XXX: this should replace the old page with the new one
  ; XXX: use adjoin
  (if (not (member blist *pages*
                   :test #'(lambda (blist1 blist2)
                             ; XXX: should actually use postid
                             (string-equal (gethash "title" blist1)
                                           (gethash "title" blist2)))))
      (push blist *pages*))
  nil)

(defun tlbs-process-markdown-page (relative-pathname)
  (let ((blist (tlbs-make-blist relative-pathname)))
    ; markdown -> html
    (pipe-through-pandoc blist)
    ; continue with normal page processing
    (tlbs-process-page (gethash "out-path" blist) blist)))

(defun tlbs-process-archive ()
  (tlbs-process-page (merge-pathnames
                      (pathname *lbs-site*)
                      (make-pathname :name "archive" :type "html"))
                     (tlbs-make-archive)))

(defun tlbs-process-index ()
  (tlbs-process-page (merge-pathnames
                      (pathname *lbs-site*)
                      (make-pathname :name "index" :type "html"))
                     (tlbs-make-index)))

(defun tlbs-process-tags ()
  (format t "Processing tags...~%")
  (dolist (tlist *tags*)
    ; set out path
    (setf (gethash "out-path" tlist)
          (concat-pathnames (pathname *lbs-site*)
                            (gethash "uri" tlist)))
    (format t "[proc] ~s~%" (gethash "out-path" tlist))
    ; generate page body
    (tlbs-make-tag tlist)
    ; apply default page template
    (tlbs-make-default tlist)
    ; write to file
    (tlbs-write-blist tlist)
    ; optionally, set body to nil
    (setf (gethash "body" tlist) nil))
  nil)

(defun tlbs-copy-file (in-path out-path)
  (let ((element-type '(unsigned-byte 8)))
    (with-open-file (in-stream in-path
                               :direction :input
                               :element-type element-type)
      (with-open-file (out-stream (ensure-directories-exist out-path)
                                  :direction :output
                                  :element-type element-type
                                  :if-exists :supersede
                                  :if-does-not-exist :create)
        (uiop:copy-stream-to-stream in-stream out-stream
                                    :element-type element-type)))))

(defun tlbs-copy-recursively (in-path out-base-dir)
  ; Check if file is a directory. We assume that pathname-name returns
  ; NIL in this case.
  ;(format t "~s~%" (pathname-name (probe-file in-path)))
  (if (pathname-name (probe-file in-path))
      (let* ((relative-pathname (post-relative-pathname in-path))
             (out-path (concat-pathnames out-base-dir
                                         relative-pathname)))
        (format t "[copy] ~s~%" in-path)
        (tlbs-copy-file in-path out-path))
      (dolist (new-in-path (directory (concat-pathnames in-path #p"*.*")))
        (tlbs-copy-recursively new-in-path out-base-dir))))


(defun tlbs-process-other-files ()
  (format t "Processing other files...~%")
  (format t "--- css:~%")
  (tlbs-copy-recursively (concat-pathnames (pathname *lbs-base*)
                                          #p"css/")
                         (pathname *lbs-site*))

  (format t "--- uploads:~%")
  (tlbs-copy-recursively (concat-pathnames (pathname *lbs-base*)
                                          #p"uploads/")
                         (pathname *lbs-site*)))

(defun tlbs-process-rss ()
  (let ((blist (tlbs-make-rss)))
    ; out path
    (setf (gethash "out-path" blist)
          (concat-pathnames (pathname *lbs-site*)
                            #p"rss.xml"))
    ; late processing message
    (format t "[proc] ~s~%" (gethash "out-path" blist))
    ; write rss
    (tlbs-write-blist blist))
  nil)

(defun tlbs-process-everything ()
  ; posts: needed for everything, so process them first
  (tlbs-process-posts)
  ; tags
  (tlbs-process-tags)
  ; other files
  (tlbs-process-other-files)
  ; RSS
  (tlbs-process-rss)

  (format t "Processing everything else...~%")
  ; markdown pages: about, 403, 404, etc.
  (dolist (page '(#p"about.markdown" #p"403.markdown" #p"404.markdown"))
    (tlbs-process-markdown-page page))
  ; archive
  (tlbs-process-archive)
  ; index
  (tlbs-process-index))
