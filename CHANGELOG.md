# Language-Blodwen Changelog

## Next version

### Added

### Fixed

## v0.4.10

### Added
 - Display typechecking information 
 - Copy executable path to clipboard
 - Syntax highlitning in message panel
 - Proof clause
 - higlightning of parameters
 - Better support for literate blodwen
 - Added snippets

### Fixed
 - Display error message from blodwen
 - Blodwen now restarts if stopped
 - fix comments highlightning 

## v0.4.9

### Added

- Allow incomplete data definition
- Add record and rewrite keywords
- Support literate files
- Add cast snippet

### Fixed

- Indent after do/where/if/then/else/of
- Save file state when executing commands

## v0.4.8

### Fixed
- Fix proof search
- Remove deprecated selector

## v0.4.7

### Added

- REPL and package documentation [#146](https://github.com/blodwen-hackers/atom-language-blodwen/pull/146) (@allancto)
- Additional commands in menu [#142](https://github.com/blodwen-hackers/atom-language-blodwen/pull/142) (@joheinz)

### Fixed

- Crashes with Atom 1.13.0 [#149](https://github.com/blodwen-hackers/atom-language-blodwen/pull/149) (@melted)
- 'import public' syntax [#145](https://github.com/blodwen-hackers/atom-language-blodwen/pull/145) (@joheinz)

## v0.4.6

### Added

- Report type checking status
- Snippets
- Navigate to error
- Highlight error

### Fixed

- Styling of error messages
- ipkg grammar

## v0.4.5

### Added

### Fixed

- Many different processes are spawned [#114](https://github.com/blodwen-hackers/atom-language-blodwen/issues/114) (@pyrtsa)
- use 'cmd' instead of 'alt' on osx (@karljs)

## v0.4.4

### Added

- Make apropos view results scrollable [#109](https://github.com/blodwen-hackers/atom-language-blodwen/pull/109) (@justjoheinz)
- Codecompletion via autocomplete-plus [#98](https://github.com/blodwen-hackers/atom-language-blodwen/pull/98) (@justjoheinz)
- Replace deprecated abstract keyword with export [#101](https://github.com/blodwen-hackers/atom-language-blodwen/pull/101) (@justjoheinz)
- Add snippets for the most common interface implementations [#99](https://github.com/blodwen-hackers/atom-language-blodwen/pull/99) (@justjoheinz)

### Fixed

- Nested with blocks [#112](https://github.com/blodwen-hackers/atom-language-blodwen/issues/112)
- Fix passing packages in ipkg files [#111](https://github.com/blodwen-hackers/atom-language-blodwen/pull/111)

## v0.4.3

### Added

### Fixed

- After closing panel once with "X" icon, it no longer appears for type checking/inspection [#90](https://github.com/blodwen-hackers/atom-language-blodwen/issues/90) (@justjoheinz)

## v0.4.2

### Added

- syntax highlighting for constructors [#95](https://github.com/blodwen-hackers/atom-language-blodwen/pull/95)

### Fixed

## v0.4.1

### Added

- class and instance to interface and implementation (@justjoheinz)

### Fixed

## v0.4.0

### Added

- Added a REPL [#80](https://github.com/blodwen-hackers/atom-language-blodwen/pull/80)
- Added a panel for the `apropos` command

### Fixed

## v0.3.4

### Added

### Fixed

- Added a better description for the path to the blodwen executable in the settings
- Fixed the highlighting of comments
- Fix the highlighting of documentation comments [#82](https://github.com/blodwen-hackers/atom-language-blodwen/pull/82) (@geo2a)
- Initial clause is inserted in wrong place for functions with multiline type annotation. [#72](https://github.com/blodwen-hackers/atom-language-blodwen/issues/72)

## v0.3.3

### Added

### Fixed

- Most commands throw exceptions on Windows 8.1 (@aochagavia)

## v0.3.2

### Added

- parse the new `pkgs`option in the ipkg file [blodwen-lang/Blodwen-dev/pull/2668](https://github.com/blodwen-lang/Blodwen-dev/pull/2668)

### Fixed

## v0.3.1

### Added

### Fixed

- get documentation or types for operators [#66](https://github.com/blodwen-hackers/atom-language-blodwen/issues/66)
- removed the statusbar [#67](https://github.com/blodwen-hackers/atom-language-blodwen/issues/67)

## v0.3.0

### Added

- Add a means of setting the Blodwen -p option [#29](https://github.com/blodwen-hackers/atom-language-blodwen/issues/29)

### Fixed

## v0.2.5

### Added

- Restart the blodwen compiler after every commmand if it was killed [#54](https://github.com/blodwen-hackers/atom-language-blodwen/pull/54)
- added the ability to style all the blodwen-panels

### Fixed

- Status message should appear only in blodwen projects [#52](https://github.com/blodwen-hackers/atom-language-blodwen/issues/52) many thanks to @jeremy-w

## v0.2.4

### Added

### Fixed

- Uncaught ReferenceError: editor is not defined [#49](https://github.com/blodwen-hackers/atom-language-blodwen/issues/49)
- Error when searching for type, documentation [#37](https://github.com/blodwen-hackers/atom-language-blodwen/issues/37)

## v0.2.3

### Added

- make-with (@edwinb)
- make-case (@edwinb)
- make-lemma (@edwinb)

### Fixed

- Uncaught Error: Can't save buffer with no file path [#47](https://github.com/blodwen-hackers/atom-language-blodwen/issues/47)
- save files before executing a command (@edwinb)
- The Blodwen Errors panel should tell me if typechecking went successfully [#43](https://github.com/blodwen-hackers/atom-language-blodwen/issues/43) (@edwinb)

## v0.2.2

### Added

### Fixed

- fix the new error messages

## v0.2.1

### Added

- `print-definition` to show the definition of the selected word
- add error messages when the compiler crashes/can't be found

### Fixed

## v0.2.0

### Added

- status indicator that shows if a file is loaded or dirty
- metavariables are now called holes

### Fixed

- fixed bug in the parser when there where backslashes in the answer [#32](https://github.com/blodwen-hackers/atom-language-blodwen/issues/32) (@david-christiansen)
- Program not loaded before running interactive editing commands [#34](https://github.com/blodwen-hackers/atom-language-blodwen/issues/34)
- faster startup [#28](https://github.com/blodwen-hackers/atom-language-blodwen/issues/28)

## v0.1.4

### Added

- new metavariable view (`Language Blodwen: Metavariables`)
- a tutorial that explains how to use this package
- context menu for `Language Blodwen: Type Of` and `Language Blodwen: Docs For`

### Fixed

- `Language Blodwen: Proof Search` and `Language Blodwen: Add Clause`
- deprecations that now broke the editor because of the dropped API methods

## v0.1.3

### Added

### Fixed

- Better syntax highlighting
- fixed the parser for the ide-mode lisp
- fixed [#18](https://github.com/blodwen-hackers/atom-language-blodwen/issues/18)
- fixed [#19](https://github.com/blodwen-hackers/atom-language-blodwen/issues/19)
- fixed an issue with the error lines not being clickable in the error panel

## v0.1.1

### Added

- Type and doc info highlighting https://github.com/blodwen-hackers/atom-language-blodwen/pull/9 (@archaeron)

### Fixed

- Ensure that keybindings only work on Blodwen files (#2)
- Syntax highlighting for infix functions
- Fixed a crash when blodwen was not installed

## v0.1.0

### Added

- Shortcut to Show the doc of a variable (ctrl-alt-d)

### Fixed

- updated for the new version of Atom (@archaeron)
- new parser for the ide-mode commands (@archaeron)
- new serializer for the ide-mode commands (@archaeron)
- various fixes (@ulidtko)

## v0.0.1

### Added

- Case-splitting (ctrl-alt-c) (@fangel)
- Clause-adding (ctrl-alt-a) (@fangel)
- Proof-search (ctrl-alt-s) (@fangel)
- Showing the types of meta-variables (ctrl-alt-t) (@fangel)
- Show the doc of a variable (@fangel)
