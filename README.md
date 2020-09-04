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

This mode can be enabled for basically every buffer, but currently only Elixir `mix` projects (via elixir-mode) and OCaml projects (via tuareg-mode) based on `opam` and `dune` are supported.
On other code or project it just saves the buffer.

To execute TCR on a buffer use the key sequence: `C-t c`.
This will first save the buffer and then execute the tests plus either `git commit` or `git reset --hard`.

If your buffer has Magit enabled the buffer is reverted on external changes automatically.
If no Magit you might have to enable `auto-revert-mode`.

After the first execution of `tcr-execute` you can view the "TCR out" buffer for test output.
