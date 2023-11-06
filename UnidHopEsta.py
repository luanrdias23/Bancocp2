import random
import traceback
import datetime
import oracledb

# Função para inserir uma unidade hospitalar
def inserir_unidade_hospitalar(cursor, id_estado, nome_unidade_hospitalar, nome_razao_social):
    sql = '''
    INSERT INTO t_rhstu_unid_hospitalar (id_unid_hospital, nm_unid_hospitalar, nm_razao_social_unid_hosp, dt_fundacao, nr_logradouro, ds_complemento_numero, ds_ponto_referencia, dt_inicio, dt_cadastro, nm_usuario)
    VALUES (:id_unid_hospital, :nm_unid_hospitalar, :nm_razao_social_unid_hosp, :dt_fundacao, :nr_logradouro, :ds_complemento_numero, :ds_ponto_referencia, :dt_inicio, :dt_cadastro, :nm_usuario)
    '''
    data_atual = datetime.datetime.now()
    data_fundacao = datetime.datetime(1990, 1, 1)  # Data fictícia de fundação
    id_unid_hospital = random.randint(1, 99999)  # ID único para a unidade hospitalar
    nr_logradouro = random.randint(1, 9999)  # Número de logradouro fictício
    ds_complemento_numero = 'Complemento'  # Complemento fictício
    ds_ponto_referencia = 'Ponto de referência'  # Ponto de referência fictício

    cursor.execute(sql, {
        'id_unid_hospital': id_unid_hospital,
        'nm_unid_hospitalar': nome_unidade_hospitalar,
        'nm_razao_social_unid_hosp': nome_razao_social,
        'dt_fundacao': data_fundacao,
        'nr_logradouro': nr_logradouro,
        'ds_complemento_numero': ds_complemento_numero,
        'ds_ponto_referencia': ds_ponto_referencia,
        'dt_inicio': data_atual,
        'dt_cadastro': data_atual,
        'nm_usuario': 'Admin'
    })

# Lista de estados
estados = [
    {'id_estado': 1, 'sg_estado': 'AC', 'nm_estado': 'Acre'},
    {'id_estado': 2, 'sg_estado': 'AL', 'nm_estado': 'Alagoas'},
    {'id_estado': 3, 'sg_estado': 'AP', 'nm_estado': 'Amapá'},
    {'id_estado': 4, 'sg_estado': 'AM', 'nm_estado': 'Amazonas'},
    {'id_estado': 5, 'sg_estado': 'BA', 'nm_estado': 'Bahia'},
    {'id_estado': 6, 'sg_estado': 'CE', 'nm_estado': 'Ceará'},
    {'id_estado': 7, 'sg_estado': 'DF', 'nm_estado': 'Distrito Federal'},
    {'id_estado': 8, 'sg_estado': 'ES', 'nm_estado': 'Espírito Santo'},
    {'id_estado': 9, 'sg_estado': 'GO', 'nm_estado': 'Goiás'},
    {'id_estado': 10, 'sg_estado': 'MA', 'nm_estado': 'Maranhão'},
    {'id_estado': 11, 'sg_estado': 'MT', 'nm_estado': 'Mato Grosso'},
    {'id_estado': 12, 'sg_estado': 'MS', 'nm_estado': 'Mato Grosso do Sul'},
    {'id_estado': 13, 'sg_estado': 'MG', 'nm_estado': 'Minas Gerais'},
    {'id_estado': 14, 'sg_estado': 'PA', 'nm_estado': 'Pará'},
    {'id_estado': 15, 'sg_estado': 'PB', 'nm_estado': 'Paraíba'},
    {'id_estado': 16, 'sg_estado': 'PR', 'nm_estado': 'Paraná'},
    {'id_estado': 17, 'sg_estado': 'PE', 'nm_estado': 'Pernambuco'},
    {'id_estado': 18, 'sg_estado': 'PI', 'nm_estado': 'Piauí'},
    {'id_estado': 19, 'sg_estado': 'RJ', 'nm_estado': 'Rio de Janeiro'},
    {'id_estado': 20, 'sg_estado': 'RN', 'nm_estado': 'Rio Grande do Norte'},
    {'id_estado': 21, 'sg_estado': 'RS', 'nm_estado': 'Rio Grande do Sul'},
    {'id_estado': 22, 'sg_estado': 'RO', 'nm_estado': 'Rondônia'},
    {'id_estado': 23, 'sg_estado': 'RR', 'nm_estado': 'Roraima'},
    {'id_estado': 24, 'sg_estado': 'SC', 'nm_estado': 'Santa Catarina'},
    {'id_estado': 25, 'sg_estado': 'SP', 'nm_estado': 'São Paulo'},
    {'id_estado': 26, 'sg_estado': 'SE', 'nm_estado': 'Sergipe'},
    {'id_estado': 27, 'sg_estado': 'TO', 'nm_estado': 'Tocantins'}
]

try:
    db_config = {"user":"rm94156", 
                 "password":'120703',
                 "dsn":"oracle.fiap.com.br/orcl"}

    # Estabelece uma conexão com o banco de dados Oracle
    with oracledb.connect(**db_config) as connection:
        # Cria um cursor
        with connection.cursor() as cursor:
            # Insere uma unidade hospitalar para cada estado
            for estado in estados:
                inserir_unidade_hospitalar(cursor, estado['id_estado'], f"Unidade em {estado['nm_estado']}", "Razão Social da Unidade")

            # Realiza o commit para salvar as alterações
            connection.commit()

    print("Unidades hospitalares cadastradas com sucesso.")
except Exception as erro:
    traceback.print_exc()
    raise erro
