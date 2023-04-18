object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 488
  Width = 603
  object conn: TFDConnection
    Params.Strings = (
      'Database=sysrestaurante'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 440
    Top = 8
  end
  object Driver: TFDPhysMSAccessDriverLink
    VendorLib = 'C:\xampp\mysql\lib\libmySQL.dll'
    Left = 488
    Top = 8
  end
  object WaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 544
    Top = 8
  end
  object ds_cargo: TDataSource
    DataSet = tb_cargo
    Left = 80
    Top = 24
  end
  object tb_cargo: TFDTable
    IndexFieldNames = 'id'
    Connection = conn
    UpdateOptions.UpdateTableName = 'sysrestaurante.cargo'
    TableName = 'sysrestaurante.cargo'
    Left = 32
    Top = 24
    object tb_cargoid: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 5
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object tb_cargonome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 15
    end
  end
  object ds_funcionarios: TDataSource
    DataSet = tb_funcionarios
    Left = 112
    Top = 96
  end
  object tb_funcionarios: TFDTable
    IndexFieldNames = 'id'
    Connection = conn
    UpdateOptions.UpdateTableName = 'sysrestaurante.funcionarios'
    TableName = 'sysrestaurante.funcionarios'
    Left = 32
    Top = 96
    object tb_funcionariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
      Visible = False
    end
    object tb_funcionariosnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 30
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object tb_funcionarioscpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
      EditMask = '000\.000\.000\-00;1;_'
      Size = 15
    end
    object tb_funcionariostelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 15
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      EditMask = '!\(99\)00000-0000;1;_'
    end
    object tb_funcionariosendereco: TStringField
      DisplayLabel = 'Endereco'
      DisplayWidth = 50
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 100
    end
    object tb_funcionarioscargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object tb_funcionariosusuario: TStringField
      DisplayLabel = 'Usuario'
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
    end
    object tb_funcionariossenha: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
    end
    object tb_funcionariosdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object QueryFunc: TFDQuery
    Connection = conn
    Left = 184
    Top = 96
  end
  object QueryCargo: TFDQuery
    Connection = conn
    Left = 136
    Top = 24
  end
  object QueryConFunc: TFDQuery
    Connection = conn
    Left = 264
    Top = 96
    object QueryConFuncid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object QueryConFuncnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object QueryConFunccpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
    end
    object QueryConFunctelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 15
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
    end
    object QueryConFuncendereco: TStringField
      DisplayLabel = 'Endereco'
      DisplayWidth = 15
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 100
    end
    object QueryConFunccargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object QueryConFuncusuario: TStringField
      DisplayLabel = 'Usuario'
      DisplayWidth = 10
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
    end
    object QueryConFuncsenha: TStringField
      DisplayLabel = 'Senha'
      DisplayWidth = 10
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
    end
    object QueryConFuncdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object dsConFunc: TDataSource
    DataSet = QueryConFunc
    Left = 360
    Top = 96
  end
  object tb_fornecedores: TFDTable
    IndexFieldNames = 'id'
    Connection = conn
    UpdateOptions.UpdateTableName = 'sysrestaurante.fornecedores'
    TableName = 'sysrestaurante.fornecedores'
    Left = 32
    Top = 152
    object tb_fornecedoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tb_fornecedoresnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object tb_fornecedorestelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object tb_fornecedoresemail: TStringField
      DisplayWidth = 40
      FieldName = 'email'
      Origin = 'email'
      Size = 30
    end
    object tb_fornecedoresendereco: TStringField
      DisplayWidth = 70
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 50
    end
  end
  object ds_fornecedores: TDataSource
    DataSet = tb_fornecedores
    Left = 112
    Top = 152
  end
  object QueryForn: TFDQuery
    Connection = conn
    SQL.Strings = (
      'select * from fornecedores order by id desc')
    Left = 184
    Top = 152
    object QueryFornid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object QueryFornnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 12
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object QueryForntelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 15
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
    end
    object QueryFornemail: TStringField
      DisplayLabel = 'Email'
      DisplayWidth = 13
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 30
    end
    object QueryFornendereco: TStringField
      DisplayLabel = 'Endereco'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 50
    end
  end
  object dsConForne: TDataSource
    DataSet = QueryForn
    Left = 264
    Top = 152
  end
  object tb_produtos: TFDTable
    IndexFieldNames = 'id'
    Connection = conn
    UpdateOptions.UpdateTableName = 'sysrestaurante.produtos'
    TableName = 'sysrestaurante.produtos'
    Left = 32
    Top = 224
    object tb_produtosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tb_produtosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object tb_produtosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 50
    end
    object tb_produtosvalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 10
      Size = 2
    end
    object tb_produtosquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object tb_produtosfornecedor: TIntegerField
      FieldName = 'fornecedor'
      Origin = 'fornecedor'
    end
    object tb_produtosimagem: TBlobField
      FieldName = 'imagem'
      Origin = 'imagem'
    end
  end
  object queryProd: TFDQuery
    Connection = conn
    SQL.Strings = (
      
        'select p.id, p.nome, p.descricao, p.valor, p.quantidade, p.forne' +
        'cedor, f.nome, p.imagem from produtos as p INNER JOIN fornecedor' +
        'es as f ON p.fornecedor = f.id order by id desc')
    Left = 96
    Top = 224
    object queryProdid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object queryProdnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 12
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object queryProddescricao: TStringField
      DisplayLabel = 'Descricao'
      DisplayWidth = 45
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 50
    end
    object queryProdvalor: TBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Precision = 10
      Size = 2
    end
    object queryProdquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object queryProdnome_1: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Fornecedor'
      DisplayWidth = 12
      FieldName = 'nome_1'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object queryProdfornecedor: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'fornecedor'
      Origin = 'fornecedor'
      Required = True
      Visible = False
    end
    object queryProdimagem: TBlobField
      FieldName = 'imagem'
      Origin = 'imagem'
      Required = True
    end
  end
  object conprod: TDataSource
    DataSet = queryProd
    Left = 160
    Top = 224
  end
end
