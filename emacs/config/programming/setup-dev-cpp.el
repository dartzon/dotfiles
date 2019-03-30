;; ========================================================
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

;; ========================================================

(require 'company)
(global-company-mode)

;; ========================================================

(require 'flycheck)
(flycheck-mode)

;; ========================================================

(require 'lsp)
(require 'lsp-clients)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;; ========================================================

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; ========================================================

(require 'company-lsp)
(push 'company-lsp company-backends)
(setq company-lsp-async t
      company-lsp-enable-snippet t
      company-lsp-enable-recompletion t
      company-transformers nil
      company-lsp-cache-candidates nil)

(provide 'setup-dev-cpp)
