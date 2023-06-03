program WebUIExample;

{$mode objfpc}{$H+}

uses
  webui;

// Функция-обработчик события
procedure EventHandler(e: Pwebui_event_t);
begin
  // Выводим информацию о событии на консоль
  WriteLn('Window: ', e^.window);
  WriteLn('Event Type: ', e^.event_type);
  WriteLn('Element: ', e^.element);
  WriteLn('Data: ', e^.data);
  WriteLn('Event Number: ', e^.event_number);
end;

var
  window: size_t;
  content: PChar;
  bindId: size_t;

begin
  // Создаем новое окно
  window := webui_new_window;

  // Привязываем функцию-обработчик к событию клика на элементе с id "button"
  bindId := webui_bind(window, 'button', @EventHandler);
  
  WriteLn('BindId: ', bindId);
  // Показываем окно с встроенным HTML-контентом
  content := '<html><body><button id="button">Click me!</button></body></html>';
  webui_show(window, content);

  // Ждем, пока все открытые окна будут закрыты
  webui_wait;
end.
