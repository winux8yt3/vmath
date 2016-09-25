unit f;
    
interface

uses 
    basic,lang;

function ChkFile(FName:string):word;
//procedure FileProcess(F:text);
// This Function will be implemented in version 1.1

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

end.