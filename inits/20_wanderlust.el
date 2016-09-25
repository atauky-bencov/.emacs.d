;; IMAP サーバの設定

(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "atauky@gmail.com") ; gmailのアカウントを
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t) ; 日本語フォルダ対策
(setq ssl-program-name "gnutls-cli")
(setq ssl-program-arguments '("-p" service host))
					; update 2010.01.14
					;(setq ssl-program-name "openssl")
					;(setq ssl-program-arguments '("s_client" "-quiet" "-host" host "-port" service))

;; SMTP サーバの設定
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "atauky") ; メールアドレスの@より前の部分
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

;; unique message-id
(setq wl-from "atauky@gmail.com")

;; デフォルトのフォルダ
(setq wl-default-folder "%inbox")

;; フォルダ名補完時に使用するデフォルトのスペック
(setq wl-default-spec "%")
(setq wl-trash-folder "%[Gmail]/ごみ箱")

;; 下書きディレクトリをローカルに設定する.
(setq wl-draft-folder "+Drafts")
;; 送信済みIMAPフォルダは送信と同時に既読にする
(setq wl-fcc-force-as-read t)
;; 非同期でチェックするように
(setq wl-folder-check-async t)

;; %inboxで削除してもメールが削除されるわけではない
(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))

;; 大きなメッセージを分割して送信しない(デフォルトはtで分割する)
(setq mime-edit-split-message nil)
;; 警告無しに開けるメールサイズの最大値(デフォルト：30K)
(setq elmo-message-fetch-threshold 1000000)
;; プリフェッチ時に確認を求めるメールサイズの最大値(デフォルト：30K)
(setq wl-prefetch-threshold 1000000)

;; サマリで自分が差出人であるmailをTo:xxと表示する
(setq wl-summary-showto-folder-regexp ".*")
(setq wl-summary-from-function 'wl-summary-default-from)

;; OutlookExpressで送信されたメールの日本語添付ファイル名を開く
(setq mime-header-accept-quoted-encoded-words t)

;; 3ペイン表示
(setq wl-stay-folder-window t)
(setq wl-folder-window-width 35)

;;;------------------------------------------
;; summary-mode ですべての header を一旦除去
(setq mime-view-ignored-field-list '("^.*"))

;; 表示するヘッダ
(setq wl-message-visible-field-list
      (append mime-view-visible-field-list
	      '("^Subject:" "^From:" "^To:" "^Cc:"
		"^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
		"^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:"
		)))

;; 隠すメールヘッダを指定
(setq wl-message-ignored-field-list
      (append mime-view-ignored-field-list
	      '(".*Received:" ".*Path:" ".*Id:" "^References:"
		"^Replied:" "^Errors-To:"
		"^Lines:" "^Sender:" ".*Host:" "^Xref:"
		"^Content-Type:" "^Content-Transfer-Encoding:"
		"^Precedence:"
		"^Status:" "^X-VM-.*:"
		"^X-Info:" "^X-PGP" "^X-Face-Version:"
		"^X-UIDL:" "^X-Dispatcher:"
		"^MIME-Version:" "^X-ML" "^Message-I.:"
		"^Delivered-To:" "^Mailing-List:"
		"^ML-Name:" "^Reply-To:" "Date:"
		"^X-Loop" "^X-List-Help:"
		"^X-Trace:" "^X-Complaints-To:"
		"^Received-SPF:" "^Message-ID:"
		"^MIME-Version:" "^Content-Transfer-Encoding:"
		"^Authentication-Results:"
		"^X-Priority:" "^X-MSMail-Priority:"
		"^X-Mailer:" "^X-MimeOLE:"
		)))

;; 添付ファイルがあると『@』を表示する
(setq elmo-msgdb-extra-fields
      (cons "content-type" elmo-msgdb-extra-fields))
(setq wl-summary-line-format-spec-alist
      (append wl-summary-line-format-spec-alist
	      '((?@ (wl-summary-line-attached)))))
(setq wl-summary-line-format
      "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")

;; Gmailと同じように"!"で、迷惑メール送り
(defun st-wl-summary-refile-spam ()
  (interactive)
  (wl-summary-refile (wl-summary-message-number) "%[Gmail]/迷惑メール")
  (wl-summary-next))
(define-key wl-summary-mode-map "!" 'st-wl-summary-refile-spam)
(define-key wl-summary-mode-map "M-u" 'wl-summary-mark-as-unread)

;; 起動時からオフラインにする
(setq wl-plugged nil)
