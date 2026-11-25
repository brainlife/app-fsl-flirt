<h1 align="center">Linearly align DWI to another DWI with FSL FLIRT</h1>

<p align="center">
  A diffusion-weighted image and its gradients brought into the space of a reference DWI, using a FLIRT registration of their mean b0 images.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.458"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.458-blue.svg" alt="Run on brainlife.io"></a>
  <a href="https://github.com/brainlife/app-fsl-flirt/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> **This branch, `dwi-v1.0`, is the brainlife.io App Linearly align DWI to another DWI with FSL Flirt** ([doi:10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458)).

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Linearly aligns one DWI to another by registering their mean b0 images with FSL flirt and applying the transform to the moving DWI and its gradients with MRtrix3.**

Extracts mean b0 images from both DWIs, estimates a linear (affine) transform with FSL flirt, converts it to MRtrix3 format and applies it with mrtransform so that the moving DWI and its bvecs are expressed in the reference DWI space. Use it to bring two diffusion acquisitions of the same subject into register, e.g. before combining or comparing them.

| | |
|---|---|
| **Inputs** | `neuro/dwi` ×2 |
| **Outputs** | `neuro/dwi` |
| **Container** | `brainlife/mrtrix3:3.0_RC3` |
| **Resources** | 8 CPUs · 16 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `moving` | `neuro/dwi` | yes | DWI to be aligned (with bvals/bvecs). |
| `reference` | `neuro/dwi` | yes | DWI that defines the target space. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `dwi` | `neuro/dwi` | Moving DWI resampled into the reference DWI space, with updated bvals/bvecs. |

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458), choose the DWI to move (`moving`) and the DWI that defines the target space (`reference`), both `neuro/dwi`, and press **Execute**. The aligned DWI is archived to your project as a new `neuro/dwi` dataset tagged `aligned_dwi`. Use it to bring two diffusion acquisitions of the same subject into register, for example before combining or comparing them.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). The App runs FSL and MRtrix3 from the `brainlife/mrtrix3:3.0_RC3` container.

1. Clone this repository and check out the App branch: `git checkout dwi-v1.0`.
2. Create `config.json` with the paths to your inputs:

   ```json
   {
       "movingImg": "/input/moving/dwi.nii.gz",
       "movingBvecs": "/input/moving/dwi.bvecs",
       "movingBvals": "/input/moving/dwi.bvals",
       "referenceImg": "/input/reference/dwi.nii.gz",
       "referenceBvecs": "/input/reference/dwi.bvecs",
       "referenceBvals": "/input/reference/dwi.bvals"
   }
   ```

3. Run the App:

   ```bash
   ./main
   ```

### Sample data

Download sample datasets from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download <dataset-id>
```

## Outputs

The App extracts the mean b0 of each DWI (`select_dwi_vols -m`), estimates a linear transform with `flirt`, converts it to MRtrix3 format (`transformconvert flirt_import`) and applies it to the moving DWI with `mrtransform -linear`. Following MRtrix3 preprocessing conventions, the transform is applied to the image header and gradient table, without resampling.

```text
dwi/
├── dwi.nii.gz    moving DWI in the reference space
├── dwi.bvecs     gradients rotated with the same transform
└── dwi.bvals
dwi2dwi.mat       FLIRT transform from the moving to the reference b0
```

## Troubleshooting

- **`flirt failed. please look at derivatives and logs for debugging`**: check that both DWIs have b0 volumes and overlapping fields of view.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Woolrich MW, Jbabdi S, Patenaude B, Chappell M, Makni S, Behrens T, Beckmann C, Jenkinson M, Smith SM. Bayesian analysis of neuroimaging data in FSL. *NeuroImage* 45:S173–186 (2009).
- Smith SM, Jenkinson M, Woolrich MW, Beckmann CF, Behrens TEJ, Johansen-Berg H, et al. Advances in functional and structural MR image analysis and implementation as FSL. *NeuroImage* 23(S1):208–219 (2004).
- Jenkinson M, Beckmann CF, Behrens TE, Woolrich MW, Smith SM. FSL. *NeuroImage* 62:782–790 (2012).
- Linearly align DWI to another DWI with FSL Flirt. brainlife.io App. [doi:10.25663/brainlife.app.458](https://doi.org/10.25663/brainlife.app.458)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Tournier et al. MRtrix3: A fast, flexible and open software framework for medical image processing and visualisation. *NeuroImage* 202:116137 (2019). [doi:10.1016/j.neuroimage.2019.116137](https://doi.org/10.1016/j.neuroimage.2019.116137)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Brad Caron

**Contributors:** Soichi Hayashi

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

MIT, Copyright (c) 2020 brainlife.io, The University of Texas at Austin and Indiana University. FSL and MRtrix3 are distributed under their own licenses.
