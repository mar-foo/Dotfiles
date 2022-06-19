;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules
 (gnu home)
 (gnu packages)
 (gnu packages shells)
 (gnu services)
 (guix gexp)
 (gnu home services)
 (ice-9 textual-ports))

(home-environment
 (packages
  (specifications->packages
   (list "bemenu"
	 "emacs-guix"
	 "emacs-next-pgtk"
	 "fontconfig"
	 "font-ibm-plex"
	 "font-liberation"
	 "foot"
	 "fortune-mod"
	 "fzf"
	 "gnupg"
	 "icecat"
	 "isync"
	 "mpv"
	 "msmtp"
	 "neomutt"
	 "notmuch"
	 "password-store"
	 "pavucontrol"
	 "pinentry-bemenu"
	 "profanity"
	 "swaybg"
	 "swayidle"
	 "tmux"
	 "ungoogled-chromium-wayland"
	 "vis")))
 (services
  (list (simple-service 'mail-config
			home-xdg-configuration-files-service-type
			(list `("msmtp/config"
				,(local-file "/home/mario/src/guix-home/mail/msmtp-config"))
			      `("mutt/mbsyncrc"
				,(local-file "/home/mario/src/guix-home/mail/mbsyncrc"))
			      `("mutt/muttrc"
				,(local-file "/home/mario/src/guix-home/mail/muttrc"))
			      `("mutt/mutt-wizard.muttrc"
				,(local-file "/home/mario/src/guix-home/mail/mutt-wizard.muttrc"))
			      `("mutt/mailcap"
				,(local-file "/home/mario/src/guix-home/mail/mailcap"))
			      `("mutt/accounts/1-mario.forzanini@studenti.unimi.it.muttrc"
				,(local-file "/home/mario/src/guix-home/mail/1-mario.forzanini_studenti.unimi.it.muttrc"))
			      `("mutt/accounts/2-mf@marioforzanini.com.muttrc"
				,(local-file "/home/mario/src/guix-home/mail/2-mf_marioforzanini.com.muttrc"))))
	(simple-service 'de-config
			home-xdg-configuration-files-service-type
			(list `("sway/config"
				,(local-file "/home/mario/src/guix-home/de/sway-config"))
			      `("foot/foot.ini"
				,(local-file "/home/mario/src/guix-home/de/foot.ini"))))
	(simple-service 'term-config
			home-files-service-type
			(list `(".mkshrc"
                                ,(local-file "/home/mario/src/guix-home/term/mkshrc"))
                              `(".tmux.conf"
                                ,(local-file "/home/mario/src/guix-home/term/tmux.conf"))))
	(simple-service 'env-vars
			home-environment-variables-service-type
			`(("MBSYNCRC" . "$HOME/.config/mutt/mbsyncrc")
			  ("SHELL" . ,(file-append mksh "/bin/mksh"))
			  ("WLR_DRM_BACKEND" . "/dev/card/dri0")
			  ("PATH" . "$HOME/bin/sh:$PATH"))))))
