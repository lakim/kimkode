---
title: Add RubyMotion syntax highlighting and linter to Sublime Text 2
summary: A proper development environment for RubyMotion
tags: RubyMotion
---

Today, I eventually started to use RubyMotion to build the NoReceipt app.
For my Ruby development, I already use Sublime Text with basic syntax highlighting. Nothing fancy here. But to write RubyMotion apps, the iOS SDK is where lies the complexity compared to the Ruby or Rails APIs. Basic code completion and lint is what I was looking for.

If you haven't already, install [Package Control](http://wbond.net/sublime_packages/package_control).

Code completion
---------------

Install [SublimeRubyMotionBuilder](https://github.com/haraken3/SublimeRubyMotionBuilder), developed by Kentaro Hara:

1. Open the Command Palette using **[command + shift + p]** and select `Package Control: Install Package`
2. Select `RubyMotionBuilder`
3. Open the Command Palette again and select `RubyMotionBuilder: Generate syntax`

Lint
----

Install [SublimeLinter](https://github.com/SublimeLinter/SublimeLinter):

1. Open the Command Palette using **[command + shift + p]** and select `Package Control: Install Package`
2. Select `SublimeLinter` 

Configure SublimeLinter for RubyMotion:

1. Open `Preferences > Browse Packages...`
2. Open the `SublimeLinter/sublimelinter/modules` directory
3. Create the `ruby_motion.py` file:

```python
from ruby import Linter

CONFIG = {
    'language': 'RubyMotion',
    'executable': '/Library/RubyMotion/bin/ruby',
    'lint_args': '-wc'
}
```

That's it! Now you should have code completion and lint for RubyMotion.

Sources:

* <http://www.willprater.me/blog/2012/07/24/rubymotion-linting-and-highlighting-with-sublime-text/>
