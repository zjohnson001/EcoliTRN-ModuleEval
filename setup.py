import os
from distutils.core import setup
from Cython.Build import cythonize
import numpy

# Define the paths to your Cython files
cython_files = [
    os.path.join('src', 'modeval', 'ebcubed.pyx'),
    os.path.join('src', 'modeval', 'jaccard.pyx'),
    os.path.join('src', 'modeval', 'cfisher.pyx')
]

setup(
    name='cython_modules',
    ext_modules=cythonize(cython_files),
    include_dirs=[numpy.get_include()]
)