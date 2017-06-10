{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
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
procedure FCmdProcess(s:string;var f:text);

implementation

procedure CmdSyntax(s:string);
var 
    p:byte;  //Position of blank space
begin
    fillchar(syntax,sizeof(syntax),#0);
    s:=CleanSpace(s);
    syntaxNum:=0;
    p:=pos(' ',s);
    while p<>0 do begin
        if s[1]='"' then begin
            delete(s,1,1);
            p:=pos('"',s);
        end;
        syntax[syntaxNum]:=copy(s,1,p-1);
        delete(s,1,p);
        s:=TrimLeft(s);
        inc(syntaxNum);
        p:=pos(' ',s);
    end;
    p:=length(s);
    if s[1]='"' then begin
        delete(s,1,1);
        dec(p,2);
    end;
    syntax[syntaxNum]:=copy(s,1,p);
end;

function CmdProcess(s:string):string;
var Out:boolean=True;
    procedure NoOut;
    begin
        Out:=False;
        CmdProcess:='';
    end;
    procedure ClsProc;
    begin
        clrscr;
        NoOut;
        // UI Screen Clear Goes Here
    end;
    procedure ExitProc;
    begin
        NoOut;
        CmdProcess:=TkMsg;
        exit;
        // UI Form Close goes here
    end;
    procedure HelpCmd;
    begin
        writeln('INFO,TT        : '+HelpTextInfo);
        writeln('CLS,XOAMH      : '+HelpTextClear);
        writeln('DATE,NGAY      : '+HelpTextDate);
        writeln('DP             : '+HelpTextdecn);
        writeln('EXIT           : '+HelpTextExit);
        writeln('FACT,PTNT      : '+HelpTextFact);
        writeln('GCD,UCLN       : '+HelpTextGcd);
        writeln('GRAPH,DH       : '+HelpTextGraph);
        writeln('LCM,BCNN       : '+HelpTextLcm);
        writeln('HELP           : '+HelpTextHelp);
        writeln('PTB2,EQN2      : '+HelpTexteqn2);
        writeln('TIME,TG        : '+HelpTextTime);
        writeln('VER,PB         : '+HelpTextVer);
        writeln('EQUATION    + | - | * | / | ^');
        NoOut;
    end;
    procedure PlotProc;
    var v:tStr;
        b:boolean=True;
    begin
        NoOut;
        case syntax[1] of
            'fx'    :   begin
                            for i:=2 to syntaxNum do begin
                                b:=b and Str2Num(syntax[i]).chk;
                                if b then v[i-1]:=syntax[i];
                            end;
                            if b and (syntaxNum<8) then PlotFx2(v,syntaxNum-1) else err.id:=4;
                        end;
            'xy'    :   if (syntaxNum=1) then XYPlot(0,0)
                        else if (syntaxNum=3) and (Str2Int(syntax[2]).chk) and (Str2Int(syntax[3]).chk) 
                        then XYPlot(Str2Int(syntax[2]).val,Str2Int(syntax[3]).val) else err.id:=1;
        else err.id:=1;
        end;
    end;
begin
    ErrInp(s,0);
    CmdProcess:='';
    if ValidStr(s) then begin
        CmdSyntax(s);
        case Upcase(syntax[0]) of
            'FPC'		    :	CmdProcess:='Compiled With '+FPCInfo;
        // syntaxNum=1
            'IN','PRINT'    :   begin
                                    NoOut;
                                    Print(s);
                                end;
            'INFO','TT'		:	cmdProcess:=Info+#13#10+'Build Time: '+BuildTime;
            'VER','PB'		:	CmdProcess:=ProgramName+' '+Version+' Build '+BuildNum;
            'DATE','NGAY'   :	CmdProcess:=Date;
            'TIME','TG'     :	CmdProcess:=Time;
            'CLS','XOAMH'   :	ClsProc;
            'EXIT','THOAT'	:	ExitProc;
            'HELP','GIUP'   :   HelpCmd;
        // syntaxNum=2
            'DEC2BIN'       :   if (Str2Int(syntax[1]).chk) then CmdProcess:=Dec2Bin(Str2Int(syntax[1]).val);
            'DEC2HEX'       :   if (Str2Int(syntax[1]).chk) then CmdProcess:=Dec2Hex(Str2Int(syntax[1]).val);
            'RUN','CHAY'    :   begin
                                    if RunFile(syntax[1]) then NoOut;
                                end;
            'GRAPH','DH'    :	begin
                                    NoOut;
                                    case Upcase(syntax[1]) of 
                                        'START','BAT'   :   ActiveGraph;
                                        'EXIT','TAT'    :   ExitGraph;
                                        'CLEAR','XOA'   :   ClearGraph;
                                        'RESTART','KDL' :   RestartGraph;
                                    else err.id:=1;
                                    end;
                                end;
            'DP','TP'	    :	if (Str2Int(syntax[1]).chk) and (Str2Int(syntax[1]).val<=20)
                                and (Str2Int(syntax[1]).val>=0)
                                    then begin
                                        decn:=Str2Int(syntax[1]).val;
                                        CmdProcess:=DPText+' = '+Num2Str(decn);
                                    end
                                    else err.id:=4;
        // syntaxNum>2
            'GCD','UCLN'    :	if (NumInCheck(syntax,syntaxNum)) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).val;
                                    CmdProcess:=Num2Str(Arraygcd(Num,syntaxNum,1));
                                end else err.id:=4;
            'LCM','BCNN'	:	if (NumInCheck(syntax,syntaxNum)) and (syntaxNum>1) then begin
                                    for i:=1 to syntaxNum do Num[i]:=Str2Int(syntax[i]).val;
                                    CmdProcess:=Num2Str(Arraylcm(Num,syntaxNum,1));
                                end else err.id:=4;	
            'FACT','PTNT'	:	if (Str2Int(syntax[1]).chk) and (Str2Num(syntax[1]).val>0) and (syntaxNum=1)
                                then CmdProcess:=(fact(Str2Int(syntax[1]).val)) else errinp(syntax[1],4);
            'PTB2','EQN2'	:	if (Str2Num(syntax[1]).chk) and (Str2Num(syntax[2]).chk=True)
                                and (Str2Num(syntax[3]).chk) and (syntaxNum=3) then
                                    CmdProcess:=(eqn2(syntax[1],syntax[2],syntax[3])) else err.id:=4;
            'PLOT','VE'     :   if syntaxNum<7 then PlotProc;
        else if not Variable(s,CmdProcess) then
                if not TrueFalse(s,CmdProcess) then
                    if not Equation(s,CmdProcess) then errinp(syntax[0],1);
        end;
    end else err.id:=1;
    if Str2Int(CmdProcess).chk then CmdProcess:=Num2Str(Trunc(Str2Int(CmdProcess).val));
    if err.id>0 then CmdProcess:=EReport
    else if Out then CmdProcess:=#13#10+'[Ans] >> '+CmdProcess;
end;

procedure FCmdProcess(s:string;var f:text);
var str:string;
    procedure Doc(v:string);
    var s:string;
    begin
        if IsVar('_'+v) then begin
            readln(s);
            readln;
            if Str2Num(s).chk then AssignVar(v,Str2Num(s).val) else errinp(v,1);
        end;
    end;
    procedure ifState(s:string);
    var 
        st:string;
    begin
        delete(s,1,2);
        if bool(s) then
            repeat
                readln(f,st);
                if Upcase(st)<>'END' then FCmdProcess(st,f);
            until Upcase(st)='END';
    end;
begin
    if Upcase(s)='' then readln(f,str) else str:=s;
    if (Upcase(str)<>'END') or not (copy(str,1,2)='//') then begin
        CmdSyntax(str);
        case upcase(syntax[0]) of
            'IN.'       :   writeln;
            'DOC'       :   Doc(syntax[1]);
            'DOCB'      :   begin
                                write(syntax[1],':');Doc(syntax[1]);
                            end;
            'DELAY'		:	Delay(Str2Int(syntax[1]).val);
            'PAUSE'     :   msg('Press any key to continue.');
            'IF'        :   IfState(str);
        else CmdProcess(str);
        end;
    end;
end;

end.