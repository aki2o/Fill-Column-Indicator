;;; fci-osx-23-fix.el --- workaround for fci-mode on Mac OS X, v23.0-2

;; Copyright (c) 2011 Alp Aker 

;; Author: Alp Aker <alp.tekin.aker@gmail.com>
;; Version: 1.61
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; A copy of the GNU General Public License can be obtained from the
;; Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; You should only need to use this if you're using fill-column-indicator
;; with the Mac OS X (NextStep) port, versions 23.0 through 23.2.  (It is
;; *not* needed with v22.)  To use it, simply place this file in your load
;; path and put
;;
;;   (require 'fci-osx-23-fix)
;;
;; in your .emacs.  

(require 'fill-column-indicator)

(defvar fci-nextstep-23-hack-cache nil)
(make-variable-buffer-local 'fci-nextstep-23-hack-cache)

(defun fci-nextstep-23-hack ()
  (when fci-nextstep-23-hack-cache 
    (overlay-put fci-nextstep-23-hack-cache 
                 'after-string
                 (overlay-get fci-nextstep-23-hack-cache 'fci-after-string))
    (setq fci-nextstep-23-hack-cache nil))
  (when (and (not fci-newline-sentinel)
             (= (current-column) fci-limit)
						 (setq fci-nextstep-23-hack-cache (fci-overlay-at-point)))
    (overlay-put fci-nextstep-23-hack-cache 'fci-after-string
                 (overlay-get fci-nextstep-23-hack-cache 'after-string))
    (overlay-put fci-nextstep-23-hack-cache 'after-string nil)))

(defun fci-overlay-at-point ()
	(car (fci-get-overlays-region (point) (point))))

(add-to-list 'fci-hook-assignments 
             '(post-command-hook . fci-nextstep-23-hack))

(provide 'fci-osx-23-fix)
