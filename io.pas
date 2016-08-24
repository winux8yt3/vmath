unit io;
    
interface

uses
	sysutils,crt,dos,lang,basic;

type 
	tSyntax = array[0..256]of string;

var
	syntax: tSyntax;
	syntaxNum:byte;
	cmd:string;

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure ReadFile(FName:string);
procedure Equation(s:string);

procedure Pause;
procedure Print;

implementation

procedure CmdSyntax(s:string);
var 
	p:byte;  //Position of word
begin
	syntaxNum:=0;
    s:=Trim(s);
	p:=pos(' ',s);
	if p=0 then syntax[0]:=s
	else
		repeat
			syntax[syntaxNum]:=copy(s,1,p-1);
			delete(s,1,p);
			inc(syntaxNum);
		until pos(' ',s)=0;
	syntaxNum:=length(s);
	syntax[p]:=copy(s,1,syntaxNum);
end;

procedure CmdProcess(s:string);
begin
	CmdSyntax(s);
	s:=lowercase(s);
	cmd:=s;
	case syntax[0] of
		'?','info'	:	Info;
		'clear'		:	Clear;
		'date'		:	Date;
		'time'		:	Time;
		'pause'		:	Pause;
		'run'		:	ReadFile(syntax[1]);
		'exit'		:	exit;
//		'color'		:	color(Str2Int(syntax[1]),Str2Int(syntax[2]));
	else Equation(s:string);
	end;
end;
{
procedure Equation(s:string);
begin

end;
}
procedure ReadFile(FName:string);
var 
	f:text;
	extension,str:string;
	k:integer;
begin
	FName:=Trim(FName);
	{$I-}
	assign(f,FName);
	Reset(f);
	{$I+}
	if IOResult<>0 then write(ErrorId3)
	else begin
		k:=length(Fname)-pos('.',Fname);
		extension:=copy(Fname,pos('.',Fname)+1,k);
		repeat
			readln(f,str);
			if extension='vmath' then CmdProcess(str)
				else writeln(str);
		until eof(f);
		close(f);
	end;
end;

procedure Pause;
begin
	readln;
end;

procedure Print;
var i:integer;
begin
	for i:=1 to syntaxNum do write(syntax[i],' ');
end;

initialization
begin
	Color(7,0);
end;

end.