unit uModelPagamentoUnico;

interface
 uses
   System.SysUtils,
   System.classes,
   Math,
   Vcl.Graphics,
    Vcl.StdCtrls,
   Data.DB,
   DBClient;

  type
   pValor = (pCapital,pJuros,pMeses);
   TModelPagamentoUnico = class
  private
    FCapital: currency;
    FTxJutos: currency;
    FMeses: integer;
    FMontanteCalculado :currency;
    FDadosDataset: TClientDataSet;
    procedure SetCapital(const Value: currency);
    procedure SetMeses(const Value: integer);
    procedure SetTxJutos(const Value: currency);

    { Validação de Regra de negoçio }
    function validaValores(value:currency;tValor:pValor):boolean;

  public
    { Validação de Regra de negoçio }
    function ValidarComponentesPU(var objeto: Tcomponent):boolean;

     { Regra de negoçio }
    procedure Calcular;

     constructor create;
     destructor destroy; override;
     property Capital           : currency       read FCapital            write SetCapital;
     property TxJutos           : currency       read FTxJutos            write SetTxJutos;
     property Meses             : integer        read FMeses              write SetMeses;
     property MontanteCalculado : currency       read FMontanteCalculado;
     property DadosDataset      : TClientDataSet read FDadosDataset;
  end;

implementation

{ TPagamentoUnico }

procedure TModelPagamentoUnico.Calcular;
var I:integer;
Saldo_Anterior:currency;
begin
  if not (validaValores(FCapital,pCapital) and
          validaValores(FTxJutos,pJuros)   and
          validaValores(FMeses,pMeses) )   then exit;

  with  FDadosDataset do
  begin
    EmptyDataSet;

    for i := 0 to (Meses) do
    begin
      Append;

      if i=0 then
      begin
        FieldByName('N').AsInteger                      := 0;
        FieldByName('Juros').ascurrency                 := 0;
        FieldByName('Amortizacao_S_Devedor').ascurrency := 0;
        FieldByName('Pagamento').ascurrency             := 0;
        FieldByName('SaldoDevedor').ascurrency          := FCapital;
      end
      else
      begin
        FieldByName('N').AsInteger                      := I;
        FieldByName('Juros').ascurrency                 := (Saldo_Anterior * FTxJutos/100);
        FieldByName('SaldoDevedor').ascurrency          := FCapital*(power(1+(FTxJutos/100),i));
        if i=meses then
        begin
          FieldByName('Amortizacao_S_Devedor').ascurrency := FCapital;
          FieldByName('Pagamento').ascurrency             := Saldo_Anterior+ FieldByName('Juros').ascurrency;
          FieldByName('SaldoDevedor').ascurrency          := FCapital*(power(1+(FTxJutos/100),meses))-FieldByName('Pagamento').ascurrency;
        end;
      end;

      Post;

      Saldo_Anterior := FieldByName('SaldoDevedor').ascurrency ;
    end;

    //*******totais******//
    Append;
    FieldByName('N').asstring                       := 'Totais';
    FieldByName('Juros').ascurrency                 := (FCapital*(power(1+(FTxJutos/100),meses)))-FCapital ;
    FieldByName('Amortizacao_S_Devedor').ascurrency := FCapital;
    FieldByName('Pagamento').ascurrency             := FCapital*(power(1+(FTxJutos/100),meses));
    Post;

  end;

  FMontanteCalculado := FCapital*(power(1+(FTxJutos/100),meses));
end;

constructor TModelPagamentoUnico.create;
begin
  FCapital           := 500000;
  FTxJutos           := 4;
  FMeses             := 5;
  FMontanteCalculado := 0;

  FDadosDataset := TClientDataSet.Create(nil);
  with  FDadosDataset, FDadosDataset.FieldDefs do
  begin
    Add('N',ftString,6);
    Add('Juros',ftCurrency);
    Add('Amortizacao_S_Devedor',ftCurrency);
    Add('Pagamento',ftCurrency);
    Add('SaldoDevedor',ftCurrency);
    CreateDataSet;

    Fields[0].DisplayLabel := 'n';
    Fields[1].DisplayLabel := 'Juros';
    Fields[2].DisplayLabel := 'Amortização S D';
    Fields[3].DisplayLabel := 'Pagamento';
    Fields[4].DisplayLabel := 'Saldo Devedor';
  end;

end;

destructor TModelPagamentoUnico.destroy;
begin
  FDadosDataset.Free;
  inherited;
end;

procedure TModelPagamentoUnico.SetCapital(const Value: currency);
begin
  validaValores(Value,pCapital);
  FCapital := Value;
end;

procedure TModelPagamentoUnico.SetMeses(const Value: integer);
begin
  validaValores(Value,pMeses);
  FMeses := Value;
end;

procedure TModelPagamentoUnico.SetTxJutos(const Value: currency);
begin
  validaValores(Value,pJuros);
  FTxJutos := Value;
end;


function TModelPagamentoUnico.ValidarComponentesPU(var objeto: Tcomponent): boolean;
begin
 { objeto Tedit }
  Result := true;
  if Tcomponent(objeto) is TEdit then
  begin
    Result :=  TEdit(objeto).Text <> EmptyStr;

    if Result then
    begin
      TEdit(objeto).Color  :=clWindow;
    end
    else
    begin
      if TEdit(objeto).CanFocus
         then TEdit(objeto).SetFocus;
      TEdit(objeto).Color  :=clSkyBlue;
    end;
  end;
  { Pode-se colocar outros objetos }
  if not Result then raise Exception.Create('Valor não pode estar vazio!');
end;

function TModelPagamentoUnico.validaValores(value: currency;
  tValor: pValor): boolean;
var Namevalor,msg:string;
begin
  try
     case tValor of
       pCapital: Namevalor:= 'Capital';
       pJuros  : Namevalor:= 'Taxa de Juros';
       pMeses  : Namevalor:= 'Meses';
     end;
     if value <=0 then
     begin
        msg := Format('O campo %s não pode ficar zerado',[Namevalor]);
        raise Exception.Create(msg);
     end;
  finally
    result:=  msg = emptystr;
  end;
end;

end.
