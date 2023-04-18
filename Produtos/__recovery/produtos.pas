unit produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ExtDlgs, System.UITypes;

type
  TFrmProdutos = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    EdtBuscarNome: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtValor: TEdit;
    Label5: TLabel;
    edtQuantidade: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    cbFornecedor: TComboBox;
    img: TImage;
    btnAddImg: TButton;
    Dialog: TOpenPictureDialog;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnAddImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtDescricaoEnter(Sender: TObject);

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
  FrmProdutos: TFrmProdutos;

implementation

{$R *.dfm}

uses UFuncoes, modulo;


procedure carregarImgPadrao();
var  caminhoImg : String;
Begin
  caminhoImg := ExtractFileDir(GetCurrentDir) + '\Debug\semfoto.bmp';
  FrmProdutos.img.Picture.LoadFromFile(caminhoImg);
End;


procedure TFrmProdutos.assosciarCampos;
begin
  with DataModule1.queryProd do
  begin
  Close;
  sql.Clear;
  sql.Add('update produtos set id = :id, nome = :nome, valor = :valor, quantidade = :quantidade, fornecedor = :fornecedor where id = :id');
    //ParamByName('id').value := edtCodigo.Text;
    ParamByName('nome').value := edtNome.Text;
    ParamByName('valor').Value := edtValor.Text;
    ParamByName('quantidade').Value := edtQuantidade.Text;
    ParamByName('fornecedor').Value := cbFornecedor.ItemIndex;
    Post;


  end;


end;

procedure TFrmProdutos.btnAddImgClick(Sender: TObject);
begin
Dialog.Execute();
img.Picture.LoadFromFile(Dialog.FileName);
end;

procedure TFrmProdutos.btnEditarClick(Sender: TObject);
begin
  if (Trim(edtNome.Text) <> '') and (Trim(edtDescricao.Text) <> '') then
  Begin


    carregarImgPadrao();
    limparcamposProd;
    desabilitarcamposProd;
    btnNovo.Enabled := true;
    btnEditar.Enabled:= false;
    btnSalvar.Enabled := true;
    btnExcluir.Enabled := false;
    btnAddImg.Enabled := false;
  End
  else
  Begin
    MessageDlg('Preencha os campos!!', mtInformation, [mbOK], 0);
  End;
end;

procedure TFrmProdutos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
       if edtCodigo.Text <> '' then
    Begin
    carregarImgPadrao();
    limparcamposProd;
    desabilitarcamposProd;
    btnNovo.Enabled := true;
    btnEditar.Enabled:= false;
    btnSalvar.Enabled := false;
    btnExcluir.Enabled := false;

    MessageDlg('Excluido com Sucesso!!', mtInformation, [mbOK], 0);


    End;

  end;

end;

procedure TFrmProdutos.btnNovoClick(Sender: TObject);
begin
 DataModule1.tb_produtos.Insert;
 carregarImgPadrao;
 limparcamposProd;
 habilitarcamposProd;
 btnNovo.Enabled := false;
 btnEditar.Enabled:= false;
 btnSalvar.Enabled := true;
 btnExcluir.Enabled := false;
 btnAddImg.Enabled := true;
 edtNome.SetFocus;


end;

procedure TFrmProdutos.btnSalvarClick(Sender: TObject);
begin
    with DataModule1.tb_produtos do
  begin
    FieldByName('nome').Value := edtNome.Text;
    FieldByName('descricao').Value := edtDescricao.Text;
    FieldByName('valor').Value := edtValor.Text;
    FieldByName('quantidade').Value := edtQuantidade.Text;
    FieldByName('fornecedor').Value := Integer(cbFornecedor.Items.Objects[cbFornecedor.ItemIndex]);

    Post;
  end;
    buscarTudo;
    carregarImgPadrao();
    limparcamposProd;
    desabilitarcamposProd;
    btnNovo.Enabled := true;
    btnEditar.Enabled:= false;
    btnSalvar.Enabled := false;
    btnExcluir.Enabled := false;
    MessageDlg('Cadastrado com Sucesso!!', mtInformation, [mbOK], 0);

End;


procedure TFrmProdutos.buscarNome;
begin
  DataModule1.queryProd.Close;
  DataModule1.queryProd.SQL.Clear;
  DataModule1.queryProd.SQL.Add('select * from produtos where nome like :nome order by id desc');
  DataModule1.queryProd.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  DataModule1.queryProd.Open;
end;

procedure TFrmProdutos.buscarTudo;
begin
  DataModule1.QueryProd.Close;
  DataModule1.QueryProd.SQL.Clear;
  DataModule1.QueryProd.SQL.Add('select p.id, p.nome, p.descricao, p.valor, p.quantidade, p.fornecedor, f.nome, p.imagem from produtos as p INNER JOIN fornecedores as f ON p.fornecedor = f.id order by id desc');
  DataModule1.QueryProd.Open;
end;

procedure TFrmProdutos.desabilitaCampos;
begin
edtNome.Enabled := false;
edtCodigo.Enabled := false;
edtDescricao.Enabled := false;
edtValor.Enabled := false;
edtQuantidade.Enabled := false;
cbFornecedor.Enabled := false;
end;

procedure TFrmProdutos.EdtBuscarNomeChange(Sender: TObject);
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

procedure TFrmProdutos.edtDescricaoEnter(Sender: TObject);
begin
edtDescricao.Text := edtNome.Text;
end;

procedure TFrmProdutos.edtNomeChange(Sender: TObject);
begin
//edtDescricao.Text := edtNome.Text;
end;

procedure TFrmProdutos.FormCreate(Sender: TObject);
begin
  carregarImgPadrao;

end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
DataModule1.tb_produtos.Active := false;
DataModule1.tb_produtos.Active := true;
DataModule1.tb_fornecedores.Active := false;
DataModule1.tb_fornecedores.Active := true;
carregarImgPadrao();
carregarComboboxProd;
buscarTudo;
end;

procedure TFrmProdutos.gridCellClick(Column: TColumn);
begin

  DataModule1.tb_produtos.Edit;
  With DataModule1.queryProd do
  Begin


    edtNome.Text := FieldByName('nome').Value;
    edtCodigo.Text := FieldByName('id').Value;
    edtDescricao.Text := FieldByName('descricao').Value;
    edtValor.Text := FieldByName('valor').Value;
    edtQuantidade.Text := FieldByName('quantidade').Value;
    cbFornecedor.Text := FieldByName('nome_1').Value;
    habilitarcamposProd;
    btnEditar.Enabled := true;
    btnExcluir.Enabled := true;
    btnNovo.Enabled := true;

  End;
 habilitarcamposProd;
 btnNovo.Enabled := true;
 btnEditar.Enabled:= true;
 btnSalvar.Enabled := false;
 btnExcluir.Enabled := true;
end;

procedure TFrmProdutos.habilitaCampos;
begin
edtNome.Enabled := true;
edtCodigo.Enabled := true;
edtDescricao.Enabled := true;
edtValor.Enabled := true;
edtQuantidade.Enabled := true;
cbFornecedor.Enabled := true;
end;

procedure TFrmProdutos.limpaCampos;
begin
edtNome.Text := '';
edtCodigo.Text := '';
edtDescricao.Text := '';
edtValor.Text := '';
cbFornecedor.Text := '';

end;

end.
