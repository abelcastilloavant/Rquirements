## Rquirements - like lockbox, but with introspection


There's this amazing R package called [lockbox](https://github.com/robertzk/lockbox/), that
handles dependency management for you in a hassle-free way. This package is a complete rewrite
of lockbox, with additional tooling that allows for introspection into the dependency tree.

This package is still under development and does not work yet!

### Installation

This package is not available on CRAN. To install this package, use devtools:
```r
if (!require(devtools)) { install.packages("devtools") }
devtools::install_github("abelcastilloavant/Rquirements")
```

### Use

To use Rquirements, you first want to write a reqsfile. This will contain a list of all of the R
packages you need in your R session, along with versions and additional details needed to download
and install the package and its dependencies.

(TODO: add examples of reqfile entries)


### Mechanics

The main function in the package is `install_reqs`, which takes your reqsfile and installs all
packages listed there, along with its dependencies.

To do this, the first thing `install_reqs` does is take your reqsfile and write a lockfile. In
analogy with Gemfiles in Ruby, the reqsfile is a list of packages that you need, and the lockfile
is the full list of packages needed to satisfy all dependencies of all packages in the reqsfile,
along with the reqsfile itself, topologically sorted by dependency.

(TODO: add more details as they are developed)

### License

This project is licensed under the MIT License:

Copyright (c) 2018 Abel Castillo

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgements

This project draws heavily on ideas from [lockbox](https://github.com/robertzk/lockbox/),
thanks to Robert Krzyzanowski for his work on that package.
