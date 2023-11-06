import random
import traceback

import oracledb
from faker import Faker

lista_logradouro = []
i = 1
cont = 0
while i <= 1080:
    fake = Faker('pt_BR')
    fake_name = fake.name()
    fake_rua = fake.street_name()
    fake_cep = fake.postcode()
    cep_int = fake_cep.translate({ord('-'): None})
    lista_rua_avenida = ["Rua", "Avenida"]
    zonas_random = random.choice(lista_rua_avenida)
    cont = cont + i%2    
    logradouro_data = {
        'id_logradouro': int(i),
        'id_bairro': int(cont),
        'nm_logradouro': f'{zonas_random} {fake_rua}',
        'nr_cep': int(cep_int),
        'nm_usuario': fake_name
        }
    lista_logradouro.append(logradouro_data)
    i = i + 1

try:
    db_config = {"user":"rm94156", 
        "password":'120703',
        "dsn":"oracle.fiap.com.br/orcl"}

    # Establish a database connection
    with oracledb.connect(**db_config) as connection:
        # Define the SQL INSERT statement
        sql = '''
        INSERT INTO  t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario) 
        VALUES (:id_logradouro, :id_bairro, :nm_logradouro, :nr_cep , :nm_usuario)
        '''

        # Create a cursor
        with connection.cursor() as cursor:
            for logradouro_data in lista_logradouro:
                # Execute the INSERT statement for each dictionary in lista_bairro
                cursor.execute(sql, logradouro_data)
                connection.commit()  # Commit the changes to the database

        print("Data inserted successfully.")
except Exception as erro:
    #print(erro)
    traceback.print_exc()
    raise erro







