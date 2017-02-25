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
    procedure ExitProc;
    begin
        CmdProcess:=TkMsg;
        delay(1500);
        exit;
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
            'INFO'			:	Info;
            'VER'			:	CmdProcess:=ProgramInfo;
            'HELP'			:	Help;
            'DATE'			:	CmdProcess:=Date;
            'TIME'			:	CmdProcess:=Time;
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
                                            CmdProcess:='Decimal Place(s) = '+Num2Str(decn);
                                        end
                                        else err.id:=4;
        // syntaxNum=0
            'GCD','UCLN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
                                    CmdProcess:=Num2Str(Arraygcd(Num,syntaxNum,1));
                                end else err.id:=1;
            'LCM','BCNN'	:	if (NumInCheck(syntax,syntaxNum)=true) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).value;
                                    CmdProcess:=Num2Str(Arraylcm(Num,syntaxNum,1));
                                end else err.id:=1;	
            'FACT','PTNT'	:	if (Str2Int(syntax[1]).check=True) and (Str2Num(syntax[1]).value>0) and (syntaxNum=1)
                                    then CmdProcess:=(fact(Str2Int(syntax[1]).value)) else err.id:=4;
            'PTB2','EQN2'	:	if (Str2Num(syntax[1]).check=True) and (Str2Num(syntax[2]).check=True)
                                    and (Str2Num(syntax[3]).check=True) and (syntaxNum=3) then
                                        CmdProcess:=(eqn2(syntax[1],syntax[2],syntax[3])) else err.id:=4;
            'PLOT'			:	if (syntax[1]='fx') and (Str2Int(syntax[2]).check=True) and (Str2Int(syntax[2]).check=True)
                                    and (syntaxNum=3) then PlotFx1(Str2Int(syntax[2]).value,Str2Int(syntax[3]).value)
                                        else err.id:=1;
        else if FileExist(copy(syntax[0],3,length(syntax[0])-3)) then RunFile(copy(s,3,length(s)-3))
        else if (not Variable(s)) and (not TrueFalse(s)) then err.id:=1;
        end;
    end;
    if err.id<>0 then CmdProcess:=(EReport);
end;

function ValidStr(s:string):boolean;
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
    ValidStr:=IsDual('(',')') and IsDual('[',']');
end;

end.