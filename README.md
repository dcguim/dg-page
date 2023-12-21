# dg-page
Simple static webserver for a personal learning diary

## Porting this to differnt environments
The `publish.sh` file loads the init file `build-site.el`, note that if you
simply call `emacs` command it will use the init file located at `~/.emacs`. This
might impact the packages available to build this site.

The path to the binaries must be configured, in order to properly port this, for
instance an ubuntu machine using aptitude package manager might require in the
`build-site.el` the following emacs `exec-path` configuration:

```
(setq exec-path (append exec-path '("/opt/local/bin")))
```

while a mac using homebrew the following:

```
(setq exec-path (append exec-path '("/opt/homebrew/")))
```



