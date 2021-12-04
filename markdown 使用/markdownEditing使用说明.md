## README.md

# MarkdownEditing

Markdown plugin for Sublime Text. Provides a decent Markdown color scheme (light and dark) with more **robust** syntax highlighting and useful Markdown editing features for Sublime Text. 3 flavors are supported: Standard Markdown, **GitHub flavored Markdown**, MultiMarkdown.

[![MarkdownEditing](https://camo.githubusercontent.com/35a66d68a55666133ba7911fb0ea61277740680f/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f6c696768742e706e67)](https://camo.githubusercontent.com/35a66d68a55666133ba7911fb0ea61277740680f/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f6c696768742e706e67)

[Dark](https://raw.github.com/SublimeText-Markdown/MarkdownEditing/master/screenshots/dark.png) and [Yellow](https://raw.github.com/SublimeText-Markdown/MarkdownEditing/master/screenshots/yellow.png) and [ArcDark](https://raw.github.com/SublimeText-Markdown/MarkdownEditing/master/screenshots/arcdark.png) theme available, plus [thirdparty themes](https://github.com/SublimeText-Markdown/MarkdownEditing#additional-color-themes). See [configuration](https://github.com/SublimeText-Markdown/MarkdownEditing#configuration) section to learn **how to change the theme**.

## Overview

- Installation
  - [Package Control](https://github.com/SublimeText-Markdown/MarkdownEditing#package-control)
  - [Manual Installation](https://github.com/SublimeText-Markdown/MarkdownEditing#manual-installation)
- Features
  - [Markdown features](https://github.com/SublimeText-Markdown/MarkdownEditing#markdown-features)
  - [Wiki features](https://github.com/SublimeText-Markdown/MarkdownEditing#wiki-features)
- [Key Bindings](https://github.com/SublimeText-Markdown/MarkdownEditing#key-bindings)
- [GFM Specific Features](https://github.com/SublimeText-Markdown/MarkdownEditing#gfm-specific-features)
- Commands for Command Palette
  - [General Commands](https://github.com/SublimeText-Markdown/MarkdownEditing#general-commands)
  - [Links, References and Footnotes](https://github.com/SublimeText-Markdown/MarkdownEditing#links-references-and-footnotes)
  - [Folding and Navigation](https://github.com/SublimeText-Markdown/MarkdownEditing#folding-and-navigation)
- Configuration
  - [Additional color themes:](https://github.com/SublimeText-Markdown/MarkdownEditing#additional-color-themes)
- [Tips](https://github.com/SublimeText-Markdown/MarkdownEditing#tips)
- [Enable WYSIWYG](https://github.com/SublimeText-Markdown/MarkdownEditing#enable-wysiwyg)
- Troubleshooting
  - [Error loading syntax file...](https://github.com/SublimeText-Markdown/MarkdownEditing#error-loading-syntax-file)
  - [Roll back to an older version](https://github.com/SublimeText-Markdown/MarkdownEditing#roll-back-to-an-older-version)
- [Related Plugins](https://github.com/SublimeText-Markdown/MarkdownEditing#related-plugins)
- [Known Bugs](https://github.com/SublimeText-Markdown/MarkdownEditing#known-bugs)
- [Contributing](https://github.com/SublimeText-Markdown/MarkdownEditing#contributing)
- [Credits](https://github.com/SublimeText-Markdown/MarkdownEditing#credits)
- [Donation](https://github.com/SublimeText-Markdown/MarkdownEditing#donation)
- [License](https://github.com/SublimeText-Markdown/MarkdownEditing#license)

## Installation

You can install MarkdownEditing either from Package Control (recommended) or manually. Package Control automatically download the package and keeps it up-to-date. Manual installation is required if you need to tweak the code.

If you are using Sublime Text 2, you have to disable the native package *manually*. To do that, add `Markdown` to your `ignored_packages` list in ST user settings:

```
"ignored_packages": [..., "Markdown"],
```

> Getting "Error loading syntax file..."? See [this](https://github.com/SublimeText-Markdown/MarkdownEditing#error-loading-syntax-file).

### Package Control

The preferred method of installation is via [Sublime Package Control](http://wbond.net/sublime_packages/package_control).

1. [Install Sublime Package Control](http://wbond.net/sublime_packages/package_control/installation)
2. From inside Sublime Text, open Package Control's Command Pallet: CTRL SHIFT P (Windows, Linux) or CMD SHIFT P on Mac.
3. Type `install package` and hit Return. A list of available packages will be displayed.
4. Type `MarkdownEditing` and hit Return. The package will be downloaded to the appropriate directory.
5. Restart Sublime Text to complete installation. Open a Markdown file and this custom theme. The features listed below should now be available.

### Manual Installation

1. In Sublime Text, open the menu "Preferences" -> "Browse Packages...". This is the Sublime Text Packages directory.
2. [Download and unzip](https://github.com/SublimeText-Markdown/MarkdownEditing/archive/master.zip) or [clone](https://help.github.com/articles/cloning-a-repository/) this repository to a directory `MarkdownEditing` in the Sublime Text Packages directory.
3. The folder structure should look like `.../Sublime Text 3/Packages/MarkdownEditing/[files]`.
4. Restart Sublime Text to complete installation. Open a Markdown file. The features listed below should now be available.

## Features

You can access most features through Command Palette. You can launch it from `Tools -> Command Palette...`. MarkdownEditing commands start with `MarkdownEditing:`. And they are only visible when a markdown file is open and active.

### Markdown features

- Pairing
  - Asterisks and underscores are autopaired and will wrap selected text.
  - If you start an empty pair and hit backspace, both elements are deleted.
  - If you start an empty pair and hit space, the right element is deleted.
  - Backticks are paired. So entering ``` will expand to ``(cursor here)``.
- List
  - At the end of a list item, pressing Enter will automatically insert the new list item bullet.
  - Pressing Tab on the blank list item will indent it and switch the list bullet to another one (Order is `*`, `-`, `+` in a cycle).
  - Pressing Shift Tab on the blank list item will unindent it in the same way as above.
  - Sequential Tab s or Shift Tab s are supported.
  - You can disable automatic bullet switching or choose which bullets to be used, in your settings file (`mde.list_indent_bullets`).
  - If a list item contains a [GFM task](https://github.github.com/gfm/#task-list-items-extension-), pressing Enter at the end of the line will continue with a new blank task.
- Blockquote
  - At the end of a blockquote line, pressing Enter will automatically extend blockquote.
  - Selecting some text and pressing > will convert it to blockquote. The first and the last line don't have to be fully selected; partial select works, too.
- Link
  - Left bracket pairing is modified to eliminate the selection and leave the cursor at a point where you can insert a `[]` or `()` pair for a link.
  - If you leave the cursor on a link, you can right click and jump between reference and url.
- Navigation
  - Displays Markdown headers in the Project Symbol List (`Goto -> Goto Symbol in Project...`). They will start with `#`, so you will know they belong to markdown files at a glance. Also they will be on top of the list because of the precedence of `#`.
  - Headers also appear in Document Symbol List (`Goto -> Goto Symbol...`)
  - You can fold current section with Ctrl Tab
  - You can navigate between adjacent headers with `Find Next(Previous) Heading` command.
- Strikethrough
  - ~ wraps selected text with `~~` (strikethrough). When you for instance select the word "foo" and hit `~`, the result will be `~~foo~~`.
- Header
  - Typing `#` when there's a selection will surround it with `#` to make it a headline. Multiple presses add additional hashes, increasing the level of the header. Once you hit 6 hashes, it will reset to 0 on the next press. The `mde.match_header_hashes` will determine if the `#` are mirrored on both sides or just at the beginning of the line.
  - Typing return at the end of a line that begins with hashmarks will insert closing hashmarks on the headline. They're not required for Markdown, it's just aesthetics, and you can change the `mde.match_header_hashes` option in your settings to enable (disabled by default).
  - Setext-style headers can be completed with `Tab`. That is, typing `Tab` on a line containing only `=` or `-` characters will add or remove enough characters to it to match the length of the line above.
  - New documents will be named automatically based on the first header.

### Wiki features

Wiki links are defined by surrounding a (wiki) word with double square brackets, for example:

```
[[SampleWikiPage]]
```

The user can `open` wiki page using a sublime command. This will search the current open file's directory (and sub-directories) for a file with a matching name and a markdown extension. For example, opening the previous wiki link will look for and open a file named:

```
SampleWikiPage.md
```

Note that, if the wiki page does *not* yet exist, if will be created with a header matching the page name. However the file will only actually be created on the file system, when it is saved by the user.

The user can `list back links` and of course to open them. Back links are pages that reference the current page. This allows pages to be tied together into a personal wiki. A common technique is to define *tag* wiki pages and to list any tags for a page as references to the tag pages at the bottom of the page, for example:

```
[[TagSyntax]] [[TagDev]] [[TagPython]]
```

This allows the user to list all pages with a specific tag, by opening the tag page and list all back links.

Journal wiki pages are also supported. A journal page is just a wiki page with a name matching the current date.

Lastly the command to open the *home* page is provided, where the home page is just a wiki page named `HomePage`.

## Key Bindings

| OS X                | Windows/Linux                           | Description                                                  |
| ------------------- | --------------------------------------- | ------------------------------------------------------------ |
| ⌘⌥V                 | CtrlAltV                                | Creates or pastes the contents of the clipboard as an inline link on selected text. |
| ⌘⌥R                 | CtrlAltR                                | Creates or pastes the contents of the clipboard as a reference link. |
| ⌘⇧K                 | ShiftWinK                               | Creates or pastes the contents of the clipboard as an inline image on selected text. |
| ⌘⌥B ⌘⌥I             | AltB AltI                               | These are bound to bold and italic. They work both with and without selections. If there is no selection, they will just transform the word under the cursor. These keybindings will unbold/unitalicize selection if it is already bold/italic. |
| ⌘^1...6             | Ctrl1...6                               | These will add the corresponding number of hashmarks for headlines. Works on blank lines and selected text in tandem with the above headline tools. If you select an entire existing headline, the current hashmarks will be removed and replaced with the header level you requested. This command respects the `mde.match_header_hashes` preference setting. |
| ⌥⇧6                 | AltShift6                               | Inserts a footnote.                                          |
| ⇧Tab                | ShiftTab                                | Fold/Unfold current section.                                 |
| ^⇧Tab               | CtrlShiftTab                            | Fold all sections under headings of a certain level.         |
| ⌘⌥PageUp ⌘⌥PageDown | CtrlAltShiftPageUp CtrlAltShiftPageDown | Go to the previous/next heading of the same or higher level  |
| ⌘⇧PageUp ⌘⇧PageDown | CtrlShiftPageUp CtrlShiftPageDown       | Go to the previous/next heading                              |
| ⌘⌥H                 | CtrlShiftH                              | Open home page                                               |
| ⌘⌥D                 | CtrlShiftD                              | Open wiki page under the cursor                              |
| ⌘⌥J                 | CtrlShiftJ                              | Open journal page for today                                  |
| ⌘⌥B                 | CtrlShiftB                              | List back links                                              |

## GFM Specific Features

[GFM](https://github.github.com/gfm/) means GitHub Flavored Markdown is the dialect of Markdown that is currently supported for user content on GitHub.com and GitHub Enterprise. It has [some unique features](https://guides.github.com/features/mastering-markdown/):

Underscores in words doesn't mess with bold or italic style:

[![underscore-in-words](https://camo.githubusercontent.com/8b17f26aca3c8be400ee51876569317991bb4481/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f756e64657273636f72652d696e2d776f7264732e706e67)](https://camo.githubusercontent.com/8b17f26aca3c8be400ee51876569317991bb4481/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f756e64657273636f72652d696e2d776f7264732e706e67)

Fenced code blocks gets syntax highlighting inside:

[![fenced-code-block](https://camo.githubusercontent.com/09752fcead5673444f36c6941d40c0855bd9d6f2/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f66656e6365642d636f64652d626c6f636b2e706e67)](https://camo.githubusercontent.com/09752fcead5673444f36c6941d40c0855bd9d6f2/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f66656e6365642d636f64652d626c6f636b2e706e67)

Keyboard shortcuts gets highlighted like in GitHub:

[![keyboard-shortcut](https://camo.githubusercontent.com/1736780dbd719f4ed04eae4dab370a990276170b/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f6b6579626f6172642d73686f72746375742e706e67)](https://camo.githubusercontent.com/1736780dbd719f4ed04eae4dab370a990276170b/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f6b6579626f6172642d73686f72746375742e706e67)

Strikethrough is supported:

[![strikethrough](https://camo.githubusercontent.com/1120fb1ff19b090f88bc92d78447f60b4e5f51c2/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f737472696b657468726f7567682e706e67)](https://camo.githubusercontent.com/1120fb1ff19b090f88bc92d78447f60b4e5f51c2/68747470733a2f2f7261772e6769746875622e636f6d2f5375626c696d65546578742d4d61726b646f776e2f4d61726b646f776e45646974696e672f6d61737465722f73637265656e73686f74732f737472696b657468726f7567682e706e67)

## Commands for Command Palette

You can launch Command Palette from `Tools -> Command Palette...`. MarkdownEditing commands start with `MarkdownEditing:`. And they are only visible when a markdown file is open and active.

### General Commands

- **Fix Underlined Headers** Adjusts every setext-style header to add or remove `=` or `-` characters as needed to match the lengths of their header text.
- **Convert Underlined Headers to ATX** Converts every setext-style header into an ATX style header. If something is selected only the headers in the selections will be converted, otherwise the conversion will be applied to the whole view.
- **Markdown Lint** Performs lint on current Markdown file using a local linter. See [lint rules](https://github.com/SublimeText-Markdown/MarkdownEditing/blob/master/lint_docs/RULES.md). Some of the linting rules are customizable via user settings file.
- **Run markdownlint** Run mdl command from [markdownlint](https://github.com/markdownlint/markdownlint) package. You need to install it by yourself.
- **Change color scheme...** Lists built-in Markdown color schemes for you to preview and use.
- **Switch List Bullet Type** Switches the highlighted list between numbered and bulleted style.

### Links, References and Footnotes

- **Add Missing Link Labels** Scans document for referenced link usages (`[some link][some_ref]` and `[some link][]`) and checks if they are all defined. If there are undefined link references, command will automatically create their definition snippet at the bottom of the file.
- **Magic Footnotes Command** Adds a footnote after the word under cursor. If cursor is already on a footnote, jumps to its definition or reference.
- **Gather Missing Footnotes** Add definition stubs (if there is none) for all footnotes references.
- **Jump Reference** Jumps cursor between definitions and references.
- **New Reference** Adds a new link under cursor.
- **New Inline Link** Adds a new inline link under cursor.
- **New Inline Image** Adds a new inline image under cursor.
- **New Image** Adds a new image under cursor.
- **New Footnote** Adds a footnote under cursor.
- **Delete Reference** Deletes the definition and references of a link.
- **Organize References** Sorts and gives a report on current link references usage.

### Folding and Navigation

Remember you can Ctrl R (in document) and Ctrl Shift R (project-wise) for quick navigation for all headers.

- **Toggle Folding Current Section** Folds/unfolds current section.
- **Fold Level 1-4 Sections** Fold all sections under headers of specific level.
- **Fold/Unfold All Sections** Self explanatory.
- **Find Next/Previous Heading** You have option to find just same or higher level or any level

## Configuration

The plugin contains 3 different Markdown flavors: Standard Markdown, GitHub flavored Markdown, MultiMarkdown. Default is GitHub flavored Markdown. If you want to set another one as default, open a Markdown file and select your flavor from the menu: `View > Syntax > Open all with current extension as`. You're done.

You may want to have a look at the default settings files. They are located at:

```
Packages/MarkdownEditing/Markdown.sublime-settings         [GitHub flavored Markdown]
Packages/MarkdownEditing/Markdown (Standard).sublime-settings
Packages/MarkdownEditing/MultiMarkdown.sublime-settings
```

If you want to override any of the default settings, you can open the appropriate user settings file using the `Preferences > Package Settings > Markdown Editing` menu. Each flavor has a different settings file.

Bold and italic markers are configurable through ST shell variables. You can use `Preferences > Package Settings > Markdown Editing` menu to see the default settings file. In order to override it, copy & paste its content into the user settings file (`Packages/User/Bold and Italic Markers.tmPreferences`) from the menu and make your edits. It is pretty straightforward.

In order to activate the dark or the yellow theme, put one of these lines to your user settings file of the flavor (`Packages/User/[flavor].sublime-settings`):

```
"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Yellow.tmTheme",
"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-ArcDark.tmTheme",
```

If you want to go with your already existing theme, you can reenable it with the same method as above. Keep in mind that, that theme may not cover all the parts of the Markdown syntax that this plugin defines.

### Additional color themes:

- [Blackboard theme](https://github.com/mdesantis/MarkdownEditing/blob/blackboard-theme/MarkdownEditor-Blackboard.tmTheme) by [@mdesantis](https://github.com/mdesantis)
- [monokaiC](https://github.com/avivace/monokaiC) by [@avivace](https://github.com/avivace)

By default, when you install the plugin, files with these extensions will be assigned to Markdown syntax: "md", "txt", "mdown", "markdown", "markdn". If you want to prevent any of these extensions to be opened as Markdown, follow these steps:

1. Click on the language menu at bottom right
2. Select "Open all with current extension as"
3. Choose your preferred syntax for that extension

## Tips

We are maintaining a [tips section](https://github.com/SublimeText-Markdown/MarkdownEditing/wiki/Tips) in our [Wiki](https://github.com/SublimeText-Markdown/MarkdownEditing/wiki). Jump there to learn from others or share your experiences with others.

## Enable WYSIWYG

Sublime can be configured into a WYSIWYG (what you see is what you get) editor with two other plugins:

1. Markdown Preview ([https://packagecontrol.io/packages/Markdown%20Preview](https://packagecontrol.io/packages/Markdown Preview))
2. Livereload (https://packagecontrol.io/packages/LiveReload)

Install them if you haven't. Then

1. Open Palette
2. LiveReload: Enable/Disable Plugins
3. Enable Simple Reload.

Now open palette and choose "Preview in Browser" and you will get a WYSIWYG editor.

## Troubleshooting

### Error loading syntax file...

**Are you getting this error after installation: \**\*Error loading syntax file\** "Packages/Markdown/Markdown.tmLanguage": Unable to open Packages/Markdown/Markdown.tmLanguage\*?**

> This is caused by open markdown files at the install time. You have to **manually change their syntax to your newly installed Markdown syntax**. Read the below paragraph for more details on this.

*Note*: Sublime text has a native tiny package for Markdown. However, when MarkdownEditing is enabled, native package causes some conflicts. For this reason, MarkdownEditing will automatically disable it. Since it doesn't bring anything new over MarkdownEditing, this is not a loss. But remember, when you disable MarkdownEditing, you have to reenable the native one manually (if you want).

### Roll back to an older version

When you notice any undesired behavior introduced by the latest update, your feedback is always welcome in our [issue page](https://github.com/SublimeText-Markdown/MarkdownEditing/issues). However before it's fixed, you can rollback to [an earlier version](https://github.com/SublimeText-Markdown/MarkdownEditing/releases). Find the desired version and download the zip file, then follow [manual installation guide](https://github.com/SublimeText-Markdown/MarkdownEditing#manual-installation)

## Related Plugins

- [Knockdown](https://github.com/aziz/knockdown/)

  Knockdown offers useful Markdown features and a custom Markdown theme. All of its unique features except its theme are ported to MarkdownEditing and some of them are actually improved further in MarkdownEditing.

- [Sublime Markdown Extended](https://github.com/jonschlinkert/sublime-markdown-extended)

- [SmartMarkdown](https://github.com/demon386/SmartMarkdown)

- [MarkdownTOC](https://github.com/naokazuterada/MarkdownTOC)

  - Sublime Text 3 plugin for generating a Table of Contents (TOC) in a Markdown document.

- See https://packagecontrol.io/search/markdown for more.

## Known Bugs

- Setext-style headers (`===` and `---`) do not show up in the symbol list. This is due to a Sublime Text limitation (see [#158](https://github.com/SublimeText-Markdown/MarkdownEditing/issues/158)). However, we are able to put a placeholder to indicate the existence of the header. We encourage you to use Atx-style headers (`#`).
- Installing for the first time while having markdown files opened may cause MarkdownEditing to behave unexpectedly on those files. Close and reopen those files to fix it.

## Contributing

See `CONTRIBUTING.md` file.

## Credits

MarkdownEditing was originally created by [Brett Terpstra](http://brettterpstra.com/) and has become a community project with the goal of consolidating the best features from the varied collection of Markdown packages for Sublime Text. Current development is headed up by [Ali Ayas](https://github.com/maliayas) and [Felix Hao](https://github.com/felixhao28).

Related blog posts from Brett:

- http://brettterpstra.com/2012/05/17/markdown-editing-for-sublime-text-2-humble-beginnings/
- http://brettterpstra.com/2013/11/23/markdownediting-for-sublime-text-updates/

This plugin contains portions of code from [Knockdown](https://github.com/aziz/knockdown/).

Footnote commands were submitted by [J. Nicholas Geist](https://github.com/jngeist) and originated at [geekabouttown](http://geekabouttown.com/posts/sublime-text-2-markdown-footnote-goodness).

## Donation

You can support [contributors](https://github.com/SublimeText-Markdown/MarkdownEditing/graphs/contributors) of this project individually. Every contributor is welcomed to add his/her line below with any content. Ordering shall be alphabetically by GitHub username.

- [@felixhao28](https://github.com/felixhao28): [![[paypal\]](https://camo.githubusercontent.com/bce14c8e2e39ba0464551b34602b4c60c182526b/68747470733a2f2f7777772e70617970616c6f626a656374732e636f6d2f656e5f55532f692f62746e2f62746e5f646f6e6174655f4c472e676966)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=9QV2RFV2J8UZS)
- [@maliayas](https://github.com/maliayas): [![[paypal\]](https://camo.githubusercontent.com/bce14c8e2e39ba0464551b34602b4c60c182526b/68747470733a2f2f7777772e70617970616c6f626a656374732e636f6d2f656e5f55532f692f62746e2f62746e5f646f6e6174655f4c472e676966)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=W2NXRPD43YSCU&lc=TR&item_name=open-source&item_number=markdown-editing&currency_code=USD&bn=PP-DonationsBF%3abtn_donate_LG.gif%3aNonHosted) [![donation received](https://camo.githubusercontent.com/63e7fa0bb09b3ff62dd2fd23af746b77a22bd846/687474703a2f2f6d616c69617961732e636f6d2f627573696e6573732f646f6e6174696f6e2f62616467652e7068703f70726f6a6563743d6d61726b646f776e5f65646974696e67)](https://camo.githubusercontent.com/63e7fa0bb09b3ff62dd2fd23af746b77a22bd846/687474703a2f2f6d616c69617961732e636f6d2f627573696e6573732f646f6e6174696f6e2f62616467652e7068703f70726f6a6563743d6d61726b646f776e5f65646974696e67)

## License

MarkdownEditing is released under the [MIT License](http://www.opensource.org/licenses/MIT).