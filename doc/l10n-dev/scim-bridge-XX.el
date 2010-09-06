;;; scim-bridge-XX.el  -*- coding: utf-8 -*-

;; Copyright (C) 2008, 2009, 2010 S. Irie
;; Copyright (C) YEAR TRANSLATOR

;; Author: S. Irie
;; Maintainer: TRANSLATOR
;; Keywords: Input Method, i18n

(defconst scim-bridge-XX-version "0.8.2.12")

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; It is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
;; MA  02110-1301 USA

;;; Commentary:

;; The Smart Common Input Method platform (SCIM) is an input
;; method (IM) platform containing support for more than thirty
;; languages (CJK and many European languages) for POSIX-style
;; operating systems including Linux and BSD.

;; scim-bridge.el is a SCIM-Bridge client for Emacs. It allows
;; users on-the-spot style input with SCIM. The input statuses are
;; individually kept for each buffer, and prefix-keys such as C-x
;; and C-c can be used even if SCIM is active. So you can input
;; various languages fast and comfortably by using it.

;; This program changes the documentation strings of the variables
;; and functions defined in scim-bridge.el into the equivalents
;; which are written in English.

;; This program is *not* a part of SCIM-Bridge.

;;
;; Requirements:
;;
;;  * GNU Emacs 22 or 23
;;  * SCIM-Bridge agent (Version 0.4.13 or later)
;;
;; Note that scim-mode works only when Emacs is running under X session.
;;

;;
;; Installation:
;;
;; First, save this file (scim-bridge-XX.el) and scim-bridge.el
;; in a directory listed in load-path, and then byte-compile them.
;;
;; Put the following in your .emacs file:
;;
;;   (require 'scim-bridge-XX)
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;
;; To disable XIM in Emacs, put the following in ~/.Xresources:
;;
;;   Emacs*useXIM: false
;;
;; and restart X session or execute a shell command:
;;
;;   xrdb ~/.Xresources
;;
;;
;; Here is the example of settings in .emacs:
;;
;;   (require 'scim-bridge-XX)
;;   ;; Turn on scim-mode automatically after loading .emacs
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;   ;; Use C-SPC for Set Mark command
;;   (scim-define-common-key ?\C-\s nil)
;;   ;; Use C-/ for Undo command
;;   (scim-define-common-key ?\C-/ nil)
;;   ;; Change cursor color depending on SCIM status
;;   (setq scim-cursor-color '("red" "blue" "limegreen"))
;;

;; History:
;; YEAR-MM-DD  TRANSLATOR
;;         * Initial release
;;         * Version 0.8.2

;; ToDo:

;;; Code:

(require 'scim-bridge)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Apply translations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(scim-set-group-doc
 'scim
 ;; "The Smart Common Input Method platform"
 "")

(scim-set-variable-doc
 'scim-mode
 ;; "Toggle scim-mode.
 ;;Setting this variable directly does not take effect;
 ;;use either \\[customize] or the function `scim-mode'."
 "")

;; Basic settings

(scim-set-group-doc
 'scim-basic
 ;; "Settings of operation, such as mode management and keyboard"
 "")

(scim-set-variable-doc
 'scim-mode-local
 ;; "Non-nil means input statuses can be individually switched at each
 ;;buffer by using multiple input contexts. Otherwise, the input status
 ;;is globally changed for all buffers."
 "")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 ;; "Non-nil means use one-time input context at minibuffer so that
 ;;the minibuffer input starts with SCIM's input status off. This option
 ;;is ineffectual unless `scim-mode-local' is non-nil."
 "")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 ;; "Non-nil means SCIM can be used together with isearch-mode."
 "")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 ;; "If non-nil, ASCII character events are not handled when SCIM is off.
 ;;This option is useful for avoiding conflict with the other Emacs-Lisp
 ;;programs."
 "")

(scim-set-variable-doc
 'scim-common-function-key-list
 ;; "List of keystrokes that SCIM takes over regardless of input status.
 ;;To add or remove the elements, you should use a function
 ;;`scim-define-common-key'. Note that `meta' modifier in the element
 ;;doesn't indicate alt keys but actual meta key.
 ;;
 ;;WARNING: Don't set an entry of prefix key such as ESC and C-x, or
 ;;key sequences starting with the prefix become unusable."
 "")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 ;; "List of keystrokes that SCIM takes over only when preediting.
 ;;To add or remove the elements, you should use a function
 ;;`scim-define-preedit-key'. Note that `meta' modifier in the element
 ;;doesn't indicate alt keys but actual meta key."
 "")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 ;; "Non-nil means you can input a kana-RO character (\"ろ\")
 ;;without pushing the shift key when using Japanese kana typing method
 ;;with jp-106 keyboard.
 ;;
 ;;This option uses a shell command \"xmodmap\" to modify X's keymap."
 "")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 ;; "Maximum time interval that two keystrokes are recognized as a
 ;;simultaneous keystroke. Measured in seconds. The value nil means
 ;;any keystrokes are recognized as separate ones.
 ;;
 ;;You must specify the time interval if using Japanese thumb shift
 ;;typing method with SCIM-Anthy."
 ""
 ;; '(choice (const :tag "none" nil)
 ;;	  (number :tag "interval (sec.)" :value 0.1))
 )

(scim-set-variable-doc
 'scim-undo-by-committed-string
 ;; "Non-nil means perform undoing to each committed string.
 ;;Otherwise, insertions of committed strings modify undo boundaries to
 ;;simulate `self-insert-command' so that undo is performed by nearly 20
 ;;columns."
 "")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 ;; "If non-nil, clear preediting area when an unexpected event happens.
 ;;The unexpected event is, for example, string insertion by mouse clicking."
 "")

;; Appearance

(scim-set-group-doc
 'scim-appearance
 ;; "Faces, candidate window, etc."
 "")

(scim-set-face-doc
 'scim-preedit-default-face
 ;; "Face indicating the whole of the preediting area."
 "")

(scim-set-face-doc
 'scim-preedit-underline-face
 ;; "Face corresponding to the text attribute \"Underline\" in SCIM GUI
 ;;Setup Utility."
 "")

(scim-set-face-doc
 'scim-preedit-highlight-face
 ;; "Face corresponding to the text attribute \"Highlight\" in SCIM GUI
 ;;Setup Utility."
 "")

(scim-set-face-doc
 'scim-preedit-reverse-face
 ;; "Face corresponding to the text attribute \"Reverse\" in SCIM GUI
 ;;Setup Utility."
 "")

(scim-set-variable-doc
 'scim-cursor-color
 ;; "Specify cursor color(s) corresponding to SCIM's status.
 ;;If the value is a string, specify the cursor color applied when SCIM is
 ;;on. If a cons cell, its car and cdr are the cursor colors which indicate
 ;;that SCIM is on and off, respectively. If a list, the first, second and
 ;;third (if any) elements correspond to that SCIM is on, off and disabled,
 ;;respectively. The value nil means don't change the cursor color at all."
 ""
 ;;;; ** Don't translate `:value' properties!! **
 ;; '(choice (const :tag "none (nil)" nil)
 ;;	  (color :tag "red" :format "red (%{sample%})\n" :value "red")
 ;;	  (color :tag "blue" :format "blue (%{sample%})\n" :value "blue")
 ;;	  (color :tag "green" :format "green (%{sample%})\n" :value "limegreen")
 ;;	  (color :tag "other" :value "red")
 ;;	  (cons  :tag "other (ON . OFF)"
 ;;		 (color :format "ON: %v (%{sample%})  " :value "red")
 ;;		 (color :format "OFF: %v (%{sample%})\n" :value "blue"))
 ;;	  (list  :tag "other (ON OFF)"
 ;;		 (color :format "ON: %v (%{sample%})  " :value "red")
 ;;		 (color :format "OFF: %v (%{sample%})  DISABLED: none\n"
 ;;			:value "blue"))
 ;;	  (list  :tag "other (ON OFF DISABLED)"
 ;;		 (color :format "ON: %v (%{sample%})  " :value "red")
 ;;		 (color :format "OFF: %v (%{sample%})\n" :value "blue")
 ;;		 (color :format "DISABLED: %v (%{sample%})\n" :value "limegreen")))
 )

(scim-set-variable-doc
 'scim-isearch-cursor-type
 ;; "Cursor shape which is applied when isearch-mode is active.
 ;;A value of integer 0 means don't change the cursor shape.
 ;;See `cursor-type'."
 ""
 ;; '(choice (const :tag "don't specify (0)" 0)
 ;;	  (const :tag "use frame parameter" t)
 ;;	  (const :tag "don't display" nil)
 ;;	  (const :tag "filled box" box)
 ;;	  (const :tag "hollow box" hollow)
 ;;	  (const :tag "vertical bar" bar)
 ;;	  (cons :tag "vertical bar (specify width)"
 ;;		(const :format "" bar)
 ;;		(integer :tag "width" :value 1))
 ;;	  (const :tag "horizontal bar" hbar)
 ;;	  (cons :tag "horizontal bar (specify height)"
 ;;		(const :format "" hbar)
 ;;		(integer :tag "height" :value 1)))
 )

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 ;; "Cursor shape which is applied when showing conversion candidates
 ;;within the preediting area. A value of integer 0 means don't change
 ;;the cursor shape.
 ;;See `cursor-type'."
 ""
 ;; '(choice (const :tag "don't specify (0)" 0)
 ;;	  (const :tag "use frame parameter" t)
 ;;	  (const :tag "don't display" nil)
 ;;	  (const :tag "filled box" box)
 ;;	  (const :tag "hollow box" hollow)
 ;;	  (const :tag "vertical bar" bar)
 ;;	  (cons :tag "vertical bar (specify width)"
 ;;		(const :format "" bar)
 ;;		(integer :tag "width" :value 1))
 ;;	  (const :tag "horizontal bar" hbar)
 ;;	  (cons :tag "horizontal bar (specify height)"
 ;;		(const :format "" hbar)
 ;;		(integer :tag "height" :value 1)))
 )

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 ;; "Non-nil means put cursor on a selected segment of preediting area.
 ;;Otherwise, the cursor is put to the tail of the preediting area when
 ;;showing conversion candidates."
 "")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 ;; "Specify horizontal position in which a candidate window is shown.
 ;;Nil means show the window at the normal position. The value of integer
 ;;indicates how many pixels the window appears to the left than the normal
 ;;position. If the value is `gnome', use a font size of GNOME desktop
 ;;environment instead of the integer.
 ;;
 ;;Note that the non-nil value is not suitable for input methods that the
 ;;candidate window is always displayed such as SCIM-pinyin, because the
 ;;window might hide the cursor when it is on the bottom of screen."
 ""
 ;; '(choice (const :tag "use GNOME's font size" gnome)
 ;;	  (integer :tag "specify by pixel number" :value 24)
 ;;	  (const :tag "off" nil))
 )

(scim-set-variable-doc
 'scim-prediction-window-position
 ;; "Specify position showing a prediction window of some input methods
 ;;such as SCIM-Anthy. The value must be a cons cell like (POS . ADJ).
 ;;If POS is non-nil, the window is displayed under the start point of
 ;;preediting area. ADJ non-nil means the horizontal position of the window
 ;;is adjusted same as `scim-adjust-window-x-position'."
 ""
 ;; '(cons
 ;;   (choice :tag "Position"
 ;;	   (const :tag "Below cursor" nil)
 ;;	   (const :tag "Head of preediting area" t))
 ;;   (choice :tag "Adjustment"
 ;;	   (const :tag "same as conversion window" t)
 ;;	   (const :tag "off" nil)))
 )

(scim-set-variable-doc
 'scim-mode-line-string
 ;; "String that appears in the mode line when scim-mode is active.
 ;;This string should be a short string which starts with a space and
 ;;represents scim-mode."
 "")

;; Advanced settings

(scim-set-group-doc
 'scim-expert
 ;; "Advanced settings"
 "")

(scim-set-variable-doc
 'scim-focus-update-interval
 ;; "Time interval (in seconds) for checking frame focus periodically.
 ;;When SCIM is off or input focus is in the other application, the slower
 ;;time cycle given by `scim-focus-update-interval-long' is used instead.
 ;;
 ;;Note that this value is not used if your window manager does not
 ;;support a root window's property `_NET_ACTIVE_WINDOW'. In that case,
 ;;`scim-focus-update-interval-long' is used at all times."
 "")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 ;; "Another time interval for checking frame focus periodically, which
 ;;is used instead of `scim-focus-update-interval'. Measured in seconds.
 ;;This value specifies the slower time cycle used when SCIM is off or
 ;;input focus is in the other application."
 "")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 ;; "String specifying a name of X keysym which is used as a substitute
 ;;of keysym corresponding to Japanese kana-RO key. The value nil means don't
 ;;use the substitutive keysym. scim-mode modifies X's keymap according to
 ;;this option in order to distinguish backslash key from yen-mark key. This
 ;;option is ineffectual unless using jp-106 keyboard."
 "")

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 ;; "Symbol or integer specifying an event of Japanese kana-RO key.
 ;;The value nil means don't use that key. If setting `scim-kana-ro-x-keysym'
 ;;a substitutive X keysym, you must specify the event corresponding to that
 ;;keysym. This option is ineffectual unless using jp-106 keyboard."
 ""
 ;; '(choice (symbol)
 ;;	  (const :tag "none" nil))
 )

(scim-set-variable-doc
 'scim-bridge-timeout
 ;; "Maximum waiting time for data reception from SCIM.
 ;;A floating point number means the number of seconds, otherwise an integer
 ;;the milliseconds."
 "")

(scim-set-variable-doc
 'scim-start-scim-bridge
 ;; "Specify what to do for SCIM-Bridge daemon not running.
 ;;The value nil means do nothing, so scim-mode will stop immediately.
 ;;If the value is a function, start the daemon automatically if the
 ;;function returns non-nil and the daemon is not running. The other
 ;;non-nil value means start the daemon unconditionally."
 ""
 ;; '(choice (const :tag "Do nothing (nil)" nil)
 ;; 	  (const :tag "Start SCIM-Bridge (t)" t)
 ;; 	  (function :tag "According to function"
 ;; 		    (lambda ()
 ;; 		      (equal (getenv "GTK_IM_MODULE") "scim-bridge"))))
 )

(scim-set-variable-doc
 'scim-bridge-x-display-substitute
 ;; "Don't set this variable unless you want to explicitly specify the
 ;;X display number and screen number. Setting this variable makes
 ;;scim-mode unusable in multi-display environment.
 ;;
 ;;If you set this variable, the value must be a string such as \":0.0\"."
 "")

(scim-set-variable-doc
 'scim-config-file
 ;; "The name of SCIM's configuration file, which is used to detect
 ;;the change of SCIM settings."
 "")

(scim-set-variable-doc
 'scim-meta-key-exists
 ;; "t is set in this variable if there is mata modifier key in the
 ;;keyboard. When automatic detection doesn't go well, please set the
 ;;value manually before scim-bridge.el is loaded."
 "")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 ;; "This is working buffer name used for communicating with the agent."
 "")

(scim-set-variable-doc
 'scim-incompatible-major-modes
 ;; "List of symbols specifying major modes that keymaps of scim-mode are
 ;;deactivated."
 "")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 ;; "List of symbols specifying major mode hooks that keymaps of scim-mode
 ;;are deactivated when invoking these hooks."
 "")

(scim-set-variable-doc
 'scim-preedit-incompatible-commands
 ;; "List of symbols specifying commands which are disabled when preediting."
 "")

(scim-set-variable-doc
 'scim-inherit-im-functions
 ;; "List of symbols specifying functions which inherit input method.
 ;;If the function takes the argument INHERIT-INPUT-METHOD, input method
 ;;is inherited only when it's non-nil. Otherwise, input method is
 ;;unconditionally inherited."
 "")

;; Functions

(scim-set-function-doc
 'scim-define-common-key
 ;; "Specify which key events SCIM anytime takes over. If HANDLE
 ;;is non-nil, SCIM handles the key events given by KEY. When KEY is
 ;;given as an array, it doesn't indicate key sequence, but multiple
 ;;definitions of single keystroke.
 ;; It is necessary to call a function `scim-update-key-bindings' or
 ;;restart scim-mode so that this settings may become effective."
 "")

(scim-set-function-doc
 'scim-define-preedit-key
 ;; "Specify which key events SCIM takes over when preediting. If
 ;;HANDLE is non-nil, SCIM handles the key events given by KEY. When
 ;;KEY is given as an array, it doesn't indicate key sequence, but
 ;;multiple definitions of single keystroke.
 ;; It is necessary to call a function `scim-update-key-bindings' or
 ;;restart scim-mode so that this settings may become effective."
 "")

(scim-set-function-doc
 'scim-enable-isearch
 ;; "Make SCIM usable with isearch-mode."
 "")

(scim-set-function-doc
 'scim-disable-isearch
 ;; "Make SCIM not usable with isearch-mode."
 "")

(scim-set-function-doc
 'scim-mode-on
 ;; "Turn scim-mode on."
 "")

(scim-set-function-doc
 'scim-mode-off
 ;; "Turn scim-mode off."
 "")

(scim-set-function-doc
 'scim-mode
 ;; "Toggle SCIM minor mode (scim-mode).
 ;;With optional argument ARG, turn scim-mode on if ARG is
 ;;positive, otherwise turn it off."
 "")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for TARGET_LANGUAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings

;; Functions

;;  (THIS SECTION IS OPTIONAL)

(provide 'scim-bridge-XX)

;;;
;;; scim-bridge-XX.el ends here
