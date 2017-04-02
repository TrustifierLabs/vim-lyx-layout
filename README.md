# VIM Syntax Highlights for LyX 2.2.2 (or higher)

vim-lyx-layout provides [vim](https://vim.org/) syntax highlighting
for [LyX](https://lyx.org) modules and layout files 

## writing LyX Modules

LyX is a _WYSIWYM_ wordprocessor that has a rather extensive interface to interact
with TeX/LaTeX classes. Essentially LyX modules and layout files provide wrappers 
around TeX/LaTeX classes and make writing documents in LyX more user-friendly.


Writing LyX modules is however somewhat of a challenge,
and whilst developing a set of LyX layouts and modules I found working with them
a little difficult. Silly mistakes would make it hard to track down where the issues
were. 

In order to facilitate the development, I started a syntax highlighter for vim.

This is still workin progress, however it is far-enough along that you can start
using it. 

I'll be finishing it up as time permits. Or if you want to submit patches follow
the [git-flow](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/) 
model to submit a patch. Basic steps are:

  1. Clone the repo 
  2. Create a branch from the *develop* branch
  3. Do your thing
  4. Submit a merge request against the *develop* branch

Also, I like getting feedback, so pleace let me know what you think.
