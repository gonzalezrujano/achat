unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, achat;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormClick(Sender: TObject);
begin
  //
end;

//
// Agregar producto a la lista
//
procedure mostrarEnLista(item: Producto);
var
  i: integer;
  datosAMostrar: string;
begin
  WriteLn('Largo de nombre: ', length(item.descripcion));
  // Agregar nombre del producto
  appendstr(datosAMostrar, item.descripcion);

  // Agregar espacios en blanco hasta el siguiente valor (Alineado)
  for i:=1 to (30 - length(item.descripcion)) do
  begin
    appendstr(datosAMostrar, ' ');
  end;

  // Agregar la cantidad comprada
  appendstr(datosAMostrar, 'x');
  appendstr(datosAMostrar, IntToStr(item.cantidad));

  // Mostrar en la lista
  Form1.ListBox1.Items.Add(datosAMostrar);
end;

//
// Limpiar campos del formulario #2
//
procedure limpiarFormulario();
begin
  Form2.LabeledEdit1.Text := '';
  Form2.LabeledEdit2.Text := '';
  Form2.LabeledEdit3.Text := '';
  Form2.LabeledEdit4.Text := '';
end;

//
// Evento para agregar producto
//
procedure TForm2.Button1Click(Sender: TObject);
var
  item: Producto;
begin

  {if (not datosDelProductoSonValidos()) then
    // Dialogo de alerta
    exit;}

  // Limpiar lista si es el primer item
  if (estaElCarritoVacio()) then
    Form1.ListBox1.Items.Clear;

  // Formatear datos del producto
  item.codigo := LabeledEdit4.Text;
  item.descripcion := LabeledEdit1.Text;
  item.costo := StrToFloat(LabeledEdit2.Text);
  item.cantidad := StrToInt(LabeledEdit3.Text);

  // Guardar producto
  agregarProducto(item);

  // Mostrar en la interfaz
  mostrarEnLista(item);

  // Vaciar campos del formulario
  limpiarFormulario();

  // Cerrar interfaz
  Form2.Close;
end;

end.

