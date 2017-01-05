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
    TErr = record
        id:byte;
        str:string;
    end;
const 
    CopyrightInfo: string = 'Copyright (c) 2016 Nguyen Tuan Dung (Winux8yt3)';
    ProgramName: string = 'VMath Xplorer';
    Version: string = '0.9.5';
    BuildTime: string = {$I %DATE%}+'-'+{$I %TIME%};
    VersionInfo: string = 'Beta';
var
    ProgramInfo:string;   
    CmdH:TStr;
    ErrHide:boolean=False;
    ans:extended;
    dec:byte = 2;
    Err:TErr;

function BuildNum():string;

implementation

function BuildNum():string;
var s:string={$I %DATE%}+'-'+{$I %TIME%};
begin
	while pos('/',s) <> 0 do delete(s,pos('/',s),1);
	while pos(':',s) <> 0 do delete(s,pos(':',s),1);
    delete(s,1,2);delete(s,length(s)-1,2);
    BuildNum:=s;
end;

begin
    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Build '+BuildNum+'.';
end.