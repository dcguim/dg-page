;; set the package installation repository in the dgpage repo folder
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; melpa
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; init package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install dependencies
(package-install 'htmlize)


(require 'ob-shell)
(org-babel-do-load-languages
 'org-babel-load-languages '((latex . t)
			     (java . t)))

;; configurations for html export for dgpage
(require 'ox-publish)
(setq org-publish-project-alist
 '(
   ("org-notes"
    :recursive t
    :base-directory "~/work/dgpage/org/"
    :base-extension "org"
    :publishing-directory "~/work/dgpage/static"
    :publishing-function org-html-publish-to-html
    :headline-levels 4
    :auto-preamble t
    :with-author nil
    :with-toc nil
    :section-number nil
    :time-stamp-file t)
   ("org-static"
    :base-directory "~/work/dgpage/org/static"
    :base-extension "css\\|js\\|png\\|ttf\\|txt\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
    :publishing-directory "~/work/dgpage/static"
    :recursive t
    :publishing-function org-publish-attachment)
   ("dgpage" :components ("org-notes" "org-static"))
   ))
(setq org-html-validation-link nil
      org-html-self-link-headlines nil
      org-html-htmlize-output-type 'css)

(org-publish-all t)



