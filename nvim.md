# Key Mappings for Neovim Config

- [Normal Mode](#normal-mode)
  - [Motions](#motions)
    - [Text Objects](#text-objects)
  - [Scrolling](#scrolling)
  - [Actions](#actions)
    - [Double-Callable](#double-callable)
    - [Non-Double-Callable](#non-double-callable)
  - [Change History](#change-history)
  - [Macros](#macros)
  - [Search](#search)
    - [Window](#window)
    - [Global](#global)
  - [Windows](#windows)
  - [Tabs](#tabs)
  - [File Browser](#file-browser)
  - [Code Interactions](#code-interactions)
  - [Wrappers](#wrappers)
    - [Git](#git)
- [Insert Mode](#insert-mode)
- [Visual Mode](#visual-mode)
- [Command Mode](#command-mode)
- [Terminal Mode](#terminal-mode)

### Legend

- The mnemonics are inside parentheses in square brackets ([like this]);
- `N` means a number with arbitrary number of digits when it’s used in
  conjunction with other keys and in `letterOrN`;
- `<c-...>` means Control (⌃);
- `<m-...>` means Alt/Option (⌥) ([m]odify).

## Non-Normal Mode

- `<c-[>` — go to normal mode.

## Normal Mode

`N` is optional.

- `v` — enter Visual mode ([v]isual);

- `V` — enter linewise Visual mode;

- `<c-v>` — enter blockwise Visual mode;

- `:` — enter Command mode;

- `ZZ` — quit and write/quit and save;

- `ZQ` — quit without writing/quit without saving;

- `q:` — open editable command history (`[:]`);

- `gv` — select the previous visual selection;

- `yp` — yank path ([y]ank [p]ath)/copy path;

- `gf` — go to the currently open file location in Finder ([g]o ... [F]inder);

- `S` — synchronize plugins ([s]ynchronize);

- `;l` — load the session for `cwd` ([l]oad);

- `s` — start search which narrows the pool of matches on every key press where
  a key corresponds to a dynamic label, and jump as soon as a match isn’t
  ambiguous ([s]earch).

### Motions

- `h` — a character left ([left]);

- `N` `h` — `N` characters left ([left]);

- `j` — a line down ([`j` has the descender]);

- `N` `j` — `N` lines down ([`j` has the descender]);

- `k` — a line up ([`k` has the ascender]);

- `N` `k` — `N` lines up ([`k` has the ascender]);

- `l` — a character right ([right]);

- `N` `l` — `N` characters right ([right]);

- `w` — a `word` forward (`[w]ord`);

- `N` `w` — `N` `word`s forward (`[w]ord`);

- `e` — forward to the end of the `word` ([e]nd);

- `N` `e` — forward to the end of the `N`th `word` ([e]nd);

- `E` — forward to the end of the `WORD`;

- `N` `E` — forward to the end of the `N`th `WORD`;

- `b` — a `word` backward ([b]ackward);

- `N` `b` — `N` `word`s backward ([b]ackward);

- `B` — a `WORD` backward;

- `N` `B` — `N` `WORD`s backward;

- `ge` — backward to the end of the previous `word` ([e]nd);

- `N` `ge` — backward to the end of the `N`th previous `word` ([e]nd);

- `gE` — backward to the end of the previous `WORD`;

- `N` `gE` — backward to the end of the `N`th previous `WORD`;

- `gg` — go to the first line;

- `N` `gg` — go to the `N`th line from the first one;

- `G` — go to the last line;

- `N` `G` — go to the `N`th line;

- `H` — go to the highest line on the screen;

- `N` `H` — go to the `N`th line from the highest one on the screen;

- `M` — go to the middle line on the screen;

- `N` `M` — go to the `N`th line from the middle one on the screen;

- `L` — go to the lowest line on the screen;

- `N` `L` — go to the `N`th line from the lowest one on the screen;

- `0` — to the first character on the current line;

- `^` — to the first non-blank character on the line ([regex syntax]);

- `|` — go to the first column ([a vertical bar, like a column]);

- `N` `|` — go to the `N`th column ([a vertical bar, like a column]);

- `$` — to the last character on the current line ([regex syntax]);

- `%` — to the matching `[`, `(`, `{`;

- `f` `char` — find the first occurrence of the `char` to the right ([f]ind);

- `N` `f` `char` — find the `N`th occurrence of the `char` to the right
  ([f]ind);

- `F` `char` — find the first occurrence of the `char` to the left;

- `N` `F` `char` — find the `N`th occurrence of the `char` to the left;

- `t` `char` — till the first occurrence of the `char` to the right ([t]ill);

- `N` `t` `char` — till the `N`th occurrence of the `char` to the right
  ([t]ill);

- `T` `char` — till the first occurrence of the `char` to the left;

- `N` `T` `char` — till the `N`th occurrence of the `char` to the left;

- `}` — a paragraph forward ([right curly brace]);

- `N` `}` — `N` paragraphs forward ([right curly brace]);

- `{` — a paragraph backward ([left curly brace]);

- `N` `{` — `N` paragraphs backward ([left curly brace]).

#### Text Objects

- `a` `restrictedMotion` — around `restrictedMotion` ([a]round);
- `i` `restrictedMotion` — inside `restrictedMotion` ([i]nside).

`restrictedMotion` is:

- a `word` or `WORD` ([w]ord);
- a paragraph ([p]aragraph);
- contents inside:
  - a pair of `'`, `"`, `` ` ``, `[`, `(`, `{`, `<`;
  - a tag ([t]ag).

### Scrolling

- `<c-u>` — scroll half the screen up ([u]p);

- `N` `<c-u>` — scroll `N` lines up ([u]p);

- `<c-d>` — scroll half the screen down ([d]own);

- `N` `<c-d>` — scroll `N` lines down ([d]own);

- `<c-f>` — scroll a screen forward ([f]orward);

- `N` `<c-f>` — scroll `N` screens forward ([f]orward);

- `<c-b>` — scroll a screen backward ([b]ackward);

- `N` `<c-b>` — scroll `N` screens backward ([b]ackward);

- `<c-o>` — go to the older position in jump list ([o]lder);

- `N` `<c-o>` — go to the `N`th older position in jump list ([o]lder);

- `<tab>` — go to the newer position in jump list;

- `N` `<tab>` — go to the `N`th newer position in jump list.

### Actions

#### Double-Callable

If the actions are called twice, they operate on a line. Their uppercase
counterparts operate from cursor to the end of the current line.

- `d` `motion` — copy and delete `motion` ([d]elete);

- `N` `d` `motion` — copy and delete `N` `motion`s ([d]elete);

- `c` `motion` — copy and delete `motion` and start inserting ([c]hange);

- `N` `c` `motion` — copy and delete `N` `motion`s and start inserting
  ([c]hange);

- `y` `motion` — yank `motion` ([y]ank)/copy `motion`;

- `N` `y` `motion` — yank `N` `motion`s ([y]ank)/copy `N` `motion`s;

- `>` `motion` — indent `motion`;

- `N` `>` `motion` — indent `N` `motion`s;

- `<` `motion` — unindent `motion`;

- `N` `<` `motion` — unindent `N` `motion`s;

- `=` `motion` — auto-indent `motion`;

- `N` `=` `motion` — auto-indent `N` `motion`s;

- `g~` `motion` — toggle case for `motion`;

- `N` `g~` `motion` — toggle case for `N` `motion`s;

- `gu` `motion` — get `motion` lowercased ([g]et);

- `N` `gu` `motion` — get `N` `motion`s lowercased ([g]et);

- `gU` `motion` — get `motion` uppercased ([g]et ... [U]ppercased);

- `N` `gU` `motion` — get `N` `motion`s uppercased ([g]et ... [U]ppercased);

- `gq` `motion` — wrap lines in `motion` at the char on `textwidth` column
  preserving indentation;

- `surrounding`s: `'`, `"`, `` ` ``, `[`, `(`, `{`, `<`
  - `y` `s` `motion` `surrounding` — add `surrounding` around `motion` ([a]dd
    `[s]urrounding`);
  - `c` `s` `currentSurrounding` `newSurrounding` — change `currentSurrounding`
    to `newSurrounding` ([c]hange `current[S]urrounding`);
  - `d` `s` `surrounding` — delete `surrounding` ([d]elete `[s]urrounding`).

#### Non-Double-Callable

- `~` — toggle case a character;

- `N` `~` — toggle cases for `N` characters;

- `zf` `motion` — define a fold for a `motion` ([f]old);

- `N` `zf` `motion` — define a fold for `N` `motion`s ([f]old);

- `za` — toggle a fold;

- `N` `za` — toggle `N` folds;

- `zt` — put the current line on the top of the screen ([t]op);

- `N` `zt` — put the `N`th line on the top of the screen ([t]op);

- `zz` — put the current line on the middle of the screen;

- `N` `zz` — put the `N`th line on the middle of the screen;

- `zb` — put the current line on the bottom of the screen ([b]ottom);

- `N` `zb` — put the `N`th line on the bottom of the screen ([b]ottom);

- `i` — insert before cursor ([i]nsert);

- `N` `i` — insert before cursor `N` times ([i]nsert);

- `I` — insert before the first character on the current line;

- `N` `I` — insert before the first character on the current line `N` times;

- `a` — insert after cursor ([a]fter);

- `N` `a` — insert after cursor `N` times ([a]fter);

- `A` — insert after the last character on the current line;

- `N` `A` — insert after the last character on the current line `N` times;

- `o` — open a line after the current one ([o]pen);

- `N` `o` — open a line after the current one `N` times ([o]pen);

- `O` — open a line before the current one;

- `N` `O` — open a line before the current one `N` times;

- `r` — replace the character under cursor ([r]eplace);

- `N` `r` — replace the character under cursor `N` times ([r]eplace);

- `R` — replace characters till `<c-[>`;

- `N` `R` — replace characters till `<c-[>` `N` times;

- `x` — delete a character under cursor;

- `N` `x` — delete `N` characters after cursor;

- `X` — delete a character before cursor;

- `N` `X` — delete `N` characters before cursor;

- `p` — paste after cursor ([p]aste);

- `N` `p` — paste after cursor `N` times ([p]aste);

- `P` — paste before cursor ([p]aste);

- `N` `P` — paste before cursor `N` times ([p]aste);

- `<c-a>` — increment the number at or after cursor ([a]dd);

- `N` `<c-a>` — add `N` to the number at or after cursor ([a]dd);

- `<c-x>` — decrement from the number at or after cursor;

- `N` `<c-x>` — subtract `N` from the number at or after cursor;

- `v` or `V` or `<c-v>` `g<c-a>` — get an ascending number sequence ([g]et ...
  [a]scending);

- `v` or `V` or `<c-v>` `g<c-x>` — get a descending number sequence;

- `<c-c>` `motion` — comment `motion` out ([c]omment);

- `J` — join the line below with the current one ([j]oin);

- `N` `J` — join `N` lines below with the current one ([j]oin).

### Change History

- `.` — repeat the last change;

- `u` — undo ([u]ndo);

- `U` — redo;

- `gh` — get the undo history ([g]et ... [h]istory).

### Macros

- `q` `letterOrN` — record a macro at `letterOrN`;

- `@` `letterOrN` — play the macro at `letterOrN` ([at]);

- `Q` — play the macro at `q` (`[q]`).

### Search

#### Window

- - `/` — search;
  - `?` — clear search;
  - `*` — search for the `word` under cursor.

  `n` — the next search result ([n]ext);\
  `N` — the previous search result—here `N` refers to `Shift` + `n`, not a
  number.

- `q/` — search queries history ([q]ueries).

#### Global

- `gc` `content` — go to the file with content ([g]o ... [c]ontent);
- `gn` `name` — go to the file with name ([g]o ... [n]ame).\
  \
  `<c-v>` — open file in a vertical split ([v]ertical);\
  `<c-s>` — open file in a horizontal split ([s]plit);\
  `<c-t>` — open file in a new tab ([t]ab);\
  `<tab>` — select files to open;\
  `<m-q>` — send selected files to quickfix list ([q]uickfix);\
  `<c-q>` — send all files to quickfix list ([q]uickfix).

### Windows

- `m` — move ([m]ove);

- `<c-h>` — switch to the one on the left of the current one;

- `<c-j>` — switch to the one on the bottom of the current one;

- `<c-k>` — switch to the one on the top of the current one;

- `<c-l>` — switch to the one on the right of the current one;

- `)` — increase the width ([right paren]);

- `(` — decrease the width ([left paren]);

- `+` — increase the height ([add]);

- `-` — decrease the height ([same key as ‘-’, subtract]);

- `<c-w>=` — equalize all the heights and widths ([equal]);

- `<c-w>_` — maximize the height.

### Tabs

- `gt` `name` — to to the tab with name ([g]o ... [t]ab);

- `<d-l>` — switch to the next ([right]);

- `<d-h>` — switch to the previous ([left]);

- `<d-N>` — switch to the `N`th where 0 < `N` < 10;

- `<d-d>` — duplicate ([d]uplicate);

- `<d-c>` — close ([c]lose);

- `<d-r>` — close all to the right ([r]ight);

- `<d-k>` — move the current one to the right ([right side of `HJKL`]);

- `<d-j>` — move the current one to the left ([left side of `HJKL`]);

- `<d-t>` — open a new terminal tab.

### File Browser

- `gl` — go to the currently open file location in browser ([g]o ...
  [l]ocation);

- in browser:
  - `<c-p>` — preview ([p]review);
  - `<cr>` — open;
  - `-` — open the parent folder;
  - `<c-v>` — open in a vertical split ([v]ertical);
  - `<c-t>` — open in a new tab ([t]ab);
  - `g.` — get hidden files ([g]et ... [start with ‘.’]).

### Code Interactions

- `K` — show the docs;

- `gr` — go to the references ([g]o ... [r]eferences);

- `gd` — go to the definition ([g]o ... [d]efinition);

- `gD` — go to the type definition ([g]o ... [D]efinition—types are usually
  capitalized);

- `gp` — get the code problems ([g]et ... [p]roblems);

- `gpp` — get the code problem for the current line ([g]et ... [p]roblems—like
  a double-callable action);

- `ga` — get the code actions ([g]et ... [a]ctions);

- `;f` — format the file ([f]ormat);

- `;r` — rename ([r]ename).

### Wrappers

#### Git

- in blame and log modes:
  - `o` — open a diff in a horizontal split;
  - `O` — open a diff in a new tab.

- in blame mode:
  - `-` — blame at commit under cursor.

- in merge mode:
  - `N` `do` — obtain the diff from `N` buffer ([o]btain ... [d]iff);
  - `N` `dp` — put the diff to `N` buffer ([p]ut ... [d]iff).

## Insert Mode

- `<c-h>` — backspace;

- `<c-l>` — move cursor one character right ([right]);

- `<c-w>` — delete `word` backward ([w]ord);

- `<c-u>` — undo everything till cursor ([u]ndo)/delete everything till cursor;

- `<c-n>` — auto-completion:
  - `<c-n>` — the next completion entry ([n]ext);
  - `<c-p>` — the previous completion entry ([p]revious).

- `<c-r>` `register` — paste contents of the `register` (`[r]egister`), e.g. `=`
  `expression` to insert math expression. To get a floating-point result, add
  `.0` to one of the numbers. In expression mode yanked text is accessible via
  `"` register;

- `<c-o>` — do an action in normal mode once ([o]nce).

## Visual Mode

- `o` — move cursor to the opposite side of the selection ([o]pposite);

- `:` `command` — execute `command` over the range of lines, e.g.
  `norm @letterOrN` to execute a macro ([`:`]);

- `s` — same as in Normal Mode — Actions —
  [Non-Double-Callable](#non-double-callable).

## Command Mode

- `w` `a` `!` — write the file ([w]rite)/save the file. `a` writes all files
  ([a]ll), `!` writes changes in read-only;

- `q` `a` `!` — quit the window ([q]uit). `a` quits all windows ([a]ll), `!`
  quits without writing;

- `wq` or `x` `a` `!` — write a file and quit ([w]rite)/save a file and quit.
  `a` writes and quits all files ([a]ll), `!` writes changes in read-only;

- `%s/what/for/` `g` `c` — replace the first occurrences of `what` with `for` on
  each line. `g` replaces all occurrences ([g]lobal), `c` enables confirmation
  dialog ([c]onfirm);

- `cdo` `command` — execute `command` over quickfix list entries;

- `G` `git-command` — Git integration ([G]it);

- `f` `buffer-name` — set `buffer-name` for the buffer.

## Terminal Mode

- `jk` — exit.
