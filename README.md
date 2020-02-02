<p align="center"><a href="http://luarocks.org"><img border="0" src="http://luarocks.github.io/luarocks/luarocks.png" alt="LuaRocks" width="500px"></a></p>

A package manager for Lua modules.

[![Build Status](https://travis-ci.org/luarocks/luarocks.svg?branch=master)](https://travis-ci.org/luarocks/luarocks)
[![Build Status](https://ci.appveyor.com/api/projects/status/4x4630tcf64da48i/branch/master?svg=true)](https://ci.appveyor.com/project/hishamhm/luarocks/branch/master)
[![Coverage Status](https://codecov.io/gh/luarocks/luarocks/coverage.svg?branch=master)](https://codecov.io/gh/luarocks/luarocks/branch/master)
[![Join the chat at https://gitter.im/luarocks/luarocks](https://badges.gitter.im/luarocks/luarocks.svg)](https://gitter.im/luarocks/luarocks)

Main website: [luarocks.org](http://www.luarocks.org)

It allows you to install Lua modules as self-contained packages called
[*rocks*][1], which also contain version [dependency][2] information. This
information can be used both during installation, so that when one rock is
requested all rocks it depends on are installed as well, and also optionally
at run time, so that when a module is required, the correct version is loaded.
LuaRocks supports both local and [remote][3] repositories, and multiple local
rocks trees.

## Installing

* [Installation instructions for Unix](http://luarocks.org/en/Installation_instructions_for_Unix) (Linux, BSDs, etc.)
* [Installation instructions for macOS](http://luarocks.org/en/Installation_instructions_for_macOS)
* [Installation instructions for Windows](http://luarocks.org/en/Installation_instructions_for_Windows)

## Contributing 

* Create a new branch with a meaningful name `git checkout -b branch_name`.
* Add the files you changed `git add file_name`.
* Commit your changes `git commit`.
* Keep one commit per feature. If you forgot to add changes, you can edit the previous commit `git commit --amend`.
* Push to your repo `git push --set-upstream origin branch-name`.
* Go into [the Github repo](https://github.com/luarocks/luarocks.git) and create a pull request explaining your changes.
* If you are requested to make changes, edit your commit using `git commit --amend`, push again and the pull request will edit automatically.
* If the PR is related to any front end change, please attach relevant screenshots in the pull request description.

## License

LuaRocks is free software and uses the [MIT license](http://luarocks.org/en/License), the same as Lua 5.x.

[1]: http://luarocks.org/en/Types_of_rocks
[2]: http://luarocks.org/en/Dependencies
[3]: http://luarocks.org/en/Rocks_repositories
