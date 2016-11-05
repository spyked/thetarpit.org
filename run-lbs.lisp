;; Tarpit Lisp Blog Scaffolding
;;
;; A static blog generator, example SBCL script file.

;; Load files
(load "config.lisp")
(load "blog.lisp")

;; Process everything
(tlbs-process-everything)
