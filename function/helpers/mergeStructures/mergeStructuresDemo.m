% merge Structures demo

%% simple case, no arrays
clear( 'ssInto' )
ssInto.a.aa = 1;  % update
ssInto.a.ab = 2;  % keep
ssInto.b = '4';   % keep
fprintf( 'ssInto:\n'); disp( ssInto )
fprintf( 'ssInto.a:\n'); disp( ssInto.a )
fprintf('\n')

clear( 'ssFrom' )
ssFrom.a.aa = []; % new value
ssFrom.a.ac = 33; % new field
fprintf( 'ssFrom:\n'); disp( ssFrom )
fprintf( 'ssFrom.a:\n'); disp( ssFrom.a )
fprintf('\n')

fprintf( 'running ssBadMerge = mergeFlatStructures(ssInto, ssFrom)\n' )
ssBadMerge = mergeFlatStructures(ssInto, ssFrom);
fprintf( 'ssBadMerge.a:\n'); disp( ssBadMerge.a )
fprintf('\n')
try
    val = ssBadMerge.a.ab;
catch  ME
    warning( 'field ssBadMerge.a.ab has gone!')
end
    
fprintf( 'running ssGoodMerge = mergeStructures(ssInto, ssFrom)\n' )
ssGoodMerge = mergeStructures(ssInto, ssFrom);
fprintf('\n')
fprintf( 'ssGoodMerge:\n'); disp( ssGoodMerge )
fprintf( 'ssGoodMerge.a:\n'); disp( ssGoodMerge.a )
fprintf('\n')


%% array of structures at top level
fprintf( 'running example: array of structures at top level\n' )

clear( 'asDest' )
asDest( 2,3 ).a = '_asDest( 2,3 ).a'; % sets size of asDest
asDest( 1,2 ).a = '_asDest( 1,2 ).a';
fprintf('\n')
fprintf( 'asDest:\n'); disp( asDest )
fprintf( 'asDest( 1,2 ).a:\n'); disp( asDest( 1,2 ).a )
fprintf( 'asDest( 2,3 ).a:\n'); disp( asDest( 2,3 ).a )
fprintf('\n')

clear( 'asSrc' )
asSrc( 2,3 ).a = '_asSrc( 2,3 ).a'; % sets size of asSrc
asSrc( 1,1 ).a = '_asSrc( 1,1 ).a';
fprintf('\n')
fprintf( 'asSrc:\n'); disp( asDest )
fprintf( 'asSec( 1,1 ).a:\n'); disp( asSrc( 1,1 ).a )
fprintf( 'asSrc( 2,3 ).a:\n'); disp( asSrc( 2,3 ).a )
fprintf('\n')

asMerge = mergeStructures( asDest, asSrc);
fprintf('\n')
fprintf( 'asMerge:\n'); disp( asDest )
fprintf( 'asMerge( 1,1 ).a:\n'); disp( asMerge( 1,1 ).a )
fprintf( 'asMerge( 1,2 ).a:\n'); disp( asMerge( 1,2 ).a )
fprintf( 'asMerge( 2,3 ).a:\n'); disp( asMerge( 2,3 ).a )
fprintf('\n')

%% struct array deeper in the structure and use case

fprintf( 'running example: reading from files and merging struct arrays\n' )

ssSettings = load( 'defaultSettings.mat');
ssSettings = ssSettings.ssDef;

ssXpt = load( 'expt_2023-06-28_001.mat' );
ssXpt = ssXpt.ssXpt;
ssSettings = mergeStructures( ssSettings, ssXpt);

clear('ssGuiVals')
ssGuiVals.date = datestr(now(), 'yyyy-mm-ddTHH:MM:SS');
ssGuiVals.scopes(2).chans(4).range_Vpp = []; % set size
ssGuiVals.scopes(2).chans(2).range_Vpp = 5.0;
ssGuiVals.scopes(2).chans(3).range_Vpp = 5.0;

ssSettings = mergeStructures(ssSettings, ssGuiVals);

fprintf('ssSettings:\n'); disp( ssSettings );


