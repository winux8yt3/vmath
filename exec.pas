unit exec;
    
interface
    
//procedure FileProcess(var f:text);
procedure RunFile(FName:string);
function VmathCheck(var f:text):boolean;
    
implementation

uses
    f,io,basic,programstr;

procedure RunFile(FName:string);
var 
	f:text;
begin
	if pos('.',FName)=0 then FName:=FName+'.vmath';
	if FileIO(f)=0 then begin
		//FileProcess(f);
		close(f);
	end
	else err.id:=3;
end;

function VmathCheck(var f:text):boolean;
begin
	// Check Grammar before Exec
end;
{
procedure VmathExec(var f:text);
var str:string;
begin
	while not eof(f) do begin
		readln(f,str);
		CmdSyntax(str);
		case syntax[0] of
			'DELAY'		:	Delay(Str2Int(syntax[1]).value);
			'PRINT'		:	Print(str);
		else CmdProcess(str);
		end; 
	end;
end;
}

end.