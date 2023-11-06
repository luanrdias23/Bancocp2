import random
import traceback
import datetime
import oracledb

# Função para inserir um tipo de contato
def inserir_tipo_contato(cursor, nome_tipo_contato):
    sql = '''
    INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
    VALUES (:id_tipo_contato, :nm_tipo_contato, :dt_inicio, :dt_cadastro, :nm_usuario)
    '''
    data_atual = datetime.datetime.now()
    # Gere um ID único para o tipo de contato
    id_tipo_contato = random.randint(1, 99999)
    cursor.execute(sql, {
        'id_tipo_contato': id_tipo_contato,
        'nm_tipo_contato': nome_tipo_contato,
        'dt_inicio': data_atual,
        'dt_cadastro': data_atual,
        'nm_usuario': 'Admin'
    })

# Lista de tipos de contato
tipos_contato = ['Pai', 'Mãe', 'Esposa', 'Primo', 'Prima', 'Outros contatos']

try:
    db_config = {"user":"rm94156", 
                 "password":'120703',
                 "dsn":"oracle.fiap.com.br/orcl"}

    # Estabelece uma conexão com o banco de dados Oracle
    with oracledb.connect(**db_config) as connection:
        # Cria um cursor
        with connection.cursor() as cursor:
            # Insere os tipos de contato na tabela
            for tipo_contato in tipos_contato:
                inserir_tipo_contato(cursor, tipo_contato)

            # Realiza o commit para salvar as alterações
            connection.commit()

    print("Tipos de contato cadastrados com sucesso.")
except Exception as erro:
    traceback.print_exc()
    raise erro
