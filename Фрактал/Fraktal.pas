program dkrfraktal;

uses GraphABC;

var
  x1, y1, ll, tt: integer;

procedure Draw(x, y, l, u: Real; t: Integer);
  procedure Draw2(var x, y: Real; l, u: Real; t: Integer);
  begin
    Draw(x, y, l, u, t);
    x := x + l * cos(u);
    y := y - l * sin(u);
  end;

begin
  if t > 0 then begin
    l := l / 3;
    Draw2(x, y, l, u, t - 1);
    Draw2(x, y, l, u + pi / 3, t - 1);
    Draw2(x, y, l, u - pi / 3, t - 1);
    Draw2(x, y, l, u, t - 1);
  end
  else Line(Round(x), Round(y), Round(x + cos(u) * l), Round(y - sin(u) * l));
end;

procedure Koxa;
var
  x2, y2, x3, y3: real;
begin
  ClearWindow();
  x3 := x1 + cos(pi / 3) * ll;
  y3 := y1 - sin(pi / 3) * ll;
  x2 := x3 + cos(-pi / 3) * ll;
  y2 := y3 - sin(-pi / 3) * ll;
  Draw(X1, Y1, ll, pi / 3, tt);
  Draw(x2, y2, ll, pi, tt);
  Draw(x3, y3, ll, -pi / 3, tt);    
  Redraw;
end;

procedure KeyDown(k: integer);
begin
  case K of
    VK_Down: y1 := y1 - 20; // передвижение вниз 
    VK_Up: y1 := y1 + 20; // передвижение вверх 
    VK_Left: x1 := x1 + 20; // передвижение влево   
    VK_Right: x1 := x1 - 20; // передвижение вправо 
    VK_A: if ll < 10000 then ll := ll + 100; //клавиша A = масштаб +
    VK_Z: if ll > 50 then ll := ll - 100; //клавиша Z = масштаб -
    VK_S: if tt < 7 then tt := tt + 1; //клавиша S = глубина прорисовки + 
    VK_X: if tt > 0 then tt := tt - 1; //клавиша X = глубина прорисовки -
  end; 
  Koxa;
end;

begin
  SetWindowSize(800, 800);
  SetWindowCaption('Фрактал: Снежинка Коха');   
  LockDrawing;
  x1 := 200; y1 := 500; ll := 400; tt := 2;
  Koxa; 
  OnkeyDown += KeyDown;
  
end.