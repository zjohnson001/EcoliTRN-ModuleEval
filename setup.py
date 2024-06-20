import os
from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy

# Define the paths to your Cython files
cython_files = [
    os.path.join('src', 'modeval', 'ebcubed.pyx'),
    os.path.join('src', 'modeval', 'jaccard.pyx'),
]

# Create Extension objects
extensions = [
    Extension(
        name="modeval.ebcubed",
        sources=[cython_files[0]],
        include_dirs=[numpy.get_include()],
    ),
    Extension(
        name="modeval.jaccard",
        sources=[cython_files[1]],
        include_dirs=[numpy.get_include()],
    ),
]

setup(
    name='cython_modules',
    ext_modules=cythonize(
        extensions,
        compiler_directives={'language_level': "3"},
    ),
    include_dirs=[numpy.get_include()],
    install_requires=[
        'cython>=3.0.10',
        'numpy>=1.26.4',
        'fisher>=0.1.14',
        'munkres>=1.1.4',
        'pandas>=2.2.2',
        'statsmodels>=0.14.2',
        'scipy>=1.13.1',
        'scikit-learn>=1.5.0',
        'nbconvert>=7.16.4',
        'nbformat>=5.10.4',
        'ipykernel>=6.29.4',
        'matplotlib>=3.9.0',
        'networkx>=3.2.1'
    ]
)