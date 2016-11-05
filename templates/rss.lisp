;; Tarpit Lisp Blog Scaffolding -- archive template
;;
;; Note: this kinda stretches CL-WHO's capabilities, since we're not
;; generating actual HTML, but rather pure XML.

; This is used to generate external links
(defvar *tarpit-url* "http://thetarpit.org")
(defvar *tarpit-xml-url*
  (concatenate 'string *tarpit-url* "/rss.xml"))

;; TODO: Escape CDATA tags in string
(defmacro to-cdata (string)
  `(cl-who:str
    (format nil "<![CDATA[~a]]>" ,string)))

(defun tlbs-make-rss ()
  (let* ((last-n (take 7 *posts*))
         (rss-blist (make-hash-table :test 'equal))
         (body
          (cl-who:with-html-output-to-string
              (out nil :prologue
                   "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                   :indent t)
            (:rss :version "2.0" :|xmlns:atom| "http://www.w3.org/2005/Atom"
                  :|xmlns:dc| "http://purl.org/dc/elements/1.1/"
                  (:channel
                   (:title "The Tar Pit")
                   (:link (cl-who:str *tarpit-url*))
                   (:description (to-cdata "(lambda (tarp) 'it)"))
                   (:|atom:link| :href *tarpit-xml-url* :rel "self"
                     :type "application/rss+xml")
                   (:lastBuildDate (cl-who:str
                                    (post-date->build-date
                                     (gethash "date" (car *posts*)))))
                   (dolist (blist last-n)
                     (let ((abs-url (format nil "~a~a"
                                            *tarpit-url*
                                            (gethash "uri" blist))))
                       (cl-who:htm
                        (:item
                         (:title (cl-who:str (gethash "title" blist)))
                         (:link (cl-who:str abs-url))
                         (:description (to-cdata (gethash "body" blist)))
                         (:pubDate (cl-who:str
                                    (post-date->build-date
                                     (gethash "date" blist))))
                         (:guid (cl-who:str abs-url))
                         (:|dc:creator|
                           (cl-who:str (gethash "author" blist))))))))))))
    (setf (gethash "body" rss-blist) body)
    rss-blist))
