# IPKG files

When you open a directory with a file at the top level in it that ends in `.ipkg`, all the commands
in this package will read it and use it to find the path of your sources and resolve
dependencies.

Supported are the `opts` and `sourcedir` options.

There is [more information](http://docs.blodwen-lang.org/en/latest/tutorial/packages.html) about `ipkg`-files in the blodwen documentation.


## Example

You have a folder that looks like this:

```
src
└───Main.blod
└───OtherFile.blod
your-project.ipkg
```

with `your-project.ipkg` containing:

```
package yourProject

sourcedir = src
modules = Main
executable = yourExecutable
main = Main

opts = "-p lightyear effects"
```

the package will search in the `src`-directory for your files and will
load the dependencies specified in `opts`.

Newer versions of Blodwen also accept packages specified in a comma-separated list
under the `pkgs` key:

```
package yourProject

sourcedir = src
modules = Main
executable = yourExecutable
main = Main

pkgs = lightyear, effects
```
