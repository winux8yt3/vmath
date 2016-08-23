program Vmath;

uses sysutils,crt,math,io,lang,programStr,basic;

var 
	tmpString:string;


procedure Welcome;
	var 
		f:text;
	begin
		{$I-}
		assign(f,'Welcome.dat');
		Reset(f);
		{$I+}
		if IOResult<>0 then begin
			assign(f,'Welcome.dat');
			rewrite(f);
			writeln(f,'===========================================');
			writeln(f,'               VMath Xplorer               ');
			writeln(f,'===========================================');
			close(f);
		end;
		ReadFile('Welcome.dat');
		writeln(WelcomeMsg);
	end;

begin
	clrscr;
	write('Choose Your Language [Default is English]');writeln;
	write('Chon ngon ngu [Mac dinh la Tieng Anh]');writeln;
	repeat
		write('(En | Vi) >> ');readln(tmpString);
	until lowercase(tmpString)=en or lowercase(tmpString)=vi;
	ActiveLang(tmpString);
	clrscr;
	Welcome;
	repeat
		writeln;
		write(InputText,' >> ');readln(tmpString);
		CmdProcess(tmpString);
	until tmpString='exit';
end.	