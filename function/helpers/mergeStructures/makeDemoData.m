% make demo data
%%
clear( 'ssDef')
ssDef.date = datestr(now(), 'yyyy-mm-ddTHH:MM:SS');
ssDef.startuplabel = 'default settings';

save('defaultSettings.mat', 'ssDef' );

%%
clear( 'ssXpt' )
ssXpt.scopes(2).id = 'scope 2';
ssXpt.scopes(1).id = 'scope 1';
for nScope = 2:-1:1
    for nChan = 4:-1:1
        ssXpt.scopes(nScope).chans(nChan).range_Vpp = 10.0;
    end
end
ssXpt.experiment.id = 'expt_2023-06-28_001';
save([ssXpt.experiment.id ,'.mat'], 'ssXpt' );



