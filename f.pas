unit f;
    
interface

uses basic,programstr;

function ChkFile(FName:string):word;
procedure FileProcess(FName:string);
procedure RunFile(FName:string;w:byte);
procedure ReadLang(FName:string);
procedure ReadCfg;
// This Function will be implemented in version 1.0

implementation

uses lang;

function ChkFile(FName:string):word;
var f:text;
begin
	assign(f,FName);
	{$I-}
		Reset(f);
	{$I+}
	ChkFile:=IOResult;
end;

procedure VarCut(var s,val:string);
begin
	val:=copy(s,pos('=',s)+1,length(s)-pos('=',s));
	delete(s,pos('=',s),length(s)-pos('=',s)+1);
end;

procedure ReadCfgVar(s,val:string);
begin
	case Upcase(s) of
		'BGCOLOR'	:	bgcolor(Str2Int(val).value);
		'TXCOLOR'	:	txColor(Str2Int(val).value);
		'ERRHIDE'	:	ErrHide:=Str2Bool(val).value;
	end;
end;

procedure ReadCfg;
var 
	val,s:string;
	f:text;
begin
	assign(f,'vmath.cfg');
	Reset(f);
	while not eoln(f) do begin
		readln(f,s);
		VarCut(s,val);
		if val<>'' then begin
			ReadCfgVar(s,val);
			writeln('[',s,']:=',val);
		end;
	end;
end;

procedure ReadLang(FName:string);
var 
	val,s:string;
	f:text;
begin
	assign(f,FName);
	Reset(f);
	while not eoln(f) do begin
		readln(f,s);
//		ReadLangVar(s,val);
	end;
end;

procedure RunFile(FName:string;w:byte);
var 
	f:text;
	str:string;
begin
	if pos('.',FName)=0 then FName:=FName+'.vmath';
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	if IOResult = 0 then begin
		repeat
			readln(f,str);
			FileProcess(FName);
		until eof(f);
		close(f);
	end
	else if w = 1 then write(EReport(FName,ErrorID3));
end;

procedure FileProcess(FName:string);
begin
	// Truncate & Seek
end;

end.