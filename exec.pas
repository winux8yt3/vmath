{
	Copyright (c) Winux8YT3. 
	License Under MIT License. See LICENSE in root folder for license.
}
unit exec;
    
interface

procedure RunFile(FName:string);
function VmathCheck(var f:text):boolean;
procedure VmathExec(var f:text);
    
implementation

uses
    f,io,basic,programstr,crt;

procedure RunFile(FName:string);
var 
    f:text;
begin
    if pos('.',FName)=0 then FName:=FName+'.vmath';
    assign(f,FName);
    if FileExist(FName) and (FileIO(f)=0) and VmathCheck(f) then VmathExec(f)
        else errinp(FName,3);
end;

function VmathCheck(var f:text):boolean;
var 
    i:byte;
    k:shortint;
    b:boolean;
    s:string;
begin
    VmathCheck:=True;
    reset(f);k:=0;
    while VmathCheck and (not eof(f)) do begin
        readln(f,s);
        VmathCheck:=VmathCheck and ValidStr(s);
        b:=True;i:=1;
        while i<length(s) do begin
            inc(i);
            if s[i]=#34 then b:=not b;
            if b then begin
                if s[i]='{' then inc(k);
                if s[i]='}' then dec(k);
            end;
            if k<0 then b:=False;
        end;
        if k>0 then b:=False;
        VmathCheck:=VmathCheck and b;
    end;
end;

procedure VmathExec(var f:text);
var str:string;
begin
    reset(f);
    while not eof(f) do begin
        readln(f,str);
        CmdSyntax(str);
        case upcase(syntax[0]) of
            'IN.'       :   writeln;
            'DELAY'		:	Delay(Str2Int(syntax[1]).val);
            'PAUSE'     :   msg('Press any key to continue.');
        else CmdProcess(str);
        end; 
    end;
    close(f);
end;

end.