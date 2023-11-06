import oracledb
import random
import traceback

# Estabeleça uma conexão com o banco de dados Oracle


# Crie um cursor


# Lista de medicamentos
medicamentos = []

for i in range(100000, 200000):
    # Gerar dados aleatórios para o medicamento
    nome_medicamento = f"Medicamento {i}"
    descricao = "Descrição detalhada do medicamento"
    codigo_barras = random.randint(1000000000, 9999999999)

    # Crie um dicionário com os dados do medicamento
    medicamento_data = {
        'id_medicamento': i,
        'nm_medicamento': nome_medicamento,
        'ds_detalhada_medicamento': descricao,
        'nr_codigo_barras': codigo_barras,
        'dt_cadastro': '2023-10-27',  # Defina a data desejada
        'nm_usuario': 'Admin'
    }

    # Adicione o dicionário à lista de medicamentos
    medicamentos.append(medicamento_data)

# SQL de inserção

try:
    db_config = {"user":"rm94156", 
        "password":'120703',
        "dsn":"oracle.fiap.com.br/orcl"}

    # Establish a database connection
    with oracledb.connect(**db_config) as connection:
        # Define the SQL INSERT statement
        sql = """
        INSERT INTO t_rhstu_medicamento (id_medicamento, nm_medicamento, ds_detalhada_medicamento, nr_codigo_barras, dt_cadastro, nm_usuario)
        VALUES (:id_medicamento, :nm_medicamento, :ds_detalhada_medicamento, :nr_codigo_barras, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)
        """



        # Create a cursor
        with connection.cursor() as cursor:
            for medicamento_data in medicamentos:
                # Execute the INSERT statement for each dictionary in lista_bairro
                cursor.execute(sql, medicamento_data)
                  # Commit the changes to the database
        connection.commit()
        print("Data inserted successfully.")
except Exception as erro:
    #print(erro)
    traceback.print_exc()
    raise erro
