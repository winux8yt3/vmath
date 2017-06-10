{
	Copyright (c) Winux8YT3. 
	License Under MIT License. See LICENSE in root folder for license.
}
unit exec;
    
interface

function RunFile(FName:string):boolean;
function VmathCheck(var f:text):boolean;

implementation

uses
    f,io,basic,programstr,crt,equ;

function RunFile(FName:string):boolean;
var 
    f:text;
begin
    if pos('.',FName)=0 then FName:=FName+'.vmath';
    assign(f,FName);
    RunFile:=FileExist(FName) and VmathCheck(f);
    if RunFile then begin
        reset(f);
        while not eof(f) do FCmdProcess('',f);
        close(f);
    end else errinp(FName,3);
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
    close(f);
end;

end.