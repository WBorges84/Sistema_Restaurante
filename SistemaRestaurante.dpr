program SistemaRestaurante;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UFuncoes in 'UFuncoes.pas' {FrmFuncoes},
  Funcionarios in 'Cadastros\Funcionarios.pas' {Frmfuncionarios},
  produtos in 'Produtos\produtos.pas' {FrmProdutos},
  cargo in 'Cadastros\cargo.pas' {FrmCargo},
  modulo in 'modulo.pas' {DataModule1: TDataModule},
  fornecedores in 'Cadastros\fornecedores.pas' {FrmFornecedores};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmFornecedores, FrmFornecedores);
  Application.Run;
end.
