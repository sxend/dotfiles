# sxend's dotfiles

## run command:

    curl --insecure https://raw.githubusercontent.com/sxend/dotfiles/master/install.sh | bash

### install atom
```
wget -O atom.deb https://atom.io/download/deb
yes | sudo dpkg -i atom.deb

# apt-get -f --force-yes --yes install # if you needs
# yes | sudo dpkg -i atom.deb          # retry

yes | apm update
apm install atom-beautify atom-ctags atom-scalariform atom-typescript autocomplete-java browser-plus build-sbt hyperclick intentions java-importer language-scala language-scala-plus linter sbt scala-format symbols-view

rm atom.deb
```

#### atom keybinding
```
'atom-text-editor:not([mini])':
  'ctrl-d': 'editor:delete-line'
'atom-workspace atom-text-editor:not([mini])':
  'ctrl-y': 'editor:duplicate-lines'
'.platform-win32 atom-text-editor, .platform-linux atom-text-editor':
  'cmd-w': 'find-and-replace:select-next'
'body':
  'cmd-shift-l': 'pane:show-next-item'
  'cmd-shift-h': 'pane:show-previous-item'

```
