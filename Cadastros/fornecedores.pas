unit fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, FireDAC.Stan.Param, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Mask, Vcl.Grids,
  Vcl.DBGrids, System.UITypes, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFrmFornecedores = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    rbNome: TRadioButton;
    EdtBuscarNome: TEdit;
    edtNome: TEdit;
    edtEndereco: TEdit;
    grid: TDBGrid;
    edtCodigo: TEdit;
    edtTel: TMaskEdit;
    edtMail: TEdit;
    Label3: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
  private
    { Private declarations }
    procedure assosciarCampos;
    procedure buscarTudo;
    procedure buscarNome;
    procedure limpaCampos;
    procedure habilitaCampos;
    procedure desabilitaCampos;


  public
    { Public declarations }

  end;

var
  FrmFornecedores: TFrmFornecedores;

implementation

{$R *.dfm}

uses modulo;

{ TFrmFornecedores }

procedure TFrmFornecedores.assosciarCampos;
begin
  with DataModule1.QueryForn do
  Begin

  Close;
  SQL.Clear;
  SQL.Add('update fornecedores set id = :id, nome = :nome, telefone = :telefone, endereco = :endereco, email = :email where id = :id');
    ParamByName('id').value := edtCodigo.Text;
    ParamByName('nome').value := edtNome.Text;
    ParamByName('telefone').value := edtTel.Text;
    ParamByName('endereco').value := edtEndereco.Text;
    ParamByName('email').Value := edtMail.Text;
    ExecSQL;

  End;
end;

procedure TFrmFornecedores.btnEditarClick(Sender: TObject);
begin
 if (Trim(edtNome.Text)) <> '' then
  Begin
   assosciarCampos;
   DataModule1.tb_fornecedores.Post;
   grid.Enabled := true;
   buscarTudo;
   MessageDlg('Registro Editado com sucesso!!', mtWarning, [mbOK], 0);
   desabilitaCampos;
   btnNovo.Enabled := true;
   btnSalvar.Enabled := false;
   btnEditar.Enabled := false;
   btnExcluir.Enabled := false;

  End
  Else
  Begin
  MessageDlg('Campo NOME não pode ser Vazio!!', mtWarning, [mbOK], 0);
  edtNome.SetFocus;

  End;
end;

procedure TFrmFornecedores.btnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
     if edtCodigo.Text <> '' then
     Begin
      DataModule1.QueryFunc.Close;
      DataModule1.QueryFunc.SQL.Clear;
      DataModule1.QueryFunc.SQL.Add('delete from fornecedores where id=' + edtCodigo.Text);
      DataModule1.QueryFunc.ExecSQL;
      MessageDlg('Excluido com Sucesso!!', mtWarning, [mbOK], 0);
      btnSalvar.Enabled := false;
      btnExcluir.Enabled := false;
      btnEditar.Enabled := false;
      btnNovo.Enabled := true;

      buscarTudo;
     End
     else
     Begin
      MessageDlg('Selecione um registro para exclusão!!', mtWarning, [mbOK], 0);


     End;
 end;
end;

procedure TFrmFornecedores.btnNovoClick(Sender: TObject);
begin
  habilitaCampos;
  limpaCampos;
  btnSalvar.Enabled := true;
  edtNome.SetFocus;

  DataModule1.tb_fornecedores.Insert;

  btnNovo.Enabled := false;
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  grid.Enabled := false;
end;

procedure TFrmFornecedores.btnSalvarClick(Sender: TObject);
begin
  if (Trim(edtNome.Text)) <> '' then
  Begin
   assosciarCampos;
   DataModule1.tb_fornecedores.Post;
   grid.Enabled := true;
   buscarTudo;
   MessageDlg('Registro Salvo com sucesso!!', mtWarning, [mbOK], 0);
   desabilitaCampos;
   btnNovo.Enabled := true;
   btnSalvar.Enabled := false;
   btnEditar.Enabled := false;
   btnExcluir.Enabled := false;

  End
  Else
  Begin
  MessageDlg('Campo NOME não pode ser Vazio!!', mtWarning, [mbOK], 0);
  edtNome.SetFocus;

  End;
end;

procedure TFrmFornecedores.buscarNome;
begin
  DataModule1.QueryForn.Close;
  DataModule1.QueryForn.SQL.Clear;
  DataModule1.QueryForn.SQL.Add('select * from fornecedores where nome like :nome order by id desc');
  DataModule1.QueryForn.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  DataModule1.QueryForn.Open;
end;

procedure TFrmFornecedores.buscarTudo;
begin

  DataModule1.QueryForn.Close;
  DataModule1.QueryForn.SQL.Clear;
  DataModule1.QueryForn.SQL.Add('select * from fornecedores order by id desc');
  DataModule1.QueryForn.Open;

end;

procedure TFrmFornecedores.desabilitaCampos;
begin
 edtNome.Enabled := false;
 edtEndereco.Enabled := false;
 edtTel.Enabled := false;
 edtMail.Enabled := false;
end;

procedure TFrmFornecedores.EdtBuscarNomeChange(Sender: TObject);
begin
if Trim(EdtBuscarNome.Text) <> '' then
  BEGIN
   buscarNome;
  END
  ELSE
  BEGIN
    buscarTudo;
  END;
end;

procedure TFrmFornecedores.FormShow(Sender: TObject);
begin
buscarTudo;
end;

procedure TFrmFornecedores.gridCellClick(Column: TColumn);
begin
DataModule1.tb_fornecedores.Edit;

edtCodigo.Text := DataModule1.QueryForn.FieldByName('id').Value;
edtNome.Text   := DataModule1.QueryForn.FieldByName('nome').Value;
edtTel.Text    := DataModule1.QueryForn.FieldByName('telefone').Value;
edtEndereco.Text := DataModule1.QueryForn.FieldByName('endereco').Value;
edtMail.Text    := DataModule1.QueryForn.FieldByName('email').Value;

habilitaCampos;
btnNovo.Enabled := true;
btnEditar.Enabled := true;
btnExcluir.Enabled := true;
edtNome.SetFocus;


end;

procedure TFrmFornecedores.habilitaCampos;
begin
 edtNome.Enabled := true;
 edtEndereco.Enabled := true;
 edtTel.Enabled := true;
 edtMail.Enabled := true;
end;

procedure TFrmFornecedores.limpaCampos;
begin
 edtNome.Text := '';
 edtEndereco.Text := '';
 edtTel.Text := '';
 edtMail.Text := '';
end;

end.
