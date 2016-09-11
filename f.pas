unit f;
    
interface

uses 
    basic,lang;

function ChkFile(FName:string):word;
//procedure CodeProcess(F:text);

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