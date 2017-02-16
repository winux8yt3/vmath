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

implementation


procedure ExitProc;
begin
	write(TkMsg,#13#10);
	delay(1500);
	exit;
end;

procedure CmdSyntax(s:string);
var 
	p:byte;  //Position of blank space
begin
	fillchar(syntax,sizeof(syntax),0);
	s:=trim(s);
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
	ErrInp(s,0);
	if s='' then DoNothing
	else begin
		case Upcase(syntax[0]) of
			'FPC'			:	write('Compiled With ',FPCInfo);
		// syntaxNum=1
			'INFO'			:	Info;
			'VER'			:	write(ProgramInfo);
			'HELP'			:	Help;
			'DATE'			:	write(Date);
			'TIME'			:	write(Time);
			'CLS'			:	clrscr;
			'EXIT'			:	ExitProc;
		// syntaxNum=2
			'LANG'			:	ActiveLang(syntax[1]);
			'RUN'			:	RunFile(syntax[1]);
			'GRAPH'			:	if (Upcase(syntax[1])='ACTIVE') then ActiveGraph
									else if (Upcase(syntax[1])='EXIT') then ExitGraph
									else err.id:=1;
			'DP'			:	if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
									and (Str2Int(syntax[1]).value>=0)
										then begin
											dec:=Str2Int(syntax[1]).value;
											write('Decimal Place(s)=',dec);
										end
										else err.id:=4;
		// syntaxNum=0
			'GCD','UCLN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
									for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
									write(Arraygcd(Num,syntaxNum,1));
								end else err.id:=1;
			'LCM','BCNN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
									for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
									write(Arraylcm(Num,syntaxNum,1));
								end else err.id:=1;	
			'FACT','PTNT'	:	if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0) and (syntaxNum=1)
									then write(fact(Str2Int(syntax[1]).value)) else err.id:=4;
			'PTB2','EQN2'	:	if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True)
									and (Str2Num(syntax[3]).check=True) and (syntaxNum=3) then
										write(eqn2(syntax[1],syntax[2],syntax[3])) else err.id:=4;
			'PLOT'			:	if (syntax[1]='fx') and (Str2Int(syntax[2]).check=True) and (Str2Int(syntax[2]).check=True)
									and (syntaxNum=3) then PlotFx1(Str2Int(syntax[2]).value,Str2Int(syntax[3]).value)
										else err.id:=1;
		else if (not Variable(s)) and (not TrueFalse(s)) then err.id:=1;
		end;
	end;
	write(EReport);
end;
end.