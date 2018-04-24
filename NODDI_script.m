% Create roi.mat file from roi_mask
%CreateROI('NODDI_DWI.hdr','roi_mask.hdr','NODDI_roi.mat');
CreateROI('09.hdr','mask_09.nii','NODDI_roi.mat');

% Protocol mat
%protocol = FSL2Protocol('NODDI_protocol.bval','NODDI_protocol.bvec');
protocol = FSL2Protocol('bvals','bvecs');

% Make model
noddi = MakeModel('WatsonSHStickTortIsoV_B0');
% 

% fitting with batch size two: Took 2521 seconds to process 5478 voxels
batch_fitting('NODDI_roi.mat',protocol,noddi,'FittedParams2.mat',2);

% Save output as nii files 
% Neurite density (or intra-cellular volume fraction): ficvf
% Orientation dispersion index: ODI
% CSF volume fraction: fiso
% Fibre orientation: fibredirs_x,y,z(vec)
% Fitting objective function values: fmin
% Concentration parameter of Watson distribution used to compute ODI: kappa
% Error code: Nonzero values indicate fitting errors: error_code

SaveParamsAsNIfTI('FittedParams2.mat','NODDI_roi.mat','brain_mask.hdr','example')