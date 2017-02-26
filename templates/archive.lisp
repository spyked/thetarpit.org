;; Tarpit Lisp Blog Scaffolding -- archive template
;;
;; TODO: Make a macro to obtain general forms such as the ones below

; Macros go first
(defmacro make-label (name uri count)
  `(cl-who:htm
    (:a :href ,uri
        (cl-who:str (format nil "~A (~D)"
                            ,name ,count)))))

(defmacro make-label-list ()
  (with-gensyms (tag tags all-but-last last)
   `(let* ((,tags (sort *tags* #'tlist-lessp))
           (,all-but-last (but-last ,tags))
           (,last (just-last ,tags)))
      (setq *tags* ,tags)         ; sort destroys *tags*, so update it
      (cl-who:htm
       (dolist (,tag ,all-but-last)
         (make-label (gethash "tagid" ,tag)
                     (gethash "uri" ,tag)
                     (length (gethash "posts" ,tag)))
         (cl-who:str ", "))
       (when (not (null ,last))
         (make-label (gethash "tagid" ,last)
                     (gethash "uri" ,last)
                     (length (gethash "posts" ,last))))))))

(defun tlbs-out-archive (output-stream)
  (cl-who:with-html-output (output-stream nil :indent nil)
    (:h2 "Labels")
    (:p (make-label-list))
    (:h2 "Posts from The Tar Pit")
    (make-post-list *posts*))
  nil)

(defun tlbs-make-archive ()
  (let ((str-out (make-string-output-stream))
        (blist (make-hash-table :test 'equal)))
    (tlbs-out-archive str-out)
    (setf (gethash "title" blist) "Archive")
    (setf (gethash "body" blist) (get-output-stream-string str-out))
    (setf (gethash "uri" blist) #p"/archive.html")
    blist))

(defun tlbs-make-tag (tlist)
  (let ((body
         (with-output-to-string (out)
           (cl-who:with-html-output (out nil :indent nil)
             (make-post-list (gethash "posts" tlist))))))
    (setf (gethash "body" tlist) body)
    tlist))

(defun tlist-lessp (tlist1 tlist2)
  (string-lessp (gethash "tagid" tlist1)
                (gethash "tagid" tlist2)))
