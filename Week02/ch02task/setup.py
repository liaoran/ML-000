from distutils.core import setup, Extension
from Cython.Build import cythonize
import numpy

compile_flags = ['-std=c++11']

module = Extension('chap02task',
                   ['chap02task.pyx'],
                   language='c++',
                   include_dirs=[numpy.get_include()],
                   extra_compile_args=compile_flags
                   )
setup(
    name='chap02task',
    ext_modules=cythonize(module)
)