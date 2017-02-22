unit io;

interface

uses
	crt,dos,lang,basic,equ,programStr,f,plot,exec;

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
	else if FileIO(copy(syntax[0],3,length(syntax[0])-3))=0 then RunFile(copy(s,3,length(s)-3))
	else if ValidStr(s) then begin
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
			'GRAPH'			:	if (Upcase(syntax[1])='ACTIVE') then ActiveGraph
									else if (Upcase(syntax[1])='EXIT') then ExitGraph
									else if (Upcase(syntax[1])='CLEAR') then ClearGraph
									else err.id:=1;
			'DP'			:	if (Str2Int(syntax[1]).check=True) and (Str2Int(syntax[1]).value<=20)
									and (Str2Int(syntax[1]).value>=0)
										then begin
											decn:=Str2Int(syntax[1]).value;
											write('Decimal Place(s)=',decn);
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

function InputChk(s:string):boolean;
	function IsDual(c1,c2:Char):Boolean;
	var 
		Chk:boolean=True;
		k:integer=0;
	begin
		IsDual:=True;
		while IsDual and (i<length(s)) do begin
			if s[i]=#34 then Chk:=not Chk;
			if Chk then begin
				if s[i]=c1 then inc(k);
				if s[i]=c2 then dec(k);
			end;
			if k<0 then IsDual:=False;
		end;
		if k>0 then IsDual:=False;
	end;
begin
	InputChk:=True;
	if not IsDual('(',')') then InputChk:=False;
end;

end.