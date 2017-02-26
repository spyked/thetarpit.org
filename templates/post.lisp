;; Tarpit Lisp Blog Scaffolding -- post template
;;
;; TODO: Make a macro to obtain general forms such as the ones below

; Macros go first
(defmacro make-tag-list (tag-list)
  (with-gensyms (tag tlist)
   `(cl-who:htm
     (cl-who:str "(")
     (dolist (,tag (but-last ,tag-list))
       (let ((,tlist (find-tag ,tag)))
         (cl-who:htm (:a :href (gethash "uri" ,tlist) (cl-who:str ,tag))
                     " ")))
     (let* ((,tag (just-last ,tag-list))
            (,tlist (find-tag ,tag)))
       (cl-who:htm (:a :href (gethash "uri" ,tlist)
                       (cl-who:str ,tag))))
     (cl-who:str ")"))))
       

(defmacro make-post-list (blist-list)
  (with-gensyms (blist date uri title excerpt)
   `(cl-who:htm
     (:ul :class "postlist"
          (dolist (,blist ,blist-list)
            (let ((,date (gethash "date" ,blist))
                  (,uri (gethash "uri" ,blist))
                  (,title (gethash "title" ,blist))
                  (,excerpt (gethash "excerpt" ,blist)))
              (cl-who:htm
               (:li :class "plitem"
                    (cl-who:str ,date)
                    (cl-who:str ": ")
                    (:a :href ,uri (cl-who:str ,title))
                    (if ,excerpt
                        (cl-who:htm
                         (cl-who:str ": ")
                         (:span :class "plexcerpt"
                                (cl-who:str ,excerpt))))))))))))

(defun tlbs-make-post (blist)
  (let ((new-body
         (with-output-to-string (out)
           (cl-who:with-html-output (out nil :indent nil)
             (cl-who:htm (:div :class "info"
                               (:sup (cl-who:str (gethash "postid" blist)))
                               (cl-who:str (format nil "~%"))
                               (cl-who:str (gethash "date" blist))
                               (cl-who:str " -- ")
                               (:span :class "tags"
                                      (make-tag-list (gethash "tags" blist))))
                         (cl-who:str (format nil "~%"))
                         (cl-who:str (gethash "body" blist)))))))
    (setf (gethash "body" blist) new-body)
    blist))

(defun find-tag (tagid)
  (find-if #'(lambda (tlist) (equal (gethash "tagid" tlist)
                                    tagid))
           *tags*))

(defun adjoin-tagid (tagid blist)
  (let ((tag (find-tag tagid)))
    (if tag
        (push blist (gethash "posts" tag))
        (let ((tlist (make-hash-table :test 'equal)))
          (setf (gethash "tagid" tlist) tagid)
          ; title
          (setf (gethash "title" tlist)
                (format nil "Posts tagged '~A'" tagid))
          ; uri
          (setf (gethash "uri" tlist)
                (format nil "/tags/~A.html" tagid))
          ; post list
          (setf (gethash "posts" tlist) (list blist))
          ; add new tlist
          (push tlist *tags*)))))

(defun tlbs-make-tagids (blist)
  (let ((new-tags
         (cl-ppcre:split "\\s*,\\s*" (gethash "tags" blist))))
    ; set tagid list in blist
    (setf (gethash "tags" blist) new-tags)
    ; as a side effect, adjoin a potential new tlist to the tag list
    (dolist (tagid new-tags)
      (adjoin-tagid tagid blist)))
  blist)

(defun pipe-through-pandoc (blist)
  (let ((new-body
         (with-input-from-string (in (gethash "body" blist))
           (with-output-to-string (out)
             (uiop:run-program "pandoc -f markdown --mathjax"
                               :input in :output out)))))
    (setf (gethash "body" blist) new-body))
  blist)
