unit io;
    
interface

uses
	sysutils,crt,dos,lang,basic,equ,programStr,f;

type 
	tSyntax = array[0..256]of string;

var
	syntax: tSyntax;
	syntaxNum:byte;

procedure ReadCmd(s:string);
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

procedure ExitProc;
begin
	write(TkMsg);
	delay(1500);
	exit;
end;

procedure ReadCmd(s:string);
var ch,q:char;
begin
	while readkey<>#13 do begin
		ch:=readkey;
		case ch of
			#27	:begin
					write(#13#10,ExitText);readln(q);
					if lowercase(q)='y' then ExitProc;
				end;
		else write(ch);
		end;			
	end;
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
	case lowercase(syntax[0]) of
		'?','info'		:	Info;
		'help'			:	Help;
		'date','ngay'	:	writeln(Date);
		'time','gio'	:	writeln(Time);
		'clear','xoa'	:	clrscr;
		'print'			:	Print(s);
		'exit'			:	ExitProc;
		'preans'		:	writeln(ans:0:dec);
		'run','chay'	:	RunFile(syntax[1],1);
		'pause'			:	Msg('Press Enter To Continue . . .');
		'funfact'		:	writeln(FunFact(0));
		'delay'			:if Str2Int(syntax[1]).check=True then
							 delay(Str2Int(syntax[1]).value);
		'factor'		:if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0)
							then fact(Str2Int(syntax[1]).value);
		'color'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[2]).check=True)
							then color(Str2Int(syntax[1]).value,Str2Int(syntax[2]).value);
		'dec'			:if (Str2Int(syntax[1]).check=True) then begin
								dec:=Str2Int(syntax[1]).value;
								writeln('Dec=',dec);
							end;
		'ptb2','cqe2'	:if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True) 
						and (Str2Num(syntax[3]).check=True) then 
							cqe2(Str2Num(syntax[1]).value,Str2Num(syntax[2]).value,Str2Num(syntax[3]).value);
	else Equation(s);
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
			CmdProcess(str);
		until eof(f);
		close(f);
	end
	else if w = 1 then writeln(EReport(FName,ErrorId3));
end;

end.