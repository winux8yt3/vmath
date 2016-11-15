unit programStr;
    
interface

type
	TStr = array[0..255] of string;
	TNum = array[1..256]of longword;
    RVar = record
        VName:shortstring;
        Value:Extended;
    end;
	TVar = array[1..35565]of Rvar;

const 
    CopyrightInfo: string = 'Copyright (c) 2016 Nguyen Tuan Dung (Winux8yt3)';
    ProgramName: string = 'VMath Xplorer';
    Version: string = '0.9-pre5';
    VersionBuild: string = '161111';
    VersionInfo: string = 'Beta';

var
    CmdH:TStr;
    ans:extended;
    dec:byte = 2;

implementation

end.