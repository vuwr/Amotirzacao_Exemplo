unit uControllerSimulador;

interface
   uses
   System.classes,
   Vcl.StdCtrls,
   System.SysUtils,
   Vcl.Graphics,
   uModelPagamentoUnico,
   uModelPagamentosVariaveis,
   uModellog;

 type
  pRS = (nao,sim);
  TControllerSimulador = class
  private
    FModelPagamentoUnico: TModelPagamentoUnico;
    FModelLog: TModelLog;
    FModelPagamentosVariaveis: TModelPagamentosVariaveis;
    procedure SetModelLog(const Value: TModelLog);
  public
     constructor create;
     destructor Destroy;override;

     { Algumas Funções de Formatação}
     function formataStrToCur(value:string):currency;
     function formataCurToStr(value:currency;v:pRS=sim):string;
     function formataStrtoint(value:string):Integer;

     property ModelPagamentoUnico :TModelPagamentoUnico read FModelPagamentoUnico;
     property ModelPagamentosVariaveis : TModelPagamentosVariaveis read FModelPagamentosVariaveis;
  end;

implementation


{ TControllerSimulador }

constructor TControllerSimulador.create;
begin
  FModelPagamentoUnico := TModelPagamentoUnico.create;
  FModelPagamentosVariaveis := TModelPagamentosVariaveis.Create;
end;

destructor TControllerSimulador.Destroy;
begin
  FModelPagamentoUnico.destroy;
  FModelPagamentosVariaveis.Destroy;
  inherited;
end;


function TControllerSimulador.formataCurToStr(value: currency;v:pRS=sim): string;
begin
  case v of
    nao: Result := FormatCurr('#,0.00',value);
    sim: Result := FormatCurr('R$ #,0.00',value) ;
  end;
end;

function TControllerSimulador.formataStrToCur(value: string): currency;
begin
  if value = EmptyStr then
  begin
    Result := 0;
  end
  else
  begin
    value:= stringreplace(value,'.',EmptyStr,[rfReplaceAll]);
    value:= stringreplace(value,'R$',EmptyStr,[rfReplaceAll]);
    value := Trim(value);
    Result := StrToCurr(value);
  end;
end;

function TControllerSimulador.formataStrtoint(value: string): Integer;
begin
  if value = EmptyStr then
  begin
    Result := 0;
  end
  else
  begin
    value:= stringreplace(value,'.',EmptyStr,[rfReplaceAll]);
    value:= stringreplace(value,'R$',EmptyStr,[rfReplaceAll]);
    value := Trim(value);
    Result := Strtoint(value);
  end;
end;


procedure TControllerSimulador.SetModelLog(const Value: TModelLog);
begin
  FModelLog := Value;
end;

end.
