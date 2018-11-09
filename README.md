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

#### vscode keybinding
```
// Place your key bindings in this file to overwrite the defaults
[
    {
        "key": "meta+w",
        "command": "editor.action.addSelectionToNextFindMatch",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+d",
        "command": "-editor.action.addSelectionToNextFindMatch",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+shift+k",
        "command": "-editor.action.deleteLines",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+y",
        "command": "editor.action.copyLinesDownAction",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+shift+alt+down",
        "command": "-editor.action.copyLinesDownAction",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+shift+l",
        "command": "workbench.action.editor.changeLanguageMode"
    },
    {
        "key": "ctrl+k m",
        "command": "-workbench.action.editor.changeLanguageMode"
    },
    {
        "key": "shift+meta+h",
        "command": "workbench.action.previousEditor"
    },
    {
        "key": "ctrl+pageup",
        "command": "-workbench.action.previousEditor"
    },
    {
        "key": "shift+meta+l",
        "command": "workbench.action.nextEditor"
    },
    {
        "key": "ctrl+pagedown",
        "command": "-workbench.action.nextEditor"
    },
    {
        "key": "ctrl+r",
        "command": "editor.action.startFindReplaceAction"
    },
    {
        "key": "ctrl+h",
        "command": "-editor.action.startFindReplaceAction"
    },
    {
        "key": "ctrl+shift+r",
        "command": "workbench.action.replaceInFiles",
        "when": "!editorFocus"
    },
    {
        "key": "ctrl+shift+h",
        "command": "-workbench.action.replaceInFiles",
        "when": "!editorFocus"
    },
    {
        "key": "ctrl+shift+r",
        "command": "workbench.action.replaceInFilesWithSelectedText",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+shift+h",
        "command": "-workbench.action.replaceInFilesWithSelectedText",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+h",
        "command": "workbench.action.openRecent"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.openRecent"
    },
    {
        "key": "ctrl+h",
        "command": "workbench.action.quickOpenNavigateNextInRecentFilesPicker",
        "when": "inQuickOpen && inRecentFilesPicker"
    },
    {
        "key": "ctrl+r",
        "command": "-workbench.action.quickOpenNavigateNextInRecentFilesPicker",
        "when": "inQuickOpen && inRecentFilesPicker"
    },
    {
        "key": "ctrl+shift+h",
        "command": "workbench.action.quickOpenNavigatePreviousInRecentFilesPicker",
        "when": "inQuickOpen && inRecentFilesPicker"
    },
    {
        "key": "ctrl+shift+r",
        "command": "-workbench.action.quickOpenNavigatePreviousInRecentFilesPicker",
        "when": "inQuickOpen && inRecentFilesPicker"
    },
    {
        "key": "ctrl+alt+b",
        "command": "editor.action.formatDocument",
        "when": "editorTextFocus && !editorReadonly"
    },
    {
        "key": "ctrl+shift+i",
        "command": "-editor.action.formatDocument",
        "when": "editorTextFocus && !editorReadonly"
    }
]
```
