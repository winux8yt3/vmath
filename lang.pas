unit lang;

interface

uses programStr;

var 
    ProgramInfo,WelcomeMsg,DoneMsg,TkMsg:String;
    LoadText,DateText,TimeText,InputText,OutputText,InfoText,ExitText:String;
    HelpTextClear,HelpTextColor,HelpTextDate,HelpTextDec,HelpTextExit:String;
    HelpTextHelp,HelpTextInfo,HelpTextPause,HelpTextPreans,HelpTextPrint:String;
    HelpTextRun,HelpTextTime,HelpTextEqn2,HelpTextGcd,HelpTextLcm:String;
    HelpTextFact,HelpTextFunFact:String;
    Fact1,Fact2,Fact3,Fact4,Fact5,Fact6:String;
    eqn0Text,eqn1Text,eqn2Text:String;
    GNotEnabledMsg,GEnabledMsg,GDisabledMsg,GLoadMsg,GCloseMsg:string;
    ErrorId0,ErrorId1,ErrorId2,ErrorId3,ErrorId4,ErrorId5,ErrorId6:String;
    ErrorId7:String;

procedure ActiveLang(s:String);

implementation

procedure LangVi;
begin
    write(#208'ang T'#229'i G'#243'i Ng'#244'n Ng'#252'. . .');
    writeln;

    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Ban Dung So '+VersionBuild+'.';
    DoneMsg:='Xong!';
    WelcomeMsg:='Chao mung ban den voi '+ProgramInfo;
    TkMsg:='Cam on ban da tham gia chuong trinh thu nghiem VMath BETA';

    LoadText:='Dang Tai...';
    InfoText:='Lap Trinh Boi Winux8yt3. Website Du An: bit.ly/vmath-xplorer';
    DateText:='Hom nay la: ';
    TimeText:='Bay gio la: ';
    InputText:='Nhap';
    OutputText:='Xuat';
    ExitText:='Thoat chuong trinh ?';

    HelpTextInfo:='Thông tin ph'#7847'n m'#7873'm';
    HelpTextClear:='Xoá màn hình';
    HelpTextDate:='In ra ng'#224'y';
    HelpTextDec:='Do dai phan thap phan trong ket qua toan hoc';
    HelpTextExit:='Thoát';
    HelpTextHelp:='Huong dan su dung';
    HelpTextPause:='Tam dung chuong trinh';
    HelpTextPreans:='In ra ket qua luc truoc';
    HelpTextPrint:='In dong chu';
    HelpTextRun:='Chay File .vmath';
    HelpTextTime:='In ra thoi gian';
    HelpTexteqn2:='Tinh phuong trinh bac 2';
    HelpTextGcd:='Uoc chung lon nhat';
    HelpTextLcm:='Boi chung nho nhat';
    HelpTextFact:='Phan tich thanh cac thua so nguyen to';
    HelpTextFunFact:='Thong tin thuc te vui';

    Fact1:='Ti le chieu dai va chieu rong cua to giay loai A la 1/sqrt(2)';
    Fact2:='x^m <> y^n (x,y la so nguyen to; m,n la so tu nhien) [Euler]';
    Fact3:='a/9 = 0.(a) | ab/99 = 0.(ab)';
    Fact4:='| f(n) = n^2 + n + 41 | n < 40 | => f(n) la so nguyen to [Euler]';
    Fact5:='So 2 la so nguyen to chan duy nhat';
    Fact6:='So nguyen to lon nhat tinh toi ngay 7/1/2016 la 2^74,207,281-1';

    eqn0Text:='Khong co nghiem';
    eqn1Text:='1 nghiem: ';
    eqn2Text:='2 nghiem: ';

    GNotEnabledMsg:='Graphic Not Yet Activated';
    GEnabledMsg:='Graphic Already Activated.';
    GDisabledMsg:='Graphic Already Closed.';
    GLoadMsg:='Loading Graphic . . .';
    GCloseMsg:='Closing Graphic . . .';

    ErrorId1:='Sai cau truc hoac sai cau lenh. Go `help` de co danh sach cac cau lenh.';
    ErrorId2:='Phep chia cho 0.';
    ErrorId3:='Tep khong ton tai.';
    ErrorId4:='Cho Nhap So';
    ErrorId5:='Bien chua xac dinh';
    ErrorId6:='Loi do hoa';
    ErrorId7:='Khong co X';
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
    ExitText:='Exit program ?';

    HelpTextInfo:='About the Program';
    HelpTextClear:='Clear screen';
    HelpTextColor:='Change text and background color';
    HelpTextDate:='Print date';
    HelpTextDec:='Number of decimal place in math result';
    HelpTextExit:='Exit';
    HelpTextHelp:='Instruction';
    HelpTextPause:='Pause the program';
    HelpTextPreans:='Print last math answer';
    HelpTextPrint:='Print text';
    HelpTextRun:='Run .vmath File';
    HelpTextTime:='Print time';
    HelpTexteqn2:='Calculate quadratic equation';
    HelpTextGcd:='Greatest common divisor';
    HelpTextLcm:='Least common multiple';
    HelpTextFact:='Factorization to Prime';
    HelpTextFunFact:='Fun fact';

    Fact1:='Ratio of length and width of type-A paper is 1/sqrt(2)';
    Fact2:='x^m <> y^n (x,y is prime; m,n is natural number) [Euler]';
    Fact3:='a/9 = 0.(a) | ab/99 = 0.(ab)';
    Fact4:='| f(n) = n^2 + n + 41 ; n < 40 | => f(n) is prime [Euler]';
    Fact5:='The only even prime number is 2.';
    Fact6:='Largest prime number until 7/1/2016 is 2^74,207,281-1';

    eqn0Text:='No Solution';
    eqn1Text:='1 Solution: ';
    eqn2Text:='2 Solutions: ';

    GNotEnabledMsg:='Do hoa chua duoc kich hoat';
    GEnabledMsg:='Do hoa da duoc kich hoat.';
    GDisabledMsg:='Do hoa da bi tat.';
    GLoadMsg:='Dang nap che do do hoa . . .';
    GCloseMsg:='Dang tat che do do hoa . . .';

    ErrorId1:='Syntax Error or Input Error. Enter `help` for commands list';
    ErrorId2:='Division By Zero.';
    ErrorId3:='Invalid File.';
    ErrorId4:='Expecting Number.';
    ErrorId5:='String not exist';
    ErrorId6:='Graphic Error';
    ErrorId7:='Expecting X';
end;

procedure ActiveLang(s:String);
begin
    case upcase(s) of
        'VI','1'    :   LangVi;
        'EN','0'    :   LangEn
    else LangEn;
    end;
end;

end.