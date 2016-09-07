unit lang;
    
interface

uses sysutils,programStr;

var 
    ProgramInfo,WelcomeMsg,DoneMsg,LangLoadMsg,TkMsg:string;
    LoadText,DateText,TimeText,InputText,OutputText,InfoText:string;
    DayNum:array[0..6] of string;
    HelpTextClear,HelpTextColor,HelpTextDate,HelpTextDec,HelpTextExit:string;
    HelpTextHelp,HelpTextInfo,HelpTextPause,HelpTextPreans,HelpTextPrint:string;
    HelpTextRun,HelpTextTime,HelpTextcqe2,HelpTextCat:string;
    Fact1,Fact2,Fact3,Fact4:string;
    cqe0Text,cqe1Text,cqe2Text:string;
    ErrorId0,ErrorId1,ErrorId2,ErrorId3:string;

procedure ActiveLang(s:string);

implementation

procedure LangVi;
begin
    write('Dang Tai Goi Ngon Ngu . . .');writeln;

    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Ban Dung So '+VersionBuild+'.';
    DoneMsg:='Xong!';
    WelcomeMsg:='Chao mung ban den voi '+ProgramInfo+' '+VersionInfo;
    TkMsg:='Cam on ban da tham gia chuong trinh thu nghiem VMath BETA';

    LoadText:='Dang Tai...';
    InfoText:='Lap Trinh Boi Winux8yt3. Website Du An: bit.ly/vmath-xplorer';
    DateText:='Hom nay la: ';
    TimeText:='Bay gio la: ';
    InputText:='Nhap';
    OutputText:='Xuat';
    
    DayNum[0]:='Chu Nhat';
    DayNum[1]:='Thu Hai';
    DayNum[2]:='Thu Ba';
    DayNum[3]:='Thu Tu';
    DayNum[4]:='Thu Nam';
    DayNum[5]:='Thu Sau';
    DayNum[6]:='Thu Bay';

    HelpTextInfo:='Thong tin ve phan mem';
    HelpTextClear:='Xoa man hinh';
    HelpTextColor:='Thay doi mau chu va phong nen';
    HelpTextDate:='In ra ngay';
    HelpTextDec:='Do dai phan thap phan trong ket qua toan hoc';
    HelpTextExit:='Thoat';
    HelpTextHelp:='Huong dan su dung';
    HelpTextPause:='Tam dung chuong trinh';
    HelpTextPreans:='In ra ket qua luc truoc';
    HelpTextPrint:='In dong chu';
    HelpTextRun:='Chay File .vmath';
    HelpTextTime:='In ra thoi gian';
    HelpTextcqe2:='Tinh phuong trinh bac 2';
    HelpTextCat:='Noi 2 File Text';

    Fact1:='Ti le chieu dai va chieu rong cua to giay loai A la 1/sqrt(2)';
    Fact2:='x^m <> y^n (x,y la so nguyen to; m,n la so tu nhien) [Euler]';
    Fact3:='| x,y <> 0 ; x=y |-> x^2=xy -> x^2-y^2=x^y-y^2 -> x+y=y -> 2y=y -> 2=1 ?';
    Fact4:='| f(n) = n^2 + n + 41 | n < 40 | => f(n) la so nguyen to [Euler]';

    cqe0Text:='Khong co nghiem';
    cqe1Text:='1 nghiem: ';
    cqe2Text:='2 nghiem: ';

    ErrorId1:='Sai cau truc hoac sai cau lenh.';
    ErrorId2:='Phep chia cho 0.';
    ErrorId3:='Tep khong ton tai.';
end;

procedure LangEn;
begin
    write('Loading Language Pack . . .');writeln;

    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Build '+VersionBuild+'.';
    DoneMsg:='Done';    
    WelcomeMsg:='Welcome you to '+ProgramInfo;
    TkMsg:='Thanks for participating VMath BETA Program';

    LoadText:='Loading...';
    InfoText:='Programmed by Winux8yt3. Project Website: bit.ly/vmath-xplorer';
    DateText:='Today is: ';
    TimeText:='Now is: ';
    InputText:='Input';
    OutputText:='Output';

    DayNum[0]:='Sunday';
    DayNum[1]:='Monday';
    DayNum[2]:='Tuesday';
    DayNum[3]:='Wednesday';
    DayNum[4]:='Thursday';
    DayNum[5]:='Friday';
    DayNum[6]:='Saturday';

    HelpTextInfo:='About the Program';
    HelpTextClear:='Clear screen';
    HelpTextColor:='Change text and background color';
    HelpTextDate:='Print date';
    HelpTextDec:='Length of decimal number in math result';
    HelpTextExit:='Exit';
    HelpTextHelp:='Instruction';
    HelpTextPause:='Pause the program';
    HelpTextPreans:='Print last math answer';
    HelpTextPrint:='Print text';
    HelpTextRun:='Run .vmath File';
    HelpTextTime:='Print time';
    HelpTextcqe2:='Calculate quadratic equation';
    HelpTextCat:='Concatnate 2 Text File';

    Fact1:=' Ration of length and width of type-A paper is 1/sqrt(2)';
    Fact2:='x^m <> y^n (x,y is prime; m,n is natural number) [Euler]';
    Fact3:='| x,y <> 0 ; x=y |-> x^2=xy -> x^2-y^2=x^y-y^2 -> x+y=y -> 2y=y -> 2=1 ?';
    Fact4:='| f(n) = n^2 + n + 41 ; n < 40 | => f(n) is prime [by Euler]';

    cqe0Text:='No Solution';
    cqe1Text:='1 Solution: ';
    cqe2Text:='2 Solutions: ';

    ErrorId1:='Syntax Error or Input Error.';
    ErrorId2:='Division By Zero.';
    ErrorId3:='Invalid File.';
end;

procedure ActiveLang(s:string);
begin
    case lowercase(s) of
        'vi'    :   LangVi;
        'en'    :   LangEn
    else LangEn;
    end;
end;

end.