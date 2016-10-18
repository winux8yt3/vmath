unit f;
    
interface

uses 
    basic,lang;

function ChkFile(FName:string):word;
//procedure FileProcess(F:text);
// This Function will be implemented in version 1.0

implementation

function ChkFile(FName:string):word;
var f:text;
begin
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	ChkFile:=IOResult;
end;
{
procedure FileProcess(F:Text);
begin
// Truncate & Seek
end;
}

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
//			FileProcess(FName);
		until eof(f);
		close(f);
	end
	else if w = 1 then writeln(EReport(FName,ErrorId3));
end;

end.