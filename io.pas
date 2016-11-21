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
procedure ReadCmd(var s:string);

implementation


procedure ExitProc;
begin
	write(TkMsg,#13#10);
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
		''				:	write(EReport('',ErrorId1));
		'INFO'			:	Info;
		'VER'			:	write(ProgramInfo);
		'HELP'			:	Help;
		'LANG'			:	ActiveLang(syntax[1]);
		'DATE'			:	write(Date);
		'TIME'			:	write(Time);
		'CLEAR'			:	clrscr;
		'EXIT'			:	ExitProc;
		'PREANS'		:	if Trunc(ans)=ans then write(ans:0:0) else write(ans:0:dec);
		'RUN'			:	RunFile(syntax[1],1);
		'GRAPH'			:if (Upcase(syntax[1])='ACTIVE') then ActiveGraph
						else if (Upcase(syntax[1])='EXIT') then ExitGraph
						else write(EReport(syntax[1],ErrorId1));
		'GCD','UCLN'	:if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							write(gcd(Num,syntaxNum));
						end else write(EReport('',ErrorId1));
		'LCM','BCNN'	:if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
							for i:=1 to syntaxNum do
								Num[i]:=Str2Int(syntax[i]).value;
							write(lcm(Num,syntaxNum));
						end else write(EReport('',ErrorId1));				
		'FACT','PTNT'	:if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0) and (syntaxNum=1)
							then write(fact(Str2Int(syntax[1]).value)) else write(EReport('',ErrorId4));
		'DEC'			:if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
							then begin
								dec:=Str2Int(syntax[1]).value;
								write('Dec=',dec);
							end
						else write(EReport('',ErrorId4));
		'PTB2','EQN2'	:if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True)
						and (Str2Num(syntax[3]).check=True) and (syntaxNum=4) then
						write(eqn2(syntax[1],syntax[2],syntax[3]));
		'PLOT'			:if (syntax[1]='fx') and (Str2Int(syntax[2]).check=True) and (Str2Int(syntax[2]).check=True)
						and (syntaxNum=3) then PlotFx1(Str2Int(syntax[2]).value,Str2Int(syntax[3]).value);
	else if EquCheck(syntax,syntaxNum)=True then Equation(s)
	else write(EReport('',ErrorId1));
	end;
end;

procedure ReadCmd(var s:string);
var
	ch:char;
begin
	s:='';
	while readkey<>#13 do begin
		ch:=readkey;
		case ch of
			#13	:write(#13#10#13#10);
//			'~'	:GUI;
		else begin 
			write(ch);
			s:=s+ch;
		end;
		end;
	end;
end;

end.