;; Tarpit Lisp Blog Scaffolding -- index template
;;
;; TODO: Make a macro to obtain general forms such as the ones below
(defun tlbs-out-index (output-stream)
  (let ((latest-5 (take 5 *posts*)))
    (cl-who:with-html-output (output-stream nil :indent nil)
      (cl-who:str "We's 'tem'llectuals or we's no more.")
      (:h2 "Recent posts")
      (:ul
       (make-post-list latest-5))
      (:h2 "Contact")
      (:ul :class "inline-list"
           (:li (:a :href "http://webchat.freenode.net" "Freenode")"/spyked")
           (:li (:a :href "/uploads/email.png" "Mail") "+"
                (:a :href "http://lucian.mogosanu.ro/about/pgp.html" "PGP"))
           (:li (:a :href "https://github.com/spyked" "GitHub"))
           (:li (:a :href "https://www.facebook.com/lucian.mogosanu"
                    "Facebook")))))
  nil)

(defun tlbs-make-index ()
  (let ((str-out (make-string-output-stream))
        (blist (make-hash-table :test 'equal)))
    (tlbs-out-index str-out)
    (setf (gethash "title" blist) "Home")
    (setf (gethash "body" blist) (get-output-stream-string str-out))
    (setf (gethash "uri" blist) #p"/index.html")
    blist))
