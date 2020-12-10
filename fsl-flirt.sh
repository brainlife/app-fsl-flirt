#!/bin/bash

# set up input variables
referenceImg=`jq -r '.referenceImg' config.json`
referenceBvals=`jq -r '.referenceBvals' config.json`
referenceBvecs=`jq -r '.referenceBvecs' config.json`
movingImg=`jq -r '.movingImg' config.json`
movingBvals=`jq -r '.movingBvals' config.json`
movingBvecs=`jq -r '.movingBvecs' config.json`

mkdir -p dwi

# set up moving dwi in mrtrix3
mrconvert -fslgrad ${movingBvecs} ${movingBvals} ${movingImg} dwi.mif --export_grad_mrtrix dwi.b -quiet -force

# select b0 volumes
select_dwi_vols ${movingImg} ${movingBvals} b0_mov.nii.gz 0 -m
select_dwi_vols ${referenceImg} ${referenceBvals} b0_ref.nii.gz 0 -m

# run flirt
flirt -in b0_mov.nii.gz -ref b0_ref.nii.gz -omat dwi2dwi.mat

# apply transform to header to follow standard set by mrtrix3 preproc
transformconvert dwi2dwi.mat b0_mov.nii.gz b0_ref.nii.gz flirt_import dwi2dwi_mrtrix.mat -quiet -force
mrtransform -linear dwi2dwi_mrtrix.mat dwi.mif dwi_dwi.mif -quiet -force

# convert back to nifti
mrconvert dwi_dwi.mif ./dwi/dwi.nii.gz -export_grad_fsl ./dwi/dwi.bvecs ./dwi/dwi.bvals -export_grad_mrtrix dwi.b -json_export dwi.json -quiet -force

# clean up and check
if [ -f ./dwi/dwi.nii.gz ]; then
	echo "flirt complete"
	rm -rf *.mif *.b
	exit 0
else
	echo "flirt failed. please look at derivatives and logs for debugging"
	exit 1
fi
