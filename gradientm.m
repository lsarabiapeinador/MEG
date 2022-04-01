
tti={'File name for the chromatogram','Enter initial mixture (H_{2}O : MeOH : AcN):','Enter final mixture (H_{2}O : MeOH : AcN):', 'Enter at most 11 segment times (integers)'};
dlgtitle='Manual gradient';
dims=[1 50];
opts.Interpreter = 'tex';
% '\fontsize{15} text';
definput= {'chromatogram', '35 15 50', '10 50 40', '5 0 2 4 8 0 0 6 6 0 0'};
answer1=inputdlg(tti,dlgtitle,dims,definput,opts);

TF=isempty(answer1);
if TF~=1
    str=answer1{1};
    C1=str2num(answer1{2});
    [~,nC1]=size(C1);
    if min(C1)<0 || sum(C1)~=100 || nC1~=3
        msg='It is not a valid initial ternary mixture';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end
    
    C2=str2num(answer1{3});
    [~,nC2]=size(C2);
    if min(C2)<0 || sum(C2)~=100 || nC2~=3
        msg='It is not a valid final ternary mixture';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end  
    
    Y1=str2num(answer1{4});
    [~,ng]=size(Y1);
    M=Y1~=round(Y1);
    if ng<1 || ng>11 || sum(M)~=0
        msg='Please enter at most 11 integer numbers';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end  
    
    eval([str,'=grad3(answer1);']);
    eval(['grafprofile(',str,');']);
    clear tti dlgtitle dims definput answer1 opts TF answer C1 C2 M nC1 nC2 ng Y1
    eval(['mkdir ',str]);
    eval(['cd ',str]);
    eval(['save ', str]);
    savefig(figure(1), 'gradient1')
    savefig(figure(2), 'gradient2')
    eval(['cd ..']);
    clear 
end




