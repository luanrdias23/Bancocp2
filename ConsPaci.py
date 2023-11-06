import random
import traceback
import datetime
import oracledb

# Função para verificar a existência de uma unidade hospitalar
def verificar_existencia_unidade_hospitalar(cursor, id_unid_hospital):
    sql = "SELECT COUNT(*) FROM t_rhstu_unid_hospitalar WHERE id_unid_hospital = :id_unid_hospital"
    cursor.execute(sql, {'id_unid_hospital': id_unid_hospital})
    count = cursor.fetchone()[0]
    return count >0

# Função para inserir uma consulta médica
def inserir_consulta_medica(cursor, id_unid_hospital, id_consulta, id_paciente, id_func, dt_hr_consulta, nr_consultorio):
    sql = '''
    INSERT INTO t_rhstu_consulta (id_unid_hospital, id_consulta, id_paciente, id_func, dt_hr_consulta, nr_consultorio, dt_cadastro, nm_usuario)
    VALUES (:id_unid_hospital, :id_consulta, :id_paciente, :id_func, TO_DATE(:dt_hr_consulta, 'YYYY-MM-DD HH24:MI:SS'), :nr_consultorio, SYSDATE, :nm_usuario)
    '''
    cursor.execute(sql, {
        'id_unid_hospital': id_unid_hospital,
        'id_consulta': id_consulta,
        'id_paciente': id_paciente,
        'id_func': id_func,
        'dt_hr_consulta': dt_hr_consulta,
        'nr_consultorio': nr_consultorio,
        'nm_usuario': 'Admin'
    })

# Dados de exemplo
id_func = 1  # ID do médico fictício
nr_consultorio = 1  # Número de consultório fictício

# Lista de pacientes (supondo que você já tenha a lista de pacientes)
lista_pacientes = [1, 2, 3, 4, 5]  # IDs dos pacientes fictícios

# Data de início em 2022
data_inicio = datetime.date(2022, 1, 1)

# Crie uma conexão com o banco de dados
try:
    db_config = {
        "user":"rm94156", 
                 "password":'120703',
                 "dsn":"oracle.fiap.com.br/orcl"
    }

    with oracledb.connect(**db_config) as connection:
        with connection.cursor() as cursor:
            for paciente in lista_pacientes:
                data = data_inicio
                while data.year <= 2023:
                    id_unid_hospital = 1  # Substitua pelo ID real da unidade hospitalar
                    if verificar_existencia_unidade_hospitalar(cursor, id_unid_hospital):
                        inserir_consulta_medica(cursor, id_unid_hospital, paciente, paciente, id_func, data, nr_consultorio)
                    else:
                        print(f"A unidade hospitalar com ID {id_unid_hospital} não existe.")
                    data += datetime.timedelta(days=2)

            connection.commit()

    print("Consultas médicas cadastradas com sucesso.")
except Exception as erro:
    traceback.print_exc()
    raise erro
