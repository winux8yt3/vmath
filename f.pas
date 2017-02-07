unit f;
    
interface

uses basic,programstr,crt;

function ChkFile(FName:string):word;
//procedure FileProcess(var f:text);
procedure RunFile(FName:string);
procedure ReadLang(FName:string);
procedure ReadCfg;

implementation

uses lang,io;

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
		'BGCOLOR'	:	if (Str2Int(val).check=True) and (Str2Int(val).value>=0) then bgcolor(Str2Int(val).value);
		'TXCOLOR'	:	if (Str2Int(val).check=True) and (Str2Int(val).value>=0) then txColor(Str2Int(val).value);
		'ERRHIDE'	:	if Str2Bool(val).check=True then ErrHide:=Str2Bool(val).value;
		'DEC'		:	if (Str2Int(val).check=True) and (Str2Int(val).value>=0) and (Str2Int(val).value<=20)
						then dec:=Str2Int(val).value;
	end;
end;

procedure ReadLangVar(s,val:string);
begin
	case Upcase(s) of
		'DONEMSG'		:	DoneMsg:=val;
		'WELCOMEMSG'	:	WelcomeMsg:=val+' '+ProgramInfo;
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

procedure RunFile(FName:string);
var 
	f:text;
begin
	if pos('.',FName)=0 then FName:=FName+'.vmath';
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	if IOResult = 0 then begin
		//FileProcess(f);
		close(f);
	end
	else err.id:=3;
end;
{
procedure FileProcess(var f:text);
var str:string;
begin
	while not eof(f) do begin
		readln(f,str);
		CmdSyntax(str);
		case syntax[0] of
			'DELAY'		:	Delay(Str2Int(syntax[1]).value);
			'PRINT'		:	Print(str);
		else CmdProcess(str);
		end; 
	end;
end;
}
end.