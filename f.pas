{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit f;
    
interface

function FileIO(FName:string):byte;
function FileIO(var f:text):byte;
function FileExist(FName:string):boolean;
procedure ReadLang(FName:string);
procedure ReadCfg;

implementation

uses lang,io,basic,programstr,crt;

function FileIO(FName:string):byte;
var f:text;
begin
    {$I-}
        assign(f,FName);
        Reset(f);
    {$I+}
    FileIO:=IOResult;
    if FileIO=0 then close(f);
end;

function FileIO(var f:text):byte;
begin
    {$I-}
        Reset(f);
    {$I+}
    FileIO:=IOResult;
    if FileIO=0 then close(f);
end;

function FileExist(FName:string):boolean;
var f:text;
begin
    {$I-}
        assign(f,FName);
        Reset(f);
    {$I+}
    FileExist:=(IOResult=0) and (FName<>'');
    if IOResult=0 then close(f);
end;

procedure VarCut(var s,val:string);
begin
    val:=copy(s,pos('=',s)+1,length(s)-pos('=',s));
    delete(s,pos('=',s),length(s)-pos('=',s)+1);
end;

procedure ReadCfgVar(s,val:string);
begin
    case Upcase(s) of
        'BGCOLOR'	:	if (Str2Int(val).chk=True) and (Str2Int(val).val>=0) then bgcolor(Str2Int(val).val);
        'TXCOLOR'	:	if (Str2Int(val).chk=True) and (Str2Int(val).val>=0) then txColor(Str2Int(val).val);
        'ERRHIDE'	:	if Str2Bool(val).chk=True then ErrHide:=Str2Bool(val).val;
        'DEC'		:	if (Str2Int(val).chk=True) and (Str2Int(val).val>=0) and (Str2Int(val).val<=20)
                        then decn:=Str2Int(val).val;
    end;
end;

procedure ReadLangVar(s,val:string);
begin
    case Upcase(s) of
        'DONEMSG'		:	DoneMsg:=val;
        'WELCOMEMSG'	:	WelcomeMsg:=val+' '+ProgramName;
        'LOADTEXT'		:	LoadText:=val;
        'INPUTTEXT'		:	InputText:=val;
        'OUTPUTTEXT'	:	OutputText:=val;
        'EXITTEXT'		:	ExitText:=val;
        'GNOTENABLEDMSG':	GNotEnabledMsg:=val;
        'GENABLED'		:	GEnabledMsg:=val;
        'GDISABLEDMSG'	:	GDisabledMsg:=val;
        'GLOADMSG'		:	GLoadMsg:=val;
        'GCLOSEMSG'		:	GCloseMsg:=val;
    end;
end;

procedure ReadCfg;
var 
    val,s:string;
    f:text;
begin
    write(LoadText,'vmath.cfg');
    assign(f,'vmath.cfg');
    Reset(f);
    while not eoln(f) do begin
        readln(f,s);
        VarCut(s,val);
        if val<>'' then begin
            ReadCfgVar(s,val);
            writeln('[',s,']=',val);
        end;
    end;
end;

procedure ReadLang(FName:string);
var 
    val,s:string;
    f:text;
begin
    write('Reading Language');
    assign(f,FName);
    Reset(f);
    while not eoln(f) do begin
        readln(f,s);
        VarCut(s,val);
        if val<>'' then begin
            ReadLangVar(s,val);
            writeln('[',s,']:=',val);
        end;
    end;
end;

end.