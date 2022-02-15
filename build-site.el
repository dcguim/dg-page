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
(package-install 'auctex)
(load "auctex.el" nil t t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 

;; set the path for the latex macports executables
(setq exec-path (append exec-path '("/opt/local/bin")))
;; solve the error "Not enough arguments to format string"
(with-eval-after-load 'org
  (plist-put org-format-latex-options :foreground "Black")
  (plist-put org-format-latex-options :background "Transparent"))

(setq org-latex-create-formula-image-program 'imagemagick)
(setq org-preview-latex-default-process 'imagemagick)
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

(require 'ob-shell)
(org-babel-do-load-languages
 'org-babel-load-languages '((latex . t)
			     (java . t)))

;; fix problem with org-html-publish-to-html latex pictures
(with-eval-after-load 'org
(defun org--get-display-dpi ()
  "Get the DPI of the display.
The function assumes that the display has the same pixel width in
the horizontal and vertical directions."
  (if (display-graphic-p)
      (round (/ (display-pixel-height)
        (/ (display-mm-height) 25.4)))
    96.0)))

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
    :base-directory "~/work/dgpage/org"
    :base-extension "css\\|js\\|png\\|ttf\\|txt\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
    :publishing-directory "~/work/dgpage/static"
    :recursive t
    :publishing-function org-publish-attachment)
   ("dgpage" :components ("org-notes" "org-static"))
   ))
(setq org-html-validation-link nil
      org-html-self-link-headlines nil
      org-html-htmlize-output-type 'css
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/static/style.css\"/>
                     <link rel=\"stylesheet\" type=\"text/css\" href=\"/static/code.css\"/>")

(org-publish-all t)



