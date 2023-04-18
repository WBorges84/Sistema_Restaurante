unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask, System.UITypes,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmfuncionarios = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    rbNome: TRadioButton;
    rbCPF: TRadioButton;
    EdtBuscarNome: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtEndereco: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    cbCargo: TComboBox;
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtBuscarCpf: TMaskEdit;
    edtCodigo: TEdit;
    edtUsuario: TEdit;
    Label7: TLabel;
    edtsenha: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtConfSenha: TEdit;
    edtCPF: TMaskEdit;
    edtTel: TMaskEdit;
    valcpf: TEdit;
    procedure rbCPFClick(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure associaCampos();
    procedure buscarTudo();
    procedure edtCPFExit(Sender: TObject);
    procedure valcpfExit(Sender: TObject);
    procedure buscarNome();
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure buscarCPF();
    procedure edtBuscarCpfChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure gridInsert(x : Integer);
  end;

var
  Frmfuncionarios: TFrmfuncionarios;
  x : Integer;
  cpfant, usuant : String;

implementation

{$R *.dfm}

uses UFuncoes, modulo;



procedure TFrmfuncionarios.associaCampos;
begin
  with DataModule1.QueryFunc do
  Begin

  Close;
  SQL.Clear;
  SQL.Add('update funcionarios set nome = :nome, cpf = :cpf, telefone = :telefone, endereco = :endereco, cargo = :cargo, usuario = :usuario, senha = :senha, data = :data where id = :id');
    ParamByName('id').value := edtCodigo.Text;
    ParamByName('nome').value := edtNome.Text;
    ParamByName('cpf').value := edtCPF.Text;
    ParamByName('telefone').value := edtTel.Text;
    ParamByName('endereco').value := edtEndereco.Text;
    ParamByName('cargo').value := cbCargo.Text;
    ParamByName('usuario').value := edtUsuario.Text;
    ParamByName('senha').value := edtSenha.Text;
    ParamByName('data').Value := DateToStr(Date());
    ExecSQL;

  End;

end;

procedure TFrmfuncionarios.btnEditarClick(Sender: TObject);
begin
 if (edtNome.Text <> '') and (edtCPF.Text <> '   .   .   -  ') and (edtUsuario.Text <> '') then
  Begin
  //validar cpf
     DataModule1.QueryFunc.Close;
     DataModule1.QueryFunc.SQL.Clear;
     DataModule1.QueryFunc.SQL.Add('select cpf from funcionarios where cpf = ' +QuotedStr(Trim(edtCPF.Text)) );
     //DataModule1.QueryConFunc.SQL.Add('select cpf from funcionarios where cpf = 30 ');
     DataModule1.QueryFunc.Open;

     if not DataModule1.QueryFunc.IsEmpty then
      Begin
        if cpfant <> edtCPF.Text then
        begin
        MessageDlg('o CPF: ' + edtCPF.Text + ' já existe!!' , mtWarning, [mbOK], 0);
        edtCPF.SetFocus;
        exit;
        end;
      End;

  //Validar usuario
      DataModule1.QueryFunc.SQL.Clear;
      DataModule1.QueryFunc.SQL.Add('select usuario from funcionarios where usuario = '  +QuotedStr(Trim(edtUsuario.text)));
      DataModule1.QueryFunc.Open;

      if not DataModule1.QueryFunc.IsEmpty then
      begin
        if usuant <> edtUsuario.Text then
        Begin
        MessageDlg('o Usuário: ' + edtUsuario.Text + ' já existe!!' , mtWarning, [mbOK], 0);
        edtUsuario.SetFocus;
        exit;
        End;
      end;

  //Validar senha
      if edtsenha.Text <> edtConfSenha.Text then
      Begin
        MessageDlg('A senha não confere!!' , mtWarning, [mbOK], 0);
        edtsenha.SetFocus;
        edtConfSenha.Text := '';
        exit;
      End;

      associaCampos;
      buscarTudo;
      limparcamposFunc;
      desabilitarcamposFunc;
      MessageDlg('Editado com sucesso!!', mtWarning, [mbOK], 0);
      btnNovo.Enabled := true;
      btnEditar.Enabled := false;
      btnSalvar.Enabled := false;
      btnExcluir.Enabled := false;
      grid.Enabled := true;

  End;
end;

procedure TFrmfuncionarios.btnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
     if edtCodigo.Text <> '' then
     Begin
      DataModule1.QueryFunc.Close;
      DataModule1.QueryFunc.SQL.Clear;
      DataModule1.QueryFunc.SQL.Add('delete from funcionarios where id=' + edtCodigo.Text);
      DataModule1.QueryFunc.ExecSQL;
      MessageDlg('Excluido com Sucesso!!', mtWarning, [mbOK], 0);
      desabilitarcamposFunc;
      limparcamposFunc;
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

procedure TFrmfuncionarios.btnNovoClick(Sender: TObject);
begin

  DataModule1.tb_funcionarios.Insert;
  habilitarcamposFunc;
  limparcamposFunc;
  edtNome.SetFocus;
  grid.Enabled := false;
  btnSalvar.Enabled := true;
  btnNovo.Enabled := false;
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
end;

procedure TFrmfuncionarios.btnSalvarClick(Sender: TObject);
 var
 usu : String;
begin
  if (edtNome.Text <> '') and (edtCPF.Text <> '   .   .   -  ') then
  Begin
    WITH DataModule1.tb_funcionarios DO
      Begin
            DataModule1.QueryFunc.SQL.Clear;
            DataModule1.QueryFunc.SQL.Add('select cpf from funcionarios where cpf = ' +QuotedStr(Trim(edtCPF.Text)) );
            DataModule1.QueryFunc.Open;
            //verificada cpf
            if NOT DataModule1.QueryFunc.IsEmpty then
             Begin
               MessageDlg('CPF **'+ edtCPF.Text + '** já existe no Banco de Dados!', mtWarning, [mbOK], 0);
               edtCPF.SetFocus;
               exit;

             End;

             //verifica nome
             DataModule1.QueryFunc.SQL.Clear;
             DataModule1.QueryFunc.SQL.Add('select usuario from funcionarios where usuario = ' +QuotedStr(Trim(edtUsuario.Text)) );
             DataModule1.QueryFunc.Open;

             if DataModule1.QueryFunc.IsEmpty then
             Begin
              if edtsenha.Text = edtConfSenha.Text then
              Begin
                with DataModule1.tb_funcionarios do
                Begin
                  FieldByName('nome').Value := edtNome.Text;
                  FieldByName('cpf').Value := edtCPF.Text;
                  FieldByName('telefone').Value := edtTel.Text;
                  FieldByName('endereco').Value := edtEndereco.Text;
                  FieldByName('cargo').Value := cbCargo.Text;
                  FieldByName('usuario').Value := edtUsuario.Text;
                  FieldByName('senha').Value := edtSenha.Text;
                  FieldByName('data').Value := DateToStr(Date());

                  Post;
                End;

                MessageDlg('Salvo com Sucesso!!', mtWarning, [mbOK], 0);
                desabilitarcamposFunc;
                limparcamposFunc;
                btnSalvar.Enabled := false;
                btnExcluir.Enabled := false;
                btnEditar.Enabled := false;
                btnNovo.Enabled := true;
                grid.Enabled := true;
                buscarTudo;
                exit;





              End
              else
              Begin
                MessageDlg('Senha não confere!!', mtWarning, [mbOK], 0);
                edtsenha.Text := '';
                edtConfSenha.Text := '';
                edtsenha.SetFocus;
                exit;
              End;
             End;

               MessageDlg('USUÁRIO ** '+ edtUsuario.Text + ' ** já existe no Banco de Dados!', mtWarning, [mbOK], 0);
               edtUsuario.SetFocus;
               exit;

                {FieldByName('nome').Value := edtNome.Text;
                FieldByName('cpf').Value := edtCPF.Text;
                FieldByName('telefone').Value := edtTel.Text;
                FieldByName('endereco').Value := edtEndereco.Text;
                FieldByName('cargo').Value := cbCargo.Text;
                FieldByName('usuario').Value := edtUsuario.Text;
                FieldByName('senha').Value := edtsenha.Text;
                FieldByName('data').Value :=  DateToStr(Date());
                Post;}



     end;
  End
  else
  Begin
    MessageDlg('Preencha os Campos!!', mtWarning, [mbOK], 0);


  End;

end;

procedure TFrmfuncionarios.buscarCPF;
begin
  DataModule1.QueryConFunc.Close;
  DataModule1.QueryConFunc.SQL.Clear;
  DataModule1.QueryConFunc.SQL.Add('select * from funcionarios where cpf = :cpf order by id desc');
  DataModule1.QueryConFunc.ParamByName('cpf').Value := edtBuscarCpf.Text;
  DataModule1.QueryConFunc.Open;
end;

procedure TFrmfuncionarios.buscarNome;
begin
  DataModule1.QueryConFunc.Close;
  DataModule1.QueryConFunc.SQL.Clear;
  DataModule1.QueryConFunc.SQL.Add('select * from funcionarios where nome like :nome order by id desc');
  DataModule1.QueryConFunc.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  DataModule1.QueryConFunc.Open;
end;

procedure TFrmfuncionarios.buscarTudo;
begin
  DataModule1.QueryConFunc.Close;
  DataModule1.QueryConFunc.SQL.Clear;
  DataModule1.QueryConFunc.SQL.Add('select * from funcionarios order by id desc');
  DataModule1.QueryConFunc.Open;


end;

procedure TFrmfuncionarios.edtBuscarCpfChange(Sender: TObject);
begin
 if edtBuscarCpf.Text <> '' then
  BEGIN
   buscarCPF;
  END
  ELSE
  BEGIN
    buscarTudo;
  END;
end;

procedure TFrmfuncionarios.EdtBuscarNomeChange(Sender: TObject);
begin
if EdtBuscarNome.Text <> '' then
  BEGIN
   buscarNome;
  END
  ELSE
  BEGIN
    buscarTudo;
  END;

end;

procedure TFrmfuncionarios.edtCPFChange(Sender: TObject);
begin

  //DataModule1.tb_funcionarios.FieldByName('cpf').Value := edtCPF.Text;
end;

procedure TFrmfuncionarios.edtCPFExit(Sender: TObject);
var cpf : String;
    valida : integer;
begin
//cpf := Trim(edtCPF.Text);
//validarCPF(cpf);
{valida := validarCPF(cpf);
  if valida = 0 then
  Begin
  MessageDlg('CPF inválido', mtWarning, [mbOK], 0);
  edtCPF.SetFocus;
  exit;
  End;

  MessageDlg('CPF Válido', mtWarning, [mbOK], 0);}
end;

procedure TFrmfuncionarios.FormCreate(Sender: TObject);
begin
 edtBuscarCpf.Visible := false;
 edtBuscarCpf.Text := '';
end;

procedure TFrmfuncionarios.FormShow(Sender: TObject);
begin
  DataModule1.tb_funcionarios.Active := false;
  DataModule1.tb_funcionarios.Active := true;
  carregarComboboxCargo;
  buscarTudo;
end;

procedure TFrmfuncionarios.gridCellClick(Column: TColumn);

begin
    DataModule1.tb_funcionarios.Edit;
  With DataModule1.QueryConFunc do
  Begin


    edtNome.Text := FieldByName('nome').Value;
    edtCPF.Text := FieldByName('cpf').Value;
    edtTel.Text := FieldByName('telefone').Value;
    edtEndereco.Text := FieldByName('endereco').Value;
    cbCargo.Text := FieldByName('cargo').Value;
    edtsenha.Text := FieldByName('senha').Value;
    edtConfSenha.Text := FieldByName('senha').Value;
    edtUsuario.Text := FieldByName('usuario').Value;
    edtCodigo.Text := FieldByName('id').Value;

    habilitarcamposFunc;
    btnEditar.Enabled := true;
    btnExcluir.Enabled := true;
    btnNovo.Enabled := true;
    cpfant := FieldByName('cpf').Value;
    usuant := FieldByName('usuario').Value;
  End;
end;

procedure TFrmfuncionarios.gridInsert(x: Integer);
begin
 if x = 1 then
 begin
   DataModule1.tb_funcionarios.Insert;
 end;
end;

procedure TFrmfuncionarios.rbCPFClick(Sender: TObject);
begin
 if rbCPF.Checked = true then
  begin
    EdtBuscarNome.Text := '';
    EdtBuscarNome.Visible := false;
    edtBuscarCpf.Text := '';
    edtBuscarCpf.Visible := true;
  end;
end;

procedure TFrmfuncionarios.rbNomeClick(Sender: TObject);
begin
   if rbNome.Checked = true then
  begin
    EdtBuscarNome.Text := '';
    EdtBuscarNome.Visible := true;
    edtBuscarCpf.Text := '';
    edtBuscarCpf.Visible := false;
  end;
end;

procedure TFrmfuncionarios.valcpfExit(Sender: TObject);
var cpf : String;
    valida : integer;
begin
cpf := Trim(valcpf.Text);
//validarCPF(cpf);
valida := validarCPF(cpf);
  if valida = 0 then
  Begin
  MessageDlg('CPF inválido', mtWarning, [mbOK], 0);
  edtCPF.SetFocus;
  exit;
  End;

  MessageDlg('CPF Válido', mtWarning, [mbOK], 0);
end;

end.
