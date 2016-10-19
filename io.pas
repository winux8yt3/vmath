unit io;
    
interface

uses
	crt,dos,lang,basic,equ,programStr,f,plot,sysutils;

var
	Num:tNum;
	i:word;
	syntax: tStr;
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

procedure ExitProc;
begin
	writeln;
	write(TkMsg);
	delay(1500);
	exit;
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
		delete(s,1,p);
		inc(syntaxNum);
		p:=pos(' ',s);
	end;
	syntax[syntaxNum]:=copy(s,1,length(s));
end;

procedure CmdProcess(s:string);
begin
	ClrSyntax;
	s:=CleanSpace(s);
	CmdSyntax(s);
	case lowercase(syntax[0]) of
		''				:	writeln(EReport('',ErrorId1));
		'?','info'		:	Info;
		'help'			:	Help;
		'lang'			:	ActiveLang(syntax[1]);
		'date'			:	writeln(Date);
		'time'			:	writeln(Time);
		'clear'			:	clrscr;
		'print'			:	Print(s);
		'exit'			:	ExitProc;
		'preans'		:	writeln(ans:0:dec);
		'run'			:	RunFile(syntax[1],1);
		'funfact'		:	writeln(FunFact(0));
		'gcd','ucln'	:if (NumInCheck(syntax,syntaxNum)=true) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(gcd(Num,syntaxNum));
						end else write(EReport('',ErrorId1));
		'lcm','bcnn'	:if (NumInCheck(syntax,syntaxNum)=true) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(lcm(Num,syntaxNum));
						end else write(EReport('',ErrorId1));				
		'fact','ptnt'	:if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0)
							then writeln(fact(Str2Int(syntax[1]).value)) else writeln(EReport('',ErrorId4));
		'color'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[2]).check=True)
							then color(Str2Int(syntax[1]).value,Str2Int(syntax[2]).value)
								else writeln(EReport('',ErrorId4));
		'dec'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
							then begin
								dec:=Str2Int(syntax[1]).value;
								writeln('Dec=',dec);
							end
						else writeln(EReport('',ErrorId4));
		'ptb2','eqn2'	:writeln(eqn2(syntax[1],syntax[2],syntax[3]));
		'plot'			:fxplot(copy(s,6,length(s)-6));
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