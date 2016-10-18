unit io;
    
interface

uses
	crt,dos,lang,basic,equ,programStr,f,graphic;

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
	case Upcase(syntax[0]) of
		''				:	writeln(EReport('',ErrorId1));
		'?','INFO'		:	Info;
		'HELP'			:	Help;
		'LANG'			:	ActiveLang(syntax[1]);
		'DATE'			:	writeln(Date);
		'TIME'			:	writeln(Time);
		'CLEAR'			:	clrscr;
		'PRINT'			:	Print(s);
		'EXIT'			:	ExitProc;
		'PREANS'		:	writeln(ans:0:dec);
		'RUN'			:	RunFile(syntax[1],1);
		'FUNFACT'		:	writeln(FunFact(0));
		'GCD','UCLN'	:if NumInCheck(syntax,syntaxNum)=true then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(gcd(Num,syntaxNum));
						end;
		'LCM','BCNN'	:if NumInCheck(syntax,syntaxNum)=true then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(lcm(Num,syntaxNum));
						end;				
		'FACT','PTNT'	:if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0)
							then writeln(fact(Str2Int(syntax[1]).value)) else writeln(EReport('',ErrorId4));
		'COLOR'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[2]).check=True)
							then color(Str2Int(syntax[1]).value,Str2Int(syntax[2]).value)
								else writeln(EReport('',ErrorId4));
		'DEC'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
							then begin
								dec:=Str2Int(syntax[1]).value;
								writeln('Dec=',dec);
							end
						else writeln(EReport('',ErrorId4));
		'PTB2','EQN2'	:writeln(eqn2(syntax[1],syntax[2],syntax[3]))
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