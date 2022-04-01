
tti={'File name for the chromatogram','Enter L:','Enter alfa','Number of segments','Maximum segment time', 'Total maximum time'};
dlgtitle='Encoded gradient';
dims=[1 35];
opts.Interpreter = 'tex';
definput= {'chromatogram', '70', '80', '11', '8', '30'};
answer=inputdlg(tti,dlgtitle,dims,definput);

TF=isempty(answer);
if TF~=1
    str=answer{1};
    L=eval(answer{2});
    if L < 0 || L>200 
        msg='L should between 0 and 200';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end

    alfa=eval(answer{3});
    if alfa < 0 || alfa >120 
        msg='alfa should between 0 and 120';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end
    
    ng=eval(answer{4});   
    if ng < 0 || ng > 11 || ng~=round(ng)
        msg='ng should an integer between 0 and 11';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end
    
    t=eval(answer{5});
    if t < 0  || t~=round(t)
        msg='t should a positive integer';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end
    
    tmax=eval(answer{6});
    if tmax < 0  || tmax<t || tmax~=round(tmax)
        msg='tmax should a positive integer greater than t';
        f=errordlg(msg,'Input Error');
        uiwait(f);
        MEG
        return
    end
    
    
    
   
    
    eval([str,'=grad2(L,alfa, ng, t ,tmax);']);
    eval(['grafprofile(',str,');']);

    clear alfa answer definput dims dlgtitle L ng t tmax tti TF opts

    eval(['mkdir ',str]);
    eval(['cd ',str]);
    eval(['save ', str]);
    savefig(figure(1), 'gradient1')
    savefig(figure(2), 'gradient2')
    eval(['cd ..']);
    clear 
end
