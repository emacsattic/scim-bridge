;;; scim-bridge-ja.el  -*- coding: utf-8 -*-

;; Copyright (C) 2008, 2009, 2010 S. Irie

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: Input Method, i18n

(defconst scim-bridge-ja-version "0.8.2.13")

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

;; SCIM (Smart Common Input Method) は 30以上の言語 (CJK と多くの
;; ヨーロッパ言語) をサポートする POSIX スタイルのオペレーティングシステム
;; (Linux や BSD) のためのインプットメソッド (IM) プラットフォームです。

;; scim-brifge.el はEmacs のための SCIM-Bridge クライアントであり、 SCIM
;; を 用いた on the spot スタイルの入力を可能とするものです。入力状態は
;; 個々のバッファについて保持され、また SCIM がアクティブな状態でも C-x や
;; C-c 等のプレフィックスキーを使うことができます。したがって、ユーザーは
;; このプログラムを用いて様々な言語を速く、快適に入力することができます。

;; このプログラムをロードすることによって、 scim-bridge.el で定義される変数
;; および関数の説明文字列が日本語で書かれたものに差し替えられ、また日本語入力
;; のためのいくつかの便利なコマンドが使用できるようになります。

;; このプログラムは SCIM-Bridge の一部ではありません。

;;
;; Requirements:
;;
;;  * GNU Emacs 22 または 23
;;  * SCIM-Bridge agent (Version 0.4.13 以降)
;;
;; 注意：scim-modeはEmacsがXセッション下で実行中にのみ動作します。
;;

;;
;; Installation:
;;
;; 初めに、このファイル (scim-bridge-ja.el) 及び scim-bridge.el を
;; パスの通ったディレクトリに保存し、バイトコンパイルして下さい。
;;
;; 以下の行を .emacs ファイルに追加します。
;;
;;   (require 'scim-bridge-ja)
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;
;; EmacsでXIMを無効にするために、~/.Xresources ファイルに
;;
;;   Emacs*useXIM: false
;;
;; を追加し、Xセッションを再スタートするか、以下のシェルコマンドを実行します。
;;
;;   xrdb ~/.Xresources
;;
;;
;; .emacs ファイルの設定例です。
;;
;;   (require 'scim-bridge-ja)
;;   ;; .emacs 読込み後、 scim-mode を自動的に ON にする
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;   ;; C-SPC は Set Mark に使う
;;   (scim-define-common-key ?\C-\s nil)
;;   ;; C-/ は Undo に使う
;;   (scim-define-common-key ?\C-/ nil)
;;   ;; SCIMの状態によってカーソル色を変化させる
;;   (setq scim-cursor-color '("red" "blue" "limegreen"))
;;
;; 以下は日本語入力向けの設定です。.emacs ファイルに追加します。
;;
;;   ;; C-j で半角英数モードをトグルする
;;   (scim-define-common-key ?\C-j t)
;;   ;; SCIM-Anthy 使用時に、copy-region-as-kill しなくても再変換できるようにする
;;   (scim-define-common-key 'S-henkan nil)
;;   (global-set-key [S-henkan] 'scim-anthy-reconvert-region)
;;   ;; SCIM がオフのままローマ字入力してしまった時に、プリエディットに入れ直す
;;   (global-set-key [C-henkan] 'scim-transfer-romaji-into-preedit)
;;

;; History:
;; 2010-06-26  S. Irie
;;         * Add translations
;;         * Version 0.8.2
;;
;; 2010-05-29  S. Irie
;;         * Add/modify translations
;;         * Version 0.8.1
;;
;; 2010-04-23  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.8.0
;;
;; 2010-03-02  S. Irie
;;         * Modify translation
;;         * Version 0.7.5
;;
;; 2009-01-29  S. Irie
;;         * Add support for table.el
;;         * Modify description of installation
;;         * Version 0.7.4
;;
;; 2008-12-28  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.7.3
;;
;; 2008-12-06  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.7.2
;;
;; 2008-10-20  S. Irie
;;         * Add/modify translations
;;         * Version 0.7.1
;;
;; 2008-10-04  S. Irie
;;         * Revised Entirely
;;         * Add/modify translations
;;         * Version 0.7.0
;;
;; 2008-09-08  S. Irie
;;         * Modify translation
;;         * Version 0.6.9
;;
;; 2008-09-05  S. Irie
;;         * Version 0.6.8
;;
;; 2008-07-26  S. Irie
;;         * Some unimportant changes
;;         * Version 0.6.7
;;
;; 2008-06-12  S. Irie
;;         * Add/modify translations
;;         * Version 0.6.6
;;
;; 2008-06-05  S. Irie
;;         * Change specification for `scim-transfer-romaji-into-preedit'
;;         * Version 0.6.5
;;
;; 2008-06-01  S. Irie
;;         * Add some convenient commands for Japanese IM
;;         * Bug fix
;;         * Version 0.6.4
;;
;; 2008-05-24  S. Irie
;;         * Add translations
;;         * Bug fix
;;         * Version 0.6.3
;;
;; 2008-05-22  S. Irie
;;         * Modify description of kana-RO key
;;         * Version 0.6.2
;;
;; 2008-05-20  S. Irie
;;         * Add/modify translations
;;         * Version 0.6.1
;;
;; 2008-05-18  S. Irie
;;         * Experimental first release
;;         * Version 0.6.0
;;
;; 2008-05-15  S. Irie
;;         * Version 0.5.0

;; ToDo:

;;; Code:

(require 'scim-bridge)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Apply translations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(scim-set-group-doc
 'scim
 "洗練された多言語入力プラットフォーム")

(scim-set-variable-doc
 'scim-mode
 "scim-mode の ON/OFF を切り替えます。
この変数に値を直接代入しても正しい動作はしませんので、
 \\[customize] あるいは関数 `scim-mode' を用いてください。")

;; Basic settings

(scim-set-group-doc
 'scim-basic
 "基本的な入力方法の設定（モードの切り替え、キーボードなど）")

(scim-set-variable-doc
 'scim-mode-local
 "nil 以外ならば、入力状態を各バッファごとに切り替えることができるように、
複数の入力コンテクストが使用されます。そうでなければ、入力状態は全ての
バッファでグローバルに切り替えられます。")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 "nil 以外ならば、ミニバッファにおける入力では一時的な入力コンテクストが
用いられるので、ミニバッファでは常に SCIM がオフの状態で入力が開始されます。
このオプションは、`scim-mode-local' が活性 (non-nil) である場合のみ有効です。")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 "nil 以外ならば、isearch-mode で SCIM が使用できます。")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 "nil 以外ならば、SCIM がオフの時にASCII文字のキーイベントは SCIM では
処理されません。このオプションは他の Emacs Lisp プログラムとの衝突を避ける
ために役立ちます。")

(scim-set-variable-doc
 'scim-common-function-key-list
 "SCIM が入力状態に関らず受け取ることができるキーストロークのリストです。
このリストへの要素の追加・削除のために、関数 `scim-define-common-key' を
使うことができます。

警告：このオプションに ESC や C-x などのプレフィックスキーを設定しないで
ください。もし設定すると、これらのプレフィックスで始まるキーシーケンスが
使用できなくなります。")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 "SCIM がプリエディット中に受け取ることができるキーストロークのリストです。
このリストへの要素の追加・削除のために、関数 `scim-define-preedit-key' を
使うことができます。")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 "nil 以外ならば、jp-106 キーボードを用いて日本語のかな入力方式を行うときに
シフトキーを押さなくても仮名文字の「ろ」を入力することができます。

このオプションは、X のキーマップを変更するためにシェルコマンドの \"xmodmap\"
を用います。")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 "2つのキーストロークを同時打鍵として認識する最小の時間間隔（秒）です。
値が nil ならば、全てのキーストロークが別々のものとして認識されます。

もし SCIM-Anthy で日本語の親指シフト入力方式を使用するなら、この時間間隔を
指定しなければなりません。"
 '(choice (const :tag "なし" nil)
	  (number :tag "間隔（秒）" :value 0.1)))

(scim-set-variable-doc
 'scim-undo-by-committed-string
 "nil 以外ならば、アンドゥは確定した文字列毎に行われます。
そうでなければ、確定文字列の挿入は、`self-insert-command' をシミュレートする
ようにアンドゥ境界を毎回修正するので、アンドゥはおよそ20カラム毎に行われます。")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 "nil 以外ならば、プリエディット中に予期せぬイベントが発生した場合に
プリエディット領域が消去されます。予期せぬイベントとは、例えばマウスクリック
による文字列の貼り付けなどです。")

;; Appearance

(scim-set-group-doc
 'scim-appearance
 "外観の設定（フェイス、候補ウインドウなど）")

(scim-set-face-doc
 'scim-preedit-default-face
 "プリエディット領域の全体を表すフェイスです。")

(scim-set-face-doc
 'scim-preedit-underline-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「下線」に対応する
フェイスです。")

(scim-set-face-doc
 'scim-preedit-highlight-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「強調」に対応する
フェイスです。")

(scim-set-face-doc
 'scim-preedit-reverse-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「反転」に対応する
フェイスです。")

(scim-set-variable-doc
 'scim-cursor-color
 "SCIM の状態に対応するカーソルの色を指定します。
値が文字列ならば、SCIM がオンである時に適用されるカーソル色を表します。
コンスセルならば、その car および cdr はそれぞれ SCIM がオンあるいはオフである
時のカーソル色となります。リストならば、第1要素、第2要素、および第3要素（もし
あれば）はそれぞれ、SCIM がオン、オフ、および無効化の状態に対応します。
値が nil ならば、カーソル色は全く変更されません。"
 ;; ** Don't translate `:value' properties!! **
 '(choice (const :tag "なし（nil）" nil)
	  (color :tag "赤" :format "赤 (%{sample%})\n" :value "red")
	  (color :tag "青" :format "青 (%{sample%})\n" :value "blue")
	  (color :tag "緑" :format "緑 (%{sample%})\n" :value "limegreen")
	  (color :tag "その他" :value "red")
	  (cons  :tag "その他 (ON . OFF)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})\n" :value "blue"))
	  (list  :tag "その他 (ON OFF)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})  無効化時: なし\n"
			:value "blue"))
	  (list  :tag "その他 (ON OFF DISABLED)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})\n" :value "blue")
		 (color :format "無効化時: %v (%{sample%})\n" :value "limegreen"))))

(scim-set-variable-doc
 'scim-isearch-cursor-type
 "isearch-mode の時に適用されるカーソル形状です。
値が整数の 0 であれば、カーソル形状は変更されません。
`cursor-type' をご覧下さい。"
 '(choice (const :tag "指定しない（0）" 0)
	  (const :tag "フレームのパラメータを使用" t)
	  (const :tag "表示しない" nil)
	  (const :tag "塗りつぶされた箱型" box)
	  (const :tag "輪郭だけの箱型" hollow)
	  (const :tag "縦の棒型" bar)
	  (cons :tag "縦の棒型（幅を指定）"
		(const :format "" bar)
		(integer :tag "幅" :value 1))
	  (const :tag "水平の棒型" hbar)
	  (cons :tag "水平の棒型（高さを指定）"
		(const :format "" hbar)
		(integer :tag "高さ" :value 1))))

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 "プリエディット領域に変換候補が表示されている時に適用されるカーソル形状です。
値が整数の 0 であれば、カーソル形状は変更されません。
`cursor-type' をご覧下さい。"
 '(choice (const :tag "指定しない（0）" 0)
	  (const :tag "フレームのパラメータを使用" t)
	  (const :tag "表示しない" nil)
	  (const :tag "塗りつぶされた箱型" box)
	  (const :tag "輪郭だけの箱型" hollow)
	  (const :tag "縦の棒型" bar)
	  (cons :tag "縦の棒型（幅を指定）"
		(const :format "" bar)
		(integer :tag "幅" :value 1))
	  (const :tag "水平の棒型" hbar)
	  (cons :tag "水平の棒型（高さを指定）"
		(const :format "" hbar)
		(integer :tag "高さ" :value 1))))

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 "nil 以外ならば、プリエディット領域の選択中の文節にカーソルを表示します。
そうでなければ、プリエディット領域に変換候補が表示されている時、カーソルは
プリエディット領域の末尾に置かれます。")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 "候補ウインドウを表示する水平位置を指定します。
nil ならば通常の位置に表示します。整数ならば、候補ウィンドウが通常の位置より
も何ピクセル左方に表示されるかを示します。値が `gnome' ならば、整数値の代わり
にGNOMEデスクトップ環境のフォントサイズを使用します。

注意：このオプションは、候補ウインドウが常時表示されるようなタイプの入力方法、
例えば SCIM-pinyin 等には適していません。なぜなら、入力位置が画面の下の方に
ある時に、候補ウインドウがカーソルを覆い隠してしまう可能性があるからです。"
 '(choice (const :tag "GNOME のフォント設定を利用" gnome)
	  (integer :tag "ピクセル数を指定" :value 24)
	  (const :tag "off" nil)))

(scim-set-variable-doc
 'scim-prediction-window-position
 "SCIM-Anthy等のインプットメソッドの、予測候補ウインドウを表示する位置を
指定します。値は (POS . ADJ) のようなコンスセルでなければなりません。もし
POS が nil でなければ、ウインドウはプリエディット領域の先頭に表示されます。
ADJ が nil でなければ、ウインドウの水平位置は `scim-adjust-window-x-position'
と同様に調整されます。"
 '(cons
   (choice :tag "位置（POS）"
	   (const :tag "カーソルの直下" nil)
	   (const :tag "プリエディット領域の先頭" t))
   (choice :tag "微調整（ADJ）"
	   (const :tag "変換候補ウインドウと同様にする" t)
	   (const :tag "off" nil))))

(scim-set-variable-doc
 'scim-mode-line-string
 "scim-mode がアクティブである時にモードラインに表示される文字列です。
この文字列は、空白文字で始まり、scim-mode を表すような短い文字列でなければ
なりません。")

;; Advanced settings

(scim-set-group-doc
 'scim-expert
 "高度な設定")

(scim-set-variable-doc
 'scim-focus-update-interval
 "フレームのフォーカスを周期的に監視する時間間隔（秒）です。
SCIM がオフの時、あるいは入力フォーカスが他のアプリケーションにある時は、
`scim-focus-update-interval-long' で指定される、より遅い時間周期が代わりに
用いられます。

注意：もしお使いのウインドウマネージャが、ルートウインドウの
`_NET_ACTIVE_WINDOW' プロパティをサポートしていなければ、この値は用いられま
せん。その場合は、常に`scim-focus-update-interval-long' の値が使用されます。")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 "`scim-focus-update-interval' の代わりに用いられる、フレームのフォーカス
を周期的に監視するもう一つの時間間隔です。秒単位で指定します。これは、SCIM が
オフまたは入力フォーカスが他のアプリケーションにある時に使われる時間間隔です。")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 "日本語の「ろ」キーに対応する X KeySym の代替として用いる KeySym の
名前を指定する文字列です。値が nil の場合は、代替の KeySym は使われません。
scim-mode はこのオプションに従って、バックスラッシュキーを円記号(￥)キーと
区別するために、バックスラッシュキーに代替の KeySym を設定します。この
オプションは、jp-106 キーボードを使用する場合にのみ有効です。"
 '(choice (string :tag "KeySym 名" :value "F24")
	  (const :tag "なし" nil)))

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 "日本語の「ろ」キーのイベントを指定するシンボルまたは整数です。
値が nil の場合は、「ろ」キーを使用できません。もし `scim-kana-ro-x-keysym' に
代替の KeySym が設定されるならば、その KeySym に対応するイベントを指定しなけれ
ばなりません。このオプションは、jp-106 キーボードを使用する場合にのみ有効です。"
 '(choice (symbol :tag "シンボル" :value 'f24)
	  (integer :tag "文字コード（整数）" :value ?_)
	  (const :tag "なし" nil)))

(scim-set-variable-doc
 'scim-bridge-timeout
 "SCIM からのデータを受け取るための最大の待ち時間です。浮動小数点の数
ならば秒数を表し、整数ならばミリ秒を表します。")

(scim-set-variable-doc
 'scim-start-scim-bridge
 "SCIM-Bridge デーモンが実行中でない場合の挙動を指定します。
nil ならば何もしないので、scim-mode は即時終了します。関数ならば、もしその
関数が nil 以外を返せばデーモンを自動的に開始します。それ以外の nil でない
値ならば、無条件でデーモンを開始します。"
 '(choice (const :tag "何もしない (nil)" nil)
	  (const :tag "SCIM-Bridge を起動 (t)" t)
	  (function :tag "関数に従う"
		    (lambda ()
		      (equal (getenv "GTK_IM_MODULE") "scim-bridge")))))

(scim-set-variable-doc
 'scim-bridge-x-display-substitute
 "Xのディスプレイ番号とスクリーン番号を明示的に指定したいのでなければ、
この変数をセットしないでください。この変数を設定すると、scim-mode は
マルチディスプレイ環境で使用できなくなります。

この変数の設定値は、 \":0.0\" のような文字列でなければなりません。")

(scim-set-variable-doc
 'scim-config-file
 "SCIM の設定ファイル名です。これは SCIM の設定が変更されたことを検知する
目的で使用されます。")

(scim-set-variable-doc
 'scim-meta-key-exists
 "キーボードにmetaキーがある場合、この変数には t がセットされます。
自動検出がうまくいかない場合は、scim-bridge.el を読み込む前に手動で設定して
ください。")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 "エージェントと通信するためのワーキングバッファの名前です。")

(scim-set-variable-doc
 'scim-incompatible-major-modes
 "scim-mode のキーマップが無効化されるメジャーモードを指定するシンボルの
リストです。")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 "メジャーモードフックを指定するシンボルのリストです。これらのフックが
実行される時には scim-mode のキーマップが無効化されます。")

(scim-set-variable-doc
 'scim-preedit-incompatible-commands
 "プリエディット中に無効化されるコマンドを指定するシンボルのリストです。")

(scim-set-variable-doc
 'scim-inherit-im-functions
 "インプットメソッドを引き継ぐ関数を指定するシンボルのリストです。
関数が引数 INHERIT-INPUT-METHOD を取る場合、インプットメソッドはこの
引数が nil でない場合にのみ引き継がれます。そうでなければ、インプット
メソッドは無条件で引き継がれます。")

;; Functions

(scim-set-function-doc
 'scim-define-common-key
 "どのキーイベントが常時 SCIM へ送られるかを指定します。HANDLE が nil で
なければ、SCIM は KEY で与えられたキーイベントを処理します。KEY が配列として
与えられた場合は、キーシーケンスを表すのではなく、単独のキーストロークの複数
の定義を表します。
この設定を有効にするには、関数 `scim-update-key-bindings' を呼び出すか、
または scim-mode を再起動する必要があります。")

(scim-set-function-doc
 'scim-define-preedit-key
 "どのキーイベントがプリエディット時に SCIM へ送られるかを指定します。
HANDLE が nil でなければ、SCIM は KEY で与えられたキーイベントを処理します。
KEY が配列として与えられた場合は、キーシーケンスを表すのではなく、単独のキー
ストロークの複数の定義を表します。
この設定を有効にするには、関数 `scim-update-key-bindings' を呼び出すか、
または scim-mode を再起動する必要があります。")

(scim-set-function-doc
 'scim-enable-isearch
 "SCIM を isearch-mode で使用可能にします。")

(scim-set-function-doc
 'scim-disable-isearch
 "SCIM を isearch-mode で使用できないようにします。")

(scim-set-function-doc
 'scim-mode-on
 "scim-mode をオンにします。")

(scim-set-function-doc
 'scim-mode-off
 "scim-mode をオフにします。")

(scim-set-function-doc
 'scim-mode
 "SCIMマイナーモード (scim-mode) をトグルします。
省略可能な引数 ARG は、正の数ならば scim-mode がオンになり、
そうでなければオフになります。")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for Japanese
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
(defvar scim-anthy-reconversion-event 'S-henkan
  "この変数には、SCIM-Anthy のキーバインド設定で「再変換」に割り当てられて
いるキーイベントを設定してください。関数 `scim-anthy-reconvert-region'
で使用されます。")

(defvar scim-toggle-input-method-event ?\C-\s
  "この変数には、SCIM のキーバインド設定で「SCIM 開始」に割り当てられて
いるキーイベントを設定してください。関数 `scim-transfer-romaji-into-preedit'
で使用されます。")

;; Functions
(defun scim-anthy-reconvert-region ()
  "SCIM-Anthy の使用時に、バッファ内の文字列を再変換します。
マークが活性ならばマークとポイントの位置を変換範囲の両端とし、そうでなければ
ポイントの位置にある文節が変換対象となります。再変換のためのキーイベントは、
変数 `scim-anthy-reconversion-event' で指定されます。"
  (interactive "*")
  (when (and (stringp scim-imcontext-id)
	     (not scim-mode-map-prev-disabled))
    (if mark-active
	(call-interactively 'copy-region-as-kill)
      (unless (memq (following-char) (append "。、．，？！）」)]}\n" nil))
	(while (and (forward-word)
		    (string-match "[ぁ-ん][ー・]"
				  (concat (list (preceding-char)
						(following-char)))))))
      (let ((end (point)))
	(while (and (backward-word)
		    (string-match "[ぁ-ん][ー・]"
				  (concat (list (preceding-char)
						(following-char))))))
	(copy-region-as-kill (point) end)))
    (scim-dispatch-key-event scim-anthy-reconversion-event)))

(defun scim-transfer-romaji-into-preedit (end-point)
  "バッファ内の指定位置にあるローマ字の文字列を削除すると同時に、その文字列
をキーイベントキューの先頭に追加し、SCIM をオンにします。この関数を用いると、
バッファ内の文字列をキー入力として SCIM に渡すことができます。
END-POINT は文字列の片端のバッファ内位置を指定します。インタラクティブに呼び
出された場合はポイント位置の値が代入されます。マークが活性であれば、対象となる
文字列はマークと END-POINT の位置を両端とし、そうでなければ END-POINT から
行の先頭に向かってローマ字列の開始位置を検索します。SCIM を切り替えるための
キーイベントは、変数 `scim-toggle-input-method-event' で指定されます。"
  (interactive "d*")
  (unless scim-imcontext-status
    (scim-dispatch-key-event scim-toggle-input-method-event))
  (cond
   (isearch-mode
    (setq unread-command-events
	  (append (list ?a 'scim-resume-preedit)
		  (this-command-keys)
		  unread-command-events)
	  mark-active nil))
   ((and (stringp scim-imcontext-id)
	 (not scim-mode-map-prev-disabled))
    (goto-char end-point)
    (let* ((beg (if mark-active
		    (mark)
		  (skip-chars-backward "a-z-,.!?")
		  (point)))
	   (str (buffer-substring-no-properties beg end-point)))
      (cond
       ((and (boundp 'table-mode-indicator)
	     table-mode-indicator)
	(scim-*table--cell-delete-region beg end-point))
       (t
	(delete-region beg end-point)))
      (setq unread-command-events
	    (append str unread-command-events))))))

(provide 'scim-bridge-ja)

;;;
;;; scim-bridge-ja.el ends here
