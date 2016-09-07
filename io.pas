unit io;
    
interface

uses
	sysutils,crt,dos,lang,basic,equ;

type 
	tSyntax = array[0..256]of string;

var
	syntax: tSyntax;
	syntaxNum:byte;

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure RunFile(FName:string;w:byte);

implementation

procedure Print(s:string);
begin
	delete(s,1,5);
	s:=trimleft(s);
	writeln(s);
end;

procedure ClrSyntax;
var i:word;
begin
	for i:=0 to syntaxNum do syntax[syntaxNum]:='';
	syntaxNum:=0;
end;

procedure CmdSyntax(s:string);
var 
	p:byte;  //Position of blank space
begin
	s:=lowercase(s);
	syntaxNum:=0;
	p:=pos(' ',s);
	while p<>0 do begin
		syntax[syntaxNum]:=copy(s,1,p-1);
		delete(s,1,p-1);
		inc(syntaxNum);
		s:=Trim(s);
		p:=pos(' ',s);
	end;
	syntax[syntaxNum]:=copy(s,1,length(s));
end;

procedure CmdProcess(s:string);
begin
	ClrSyntax;
	s:=Trim(s);
	CmdSyntax(s);
	case syntax[0] of
		'?','info'		:	Info;
		'help'			:	Help;
		'date'			:	writeln(Date);
		'time'			:	writeln(Time);
		'clear'			:	clrscr;
		'print'			:	Print(s);
		'cat'			:	Cat(s);
		'preans'		:	writeln(ans:0:dec);
		'run'			:	RunFile(syntax[1],1);
		'pause'			:	Msg('Press Enter To Continue . . .');
		'funfact'		:	writeln(FunFact(0));
		'delay'			:if Str2Num(syntax[1]).check=True then
							 delay(Str2Int(syntax[1]));
		'color'			:if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True) then
								color(Str2Int(syntax[1]),Str2Int(syntax[2]));
		'dec'			:begin
								dec:=Str2Int(syntax[1]);
								writeln('Dec=',dec);
							end;
		'ptb2','cqe2'	:if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True) 
						and (Str2Num(syntax[3]).check=True) then 
							cqe2(Str2Num(syntax[1]).value,Str2Num(syntax[2]).value,Str2Num(syntax[3]).value);
		'exit'			:	begin
								write(TkMsg);
								delay(1500);
								exit;
							end;
	else Equation(s);
	end;
end;

function ChkFile(FName:string):word;
var f:text;
begin
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	ChkFile:=IOResult;
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
			CmdProcess(str);
		until eof(f);
		close(f);
	end
	else if w = 1 then writeln(EReport(FName,ErrorId3));
end;
end.