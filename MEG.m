%'menu' for build a multisegmented elution gradient (MEG)
%--------------------------------------------------------
%The software implementation of a graphical utlity to developp
%a gradient elution in HPLC with binary/ternary solvent mixtures 
%
%Cite As:
%L.A. Sarabia, M.M. Arce, D. Castro, S. Sanllorente, M.C.Ortiz. 
%"MEG a MATLAB tool to construct a multisegmented ternary gradient profile."


clear
answer=questdlg('Would you make a gradient?', ...
	'Gradient', ...
	'Encoded','Manual','No thank you','No thank you');
% handle response
switch answer
    case 'Encoded'
        gradient;
    case 'Manual'
        gradientm;
    case 'No thank you'
        
end
clear