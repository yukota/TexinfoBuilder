# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "texinfo"
version = v"6.5.0"

# Collection of sources required to build texinfo
sources = [
    "https://ftp.gnu.org/gnu/texinfo/texinfo-6.5.tar.xz" =>
    "77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd texinfo-6.5/
./configure --prefix=$prefix --host=$target
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "makeinfo", Symbol("makeinfo")),
    ExecutableProduct(prefix, "pdftexi2dvi", Symbol("pdftexi2dvi")),
    ExecutableProduct(prefix, "pod2texi", Symbol("pod2texi")),
    ExecutableProduct(prefix, "texi2any", Symbol("texi2any")),
    ExecutableProduct(prefix, "texi2dvi", Symbol("texi2dvi")),
    ExecutableProduct(prefix, "texi2pdf", Symbol("texi2pdf")),
    ExecutableProduct(prefix, "texindex", Symbol("texindex"))
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

