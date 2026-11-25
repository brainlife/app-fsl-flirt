[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.458-blue.svg)](https://doi.org/10.25663/brainlife.app.458)

# Linearly align DWI to another DWI with FSL Flirt

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Linearly aligns one DWI to another by registering their mean b0 images with FSL flirt and applying the transform to the moving DWI and its gradients with MRtrix3.**

Extracts mean b0 images from both DWIs, estimates a linear (affine) transform with FSL flirt, converts it to MRtrix3 format and applies it with mrtransform so that the moving DWI and its bvecs are expressed in the reference DWI space. Use it to bring two diffusion acquisitions of the same subject into register, e.g. before combining or comparing them.

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `moving` | `neuro/dwi` | yes | DWI to be aligned (with bvals/bvecs). |
| `reference` | `neuro/dwi` | yes | DWI that defines the target space. |

| Output | Datatype | Description |
|---|---|---|
| `dwi` | `neuro/dwi` | Moving DWI resampled into the reference DWI space, with updated bvals/bvecs. |

Runtime: container `brainlife/mrtrix3:3.0_RC3`; 8 CPUs; 16 h walltime.

<!-- brainlife-app:end -->

This app will linearly align two dMRI images to each other using FSL Flirt.

### Authors

- Brad Caron (bacaron@utexas.edu)

### Contributors

- Soichi Hayashi (shayashi@iu.edu)

### Funding Acknowledgement

brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations

We kindly ask that you cite the following articles when publishing papers and code using this code.

1. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). https://doi.org/10.1038/s41597-019-0073-y

2. M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009

3. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004

4. M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith. FSL. NeuroImage, 62:782-90, 2012

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University

## Running the App

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458) via the 'Execute' tab.

### Running Locally (on your machine)

1. git clone this repo

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
    "movingImg": "/input/moving/dwi.nii.gz",
    "movingBvecs": "/input/moving/bvecs.nii.gz",
    "movingBvals": "/input/moving/bvals.nii.gz",
    "referenceImg": "/input/reference/dwi.nii.gz",
    "referenceBvecs": "/input/reference/bvecs.nii.gz",
    "referenceBvals": "/input/reference/bvals.nii.gz"
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download
```

3. Launch the App by executing 'main'

```bash
./main
```

## Output

The main output of this App is an aligned dwi datatype.

#### Product.json

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing.

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.   

- FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University
