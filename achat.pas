unit achat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  type
    Supermercado = record
      rif: string;
      nombre: string
    end;

    Cliente = record
      rif: string;
      nombres: string;
      direccion: string
    end;

    Producto = record
      codigo: string;
      descripcion: string;
      cantidad: integer;
      costo: real
    end;

    TipoDePago = (Efectivo, Debito, Credito);

    Factura = record
      supermercado: Supermercado;
      fechaCompra: string; // OJO
      horaCompra: string;  // OJO
      cliente: Cliente;
      nroFactura: integer;
      nombreCajero: string;
      nroProductos: string;
      productos: array[1..10] of Producto;
      subTotal: real;
      iva: real;
      total: real;
      tipoPago: TipoDePago
    end;

  var
    facturas: array[1..100] of Factura;
    productos: array[1..10] of Producto;

function estaElCarritoVacio(): boolean;

function estaElCarritoLleno(): boolean;

procedure agregarProducto(item: Producto);

function hayDemasiadasFacturas(): boolean;

procedure agregarFactura(item: Factura);

implementation

  //
  // Inicializar lista de productos
  //
  procedure inicializarProductos();
  var
    i: integer;
    item: Producto;
  begin

    item.codigo := '';
    item.descripcion := '';
    item.cantidad := 0;
    item.costo := 0;

    for i:=1 to 10 do
    begin
      productos[i] := item;
    end;
  end;

  //
  // Inicializar listado de facturas y productos
  //
  procedure inicializarDatos();
  begin
    inicializarProductos();
  end;

  //
  // Verificar si no se han registrado items
  //
  function estaElCarritoVacio(): boolean;
  begin
    // Verificar si el primer item fue registrado
    if (productos[1].codigo = '') then
      result := true
    else
      result := false;
  end;

  //
  // Verificar si se registraron los 10 items
  //
  function estaElCarritoLleno(): boolean;
  begin
    // Verificar si el ultimo item fue registrado
    if (productos[10].codigo <> '') then
      result := true
    else
      result := false;
  end;

  //
  // Agregar nuevo producto a la lista
  //
  procedure agregarProducto(item: Producto);
  var
    i, indiceEspacioVacio: integer;
  begin
    // Verificar si la factura esta llena
    if (not estaElCarritoLleno()) then
      // Buscar indice del siguiente espacio disponible
      for i:=1 to 10 do
      begin
        // Encontro un espacio vacio
        if (productos[i].codigo = '') then
        begin
          indiceEspacioVacio := i;
          break;
        end;
      end;
      // Guardar producto
      productos[indiceEspacioVacio] := item;
  end;

  //
  // Verificar si se registraron todas las facturas
  //
  function hayDemasiadasFacturas(): boolean;
  begin
    // Verificar si la ultima factura fue registrada
    if (facturas[100].nombreCajero <> '') then
      result := true
    else
      result := false;
  end;

  //
  // Agregar nueva factura a la lista
  //
  procedure agregarFactura(item: Factura);
  var
    i, indiceEspacioVacio: integer;
  begin
    // Verificar si la factura esta llena
    if (not hayDemasiadasFacturas()) then
      // Buscar indice del siguiente espacio disponible
      for i:=1 to 100 do
      begin
        // Encontro un espacio vacio
        if (facturas[i].nombreCajero = '') then
        begin
          indiceEspacioVacio := i;
          break;
        end;
      end;
      // Guardar factura
      facturas[indiceEspacioVacio] := item;

      // Limpiar lista de productos
      inicializarProductos();
  end;

begin
  inicializarDatos();
end.

