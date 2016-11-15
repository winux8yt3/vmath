unit io;

interface

uses
	crt,dos,lang,basic,equ,programStr,f,plot;

var
	Num:tNum;
	i:word;
	syntax: tStr;
	syntaxNum:byte;

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure RunFile(FName:string;w:byte);

implementation


procedure ExitProc;
begin
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
	s:=trimright(s);
	CmdSyntax(s);
	case Upcase(syntax[0]) of
		''				:	writeln(EReport('',ErrorId1));
		'?','INFO'		:	Info;
		'HELP'			:	Help;
		'ACTIVEGRAPH'	:	ActiveGraph;
		'EXITGRAPH'		:	ExitGraph;
		'LANG'			:	ActiveLang(syntax[1]);
		'DATE'			:	writeln(Date);
		'TIME'			:	writeln(Time);
		'CLEAR'			:	clrscr;
		'EXIT'			:	ExitProc;
		'PREANS'		:	writeln(ans:0:dec);
		'RUN'			:	RunFile(syntax[1],1);
		'TIP'			:	writeln(FunFact(0));
		'GCD','UCLN'	:if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(gcd(Num,syntaxNum));
						end else write(EReport('',ErrorId1));
		'LCM','BCNN'	:if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							writeln(lcm(Num,syntaxNum));
						end else write(EReport('',ErrorId1));				
		'FACT','PTNT'	:if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0) and (syntaxNum=1)
							then writeln(fact(Str2Int(syntax[1]).value)) else writeln(EReport('',ErrorId4));
		'DEC'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
							then begin
								dec:=Str2Int(syntax[1]).value;
								writeln('Dec=',dec);
							end
						else writeln(EReport('',ErrorId4));
		'PTB2','EQN2'	:if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True)
						and (Str2Num(syntax[3]).check=True) and (syntaxNum=4) then
						writeln(eqn2(syntax[1],syntax[2],syntax[3]));
		'PLOT'			:if (syntax[1]='fx') and (Str2Int(syntax[2]).check=True) and (Str2Int(syntax[2]).check=True)
						and (syntaxNum=3) then PlotFx1(Str2Int(syntax[2]).value,Str2Int(syntax[3]).value);
	else if EquCheck(syntax,syntaxNum)=True then Equation(s)
	else write(EReport('',ErrorId1));
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