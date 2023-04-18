unit modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MSAccDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSAcc, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    conn: TFDConnection;
    Driver: TFDPhysMSAccessDriverLink;
    WaitCursor1: TFDGUIxWaitCursor;
    ds_cargo: TDataSource;
    tb_cargo: TFDTable;
    tb_cargoid: TFDAutoIncField;
    tb_cargonome: TStringField;
    ds_funcionarios: TDataSource;
    tb_funcionarios: TFDTable;
    tb_funcionariosid: TFDAutoIncField;
    tb_funcionariosnome: TStringField;
    tb_funcionarioscpf: TStringField;
    tb_funcionariostelefone: TStringField;
    tb_funcionariosendereco: TStringField;
    tb_funcionarioscargo: TStringField;
    tb_funcionariosusuario: TStringField;
    tb_funcionariossenha: TStringField;
    tb_funcionariosdata: TDateField;
    QueryFunc: TFDQuery;
    QueryCargo: TFDQuery;
    QueryConFunc: TFDQuery;
    dsConFunc: TDataSource;
    QueryConFuncid: TFDAutoIncField;
    QueryConFuncnome: TStringField;
    QueryConFunccpf: TStringField;
    QueryConFunctelefone: TStringField;
    QueryConFuncendereco: TStringField;
    QueryConFunccargo: TStringField;
    QueryConFuncusuario: TStringField;
    QueryConFuncsenha: TStringField;
    QueryConFuncdata: TDateField;
    tb_fornecedores: TFDTable;
    ds_fornecedores: TDataSource;
    tb_fornecedoresid: TFDAutoIncField;
    tb_fornecedoresnome: TStringField;
    tb_fornecedorestelefone: TStringField;
    tb_fornecedoresemail: TStringField;
    tb_fornecedoresendereco: TStringField;
    QueryForn: TFDQuery;
    dsConForne: TDataSource;
    QueryFornid: TFDAutoIncField;
    QueryFornnome: TStringField;
    QueryForntelefone: TStringField;
    QueryFornemail: TStringField;
    QueryFornendereco: TStringField;
    tb_produtos: TFDTable;
    tb_produtosid: TFDAutoIncField;
    tb_produtosnome: TStringField;
    tb_produtosdescricao: TStringField;
    tb_produtosvalor: TBCDField;
    tb_produtosquantidade: TIntegerField;
    tb_produtosfornecedor: TIntegerField;
    tb_produtosimagem: TBlobField;
    queryProd: TFDQuery;
    queryProdid: TFDAutoIncField;
    queryProdnome: TStringField;
    queryProddescricao: TStringField;
    queryProdvalor: TBCDField;
    queryProdquantidade: TIntegerField;
    queryProdfornecedor: TIntegerField;
    queryProdimagem: TBlobField;
    conprod: TDataSource;
    queryProdnome_1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;
  nomeUsuario, nomeFuncionario, cargofunc : String;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses produtos;

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
 //CONECTANDO AO BANCO

 conn.Params.Database := 'sysrestaurante';
 conn.Params.UserName := 'root';
 conn.Params.Password := '';
 Driver.VendorLib := GetCurrentDir + '\lib\libmySQL.dll';
 conn.Connected := true;

 // INFORMAÇÕES DAS TABELAS
  //tb_cargo.TableName := 'cargo';
  //tb_cargo.Active := true;






end;

end.
