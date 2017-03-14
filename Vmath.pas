{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license.
}
program Vmath;

uses sysutils,crt,io,lang,programStr,basic,equ,f,exec;
// vmathui;
var
	tmpstr:String = '';
	i:longint;

procedure console();
begin
	Window(1,1,WindMaxX,WindMaxY);
	clrscr;
	writeln('Choose Your Language [Default is English]');
	writeln('Chon ngon ngu [Mac dinh la Tieng Anh]');
	write('(En | Vi) >> ');ActiveLang(#0);
	clrscr;
	if FileIO('vmath.cfg')=0 then ReadCfg;
	write(LoadText);
	clrscr;
	write(Info,#13#10,WelcomeMsg);
	RunFile('start.vmath');
	repeat
		write(#13#10#13#10,'[Vmath] >> ');readln(tmpstr);
		if Trim(tmpStr)<>'' then write(CmdProcess(tmpstr));
	until tmpstr='exit';
end;

begin
	writeln(Info);
	if (paramstr(1)='-c') then begin
		for i:=2 to ParamCount do begin
			tmpstr:=tmpstr+paramstr(i);
			writeln(#13#10,CmdProcess(tmpstr));
		end
	end else
	if (Paramstr(1)<>'') and (FileIO(paramstr(1))=0) then begin
		writeln('[VMath] >> Processing . . .');
		RunFile(paramstr(1));
	end
	else console();
end.
