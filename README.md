# biobb_workflows

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/bioexcel/biobb_workflows/master?filepath=biobb_workflows%2Flysozyme_tutorial%2Fnotebooks%2FLysozyme.ipynb)



The Jupyter notebook [Lysozyme.ipynb](biobb_workflows/lysozyme_tutorial/notebooks/Lysozyme.ipynb) shows a _Lysozyme + Mutations tutorial_ using the [BioExcel](http://bioexcel.eu/) building blocks [biobb](https://bioexcel.eu/research/projects/biobb_standardization/).

You may execute the notebook on a free cloud instance using [myBinder](https://mybinder.org/v2/gh/bioexcel/biobb_workflows/master?filepath=biobb_workflows%2Flysozyme_tutorial%2Fnotebooks%2FLysozyme.ipynb), or for better performance/extensibility in your on instance of [Jupyter](https://jupyter.org/) Notebook.

## BioConda installation

For your own installation it is recommended to use [BioConda](https://bioconda.github.io/) on Linux or OS X.  See the [BioConda installation instructions](https://bioconda.github.io/#using-bioconda) for details. In brief:

First, [install MiniConda](https://conda.io/en/latest/miniconda.html) (Python 3.x recommended). Then activate BioConda channels:

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Make a new _Conda environment_ to keep [our dependencies](binder/environment.yml):

```
conda create -n biobb biobb_md biobb_io biobb_model nglview gromacs
```

_Tip: Remove `gromacs` above if you have already installed [GROMACS](http://manual.gromacs.org/documentation/) that you [compiled with hardware accelerations](http://manual.gromacs.org/documentation/2018/install-guide/index.html) like NVidia CUDA._

Activate the Conda environment:

```
conda activate biobb
```


### OpenCL implementations

After activating the Conda environment for the first time you may see a warning equivalent to:

```
WARNING: No ICDs were found. Either,
- Install a conda package providing a OpenCL implementation (pocl, oclgrind) or 
- Make your system-wide implementation visible by doing 'ln -s /etc/OpenCL/vendors /home/USER/miniconda3/envs/biobb/etc/OpenCL/vendors'  
```

The [PyOpenCl documentation](https://documen.tician.de/pyopencl/misc.html#using-vendor-supplied-opencl-drivers-mainly-on-linux) suggests how to proceed. **OS X** users should use `conda install khronos-opencl-icd-loader` which can use GPU hardware installed, while in **Linux** you can either provide a software-based OpenCL implementation with `conda install pocl` or (recommended) use GPU-specific hardware implementation found in `/etc/OpenCL/vendors` (e.g. `apt install nvidia-driver-390`) by creating the symlink as suggested.

## Start Jupyter Notebook

Activate the `nglview` extension and start Jupyter Notebook:

```
jupyter-nbextension enable nglview --py --sys-prefix
jupyter notebook biobb_workflows/lysozyme_tutorial/notebooks/Lysozyme.ipynb
```

A browser window should appear, or click the link provided. 

