program qxexample;

{$mode objfpc}{$H+}

uses
  webui, strings, sysutils;

var
  window: size_t;
  content: PChar;

function ReadFileContent(const FileName: string): PChar;
var
  FileHandle: TextFile;
  FileTemp, FileContent: String;
begin
  AssignFile(FileHandle, FileName);
  Reset(FileHandle);

  FileContent := '';
  while not Eof(FileHandle) do
  begin
    Readln(FileHandle, FileTemp);
    FileContent := FileContent + FileTemp;
  end;

  CloseFile(FileHandle);
  Result := StrAlloc(Length(FileContent));
  StrPCopy(Result, String(UTF8Decode(FileContent)));
end;

procedure EventHandler(e: Pwebui_event_t);
begin
    writeln('Received callback: ', e^.data);
    webui_interface_set_response(e^.window, e^.event_number, 'Message from Free Pascal');
end;

begin
  // Создаем новое окно
  window := webui_new_window;

  // Привязываем функцию-обработчик к событию нажатия кнопки
  webui_bind(window, 'Button1Click', @EventHandler);
  
  // Загружаем HTML-контент из файла на диске
  content := ReadFileContent('index.html');

  // Показываем окно с HTML-контентом
  webui_show(window, content);

  // Ждем, пока все открытые окна будут закрыты
  webui_wait;
end.