import random
import traceback
import datetime
import oracledb
from faker import Faker

# Função para inserir um telefone para paciente
def inserir_telefone_paciente(cursor, id_paciente, id_telefone):
    fake = Faker('pt_BR')
    ddi = fake.random_int(min=1, max=99)  # DDI fictício
    ddd = fake.random_int(min=10, max=99)  # DDD fictício
    nr_telefone = fake.random_int(min=100000000, max=999999999)  # Número de telefone fictício
    tp_telefone = fake.random_element(elements=('CELULAR', 'COMERCIAL', 'CONTATO OU RECADO', 'RESIDENCIAL'))
    st_telefone = fake.random_element(elements=('A', 'I'))  # Status fictício (Ativo/Inativo)
    data_atual = datetime.datetime.now()
    
    sql = '''
    INSERT INTO t_rhstu_telefone_paciente (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro, nm_usuario)
    VALUES (:id_paciente, :id_telefone, :nr_ddi, :nr_ddd, :nr_telefone, :tp_telefone, :st_telefone, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)
    '''

    cursor.execute(sql, {
        'id_paciente': id_paciente,
        'id_telefone': id_telefone,
        'nr_ddi': ddi,
        'nr_ddd': ddd,
        'nr_telefone': nr_telefone,
        'tp_telefone': tp_telefone,
        'st_telefone': st_telefone,
        'dt_cadastro': data_atual,
        'nm_usuario': 'Admin'
    })

# Dados de exemplo
id_paciente = 1  # ID do primeiro paciente fictício

# Número total de pacientes
total_pacientes = 100000

# Cria uma conexão com o banco de dados
try:
    db_config = {
        "user":"rm94156", 
         "password":'120703',
         "dsn":"oracle.fiap.com.br/orcl"
    }

    with oracledb.connect(**db_config) as connection:
        with connection.cursor() as cursor:
            # Chame a função para inserir telefones para cada paciente
            for id_paciente in range(1, total_pacientes + 1):
                # Gere um ID de telefone fictício
                id_telefone = random.randint(1, 1000000)
                inserir_telefone_paciente(cursor, id_paciente, id_telefone)
            
            connection.commit()

    print("Telefones para pacientes cadastrados com sucesso.")
except Exception as erro:
    traceback.print_exc()
    raise erro
