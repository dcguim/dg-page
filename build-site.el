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
    :with-autor nil
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
(setq org-html-validation-link nil)
(setq org-html-self-link-headlines nil)
(org-publish-all t)



