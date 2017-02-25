unit io;

interface

uses
    crt,dos,lang,basic,equ,programStr,f,plot,exec;

var
    Num:tNum;
    i:word;
    syntax: tStr;
    syntaxNum:byte;

function CmdProcess(s:string):string;

implementation

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

function CmdProcess(s:string):string;
    procedure ClsProc;
    begin
        clrscr;
        // UI Screen Clear Goes Here
    end;
    procedure ExitProc;
    begin
        CmdProcess:=TkMsg;
        delay(1500);
        exit;
        // UI Form Close goes here
    end;
begin
    CmdSyntax(s);
    ErrInp(s,0);
    CmdProcess:='';
    if s='' then DoNothing
    else if ValidStr(s) then begin
        case Upcase(syntax[0]) of
            'FPC'			:	CmdProcess:='Compiled With '+FPCInfo;
        // syntaxNum=1
            'INFO'			:	cmdProcess:=Info+#13#10+'Build Time: '+BuildTime;
            'VER'			:	CmdProcess:=ProgramName+' '+Version+' Build '+BuildNum;
            'HELP'			:	Help;
            'DATE'			:	CmdProcess:=Date;
            'TIME'			:	CmdProcess:=Time;
            'CLS'			:	ClsProc;
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
                                            CmdProcess:='Decimal Place(s) = '+Num2Str(decn);
                                        end
                                        else err.id:=4;
        // syntaxNum=0
            'GCD','UCLN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
                                    CmdProcess:=Num2Str(Arraygcd(Num,syntaxNum,1));
                                end else err.id:=4;
            'LCM','BCNN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
                                    CmdProcess:=Num2Str(Arraylcm(Num,syntaxNum,1));
                                end else err.id:=4;	
            'FACT','PTNT'	:	if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0) and (syntaxNum=1)
                                    then CmdProcess:=(fact(Str2Int(syntax[1]).value)) else err.id:=4;
            'PTB2','EQN2'	:	if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True)
                                    and (Str2Num(syntax[3]).check=True) and (syntaxNum=3) then
                                        CmdProcess:=(eqn2(syntax[1],syntax[2],syntax[3])) else err.id:=4;
            'PLOT'			:	if (syntax[1]='fx') and (Str2Int(syntax[2]).check=True) and (Str2Int(syntax[2]).check=True)
                                    and (syntaxNum=3) then PlotFx1(Str2Int(syntax[2]).value,Str2Int(syntax[3]).value)
                                        else err.id:=4;
        // else if (syntax[0][1]='.') and (syntax[0][2]='\') and FileExist(copy(syntax[0],3,length(syntax[0])-3)) then RunFile();
        else if (not Variable(s)) and (not TrueFalse(s)) then err.id:=1;
        end;
    end;
    if err.id<>0 then CmdProcess:=(EReport);
end;

end.