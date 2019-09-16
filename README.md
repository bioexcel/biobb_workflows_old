# biobb_workflows

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/bioexcel/biobb_workflows/master?filepath=biobb_workflows%2Flysozyme_tutorial%2Fnotebooks%2FLysozyme.ipynb)
[![bioexcel/biobb_workflows](https://images.microbadger.com/badges/image/bioexcel/biobb_workflows.svg)](https://hub.docker.com/r/bioexcel/biobb_workflows/ "bioexcel/biobb_workflows")
[![Apache License, 2.0](https://img.shields.io/github/license/bioexcel/biobb_workflows.svg)](LICENSE)

The Jupyter notebook [Lysozyme.ipynb](biobb_workflows/lysozyme_tutorial/notebooks/Lysozyme.ipynb) shows a _Lysozyme + Mutations tutorial_ using the [BioExcel](http://bioexcel.eu/) building blocks [biobb](https://bioexcel.eu/research/projects/biobb_standardization/).

You may execute the notebook on a free cloud instance using [myBinder](https://mybinder.org/v2/gh/bioexcel/biobb_workflows/master?filepath=biobb_workflows%2Flysozyme_tutorial%2Fnotebooks%2FLysozyme.ipynb), or for better performance/extensibility in your on instance of [Jupyter](https://jupyter.org/) Notebook.

## Docker image

The [Docker](https://www.docker.com/) image [bioexcel/biobb_workflows](https://hub.docker.com/r/bioexcel/biobb_workflows/) is provided, based on [myBinder](https://mybinder.org).

Launch it as:

```
docker run -p 8888:8888 -it bioexcel/biobb_workflows
```

Then access the Notebook at http://127.0.0.1:8888/ using the provided token.

_Tip:_ If you have an NVIDIA GPU and [NVIDIA Docker](https://github.com/NVIDIA/nvidia-docker) installed, launch with `nvidia-docker` instead of `docker` for hardware-accelerated GROMACS.

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
conda create -n biobb biobb_md biobb_io biobb_model nglview=1.2.0 simpletraj gromacs
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


## Copyright & Licensing

This software has been developed in the MMB group (http://mmb.irbbarcelona.org) at the
BSC (http://www.bsc.es/) & IRB (https://www.irbbarcelona.org/) and 
[eScience Lab](https://esciencelab.org.uk/) group at [The University of Manchester](https://www.manchester.ac.uk/)
for the European BioExcel (http://bioexcel.eu/) CoE, funded by the European Commission
(EU H2020 [675728](https://cordis.europa.eu/project/id/675728), [823830](https://cordis.europa.eu/project/id/823830)).

* (c) 2018-2019 [Barcelona Supercomputing Center](https://www.bsc.es/)
* (c) 2018-2019 [Institute for Research in Biomedicine](https://www.irbbarcelona.org/)
* (c) 2018-2019 [The University of Manchester](https://www.manchester.ac.uk/)


The Jupyter Notebook is based on the [Lysozyme in Water GROMACS tutorial](http://www.mdtutorials.com/gmx/lysozyme/01_pdb2gmx.html) by Justin A. Lemkul at Virginia Tech Department of Biochemistry.

Licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), see the file
[LICENSE](LICENSE) for details.

![](https://bioexcel.eu/wp-content/uploads/2015/12/Bioexcell_logo_1080px_transp.png "Bioexcel")
