# emacs-tcr-mode
Test &amp;&amp; Commit || Revert minor mode plugin for Emacs.

This is a Emacs minor mode implementation for the TCR workflow as described here:
https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864

There is no package on Elpa or Melpa.
To install it clone this to some local folder and initialize like this in Emacs:

```
(use-package tcr-mode
  :load-path "~/.emacs.d/plugins/tcr-mode")
```

When done you have a minor mode called `tcr-mode`.

This mode can be enabled for basically every buffer. Only then it takes effect.
The plugin has to be configured with hooks, like this:

```
(use-package tcr-mode
  :load-path "~/.emacs.d/plugins/tcr-mode"
  :init
  (add-hook 'lfeunit-test-success-hook 'tcr-run-vcr-commit)
  (add-hook 'lfeunit-test-failure-hook 'tcr-run-vcr-revert))
```

`tcr-mode` can be enabled for specific hooks. Plugins like:

- [LFEUnit](https://github.com/mdbergmann/emacs-lfeunit)
- [BloopUnit](https://github.com/mdbergmann/emacs-bloopunit)
- [OcamlUnit](https://github.com/mdbergmann/emacs-ocamlunit)

expose hooks for failed or succeeded test runs, so the above configuration run `tcr-run-vcr-commit` or `tcr-run-vcr-revert` function when success or failure hooks are run from those plugins.

If your buffer has Magit enabled the buffer is reverted on external changes automatically.
If no Magit you might have to enable `auto-revert-mode`.
