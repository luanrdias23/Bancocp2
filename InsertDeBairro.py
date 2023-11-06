import openpyxl
import random
import datetime
from faker import Faker
import oracledb
import traceback


lista_bairro = []
i = 1
cont = 0
while i <= 540:
    start_date = datetime.date(2000, 1, 1)  
    end_date = datetime.date(2023, 12, 31)
    random_date = start_date + datetime.timedelta(days=random.randint(0, (end_date - start_date).days))
    formatted_date = random_date.strftime("%Y-%m-%d")
    fake = Faker('pt_BR')
    fake_name = fake.name()
    fake_bairro = fake.bairro()
    lista_zonas = ['CENTRO', 'ZONA LESTE', 'ZONA NORTE', 'ZONA OESTE', 'ZONA SUL']
    zonas_random = random.choice(lista_zonas)
    cont = cont + i%2    
    bairro_data = {
        'id_bairro': i,
        'id_cidade': cont,
        'nm_bairro': fake_bairro,
        'nm_zona_bairro': zonas_random,
        'dt_cadastro': formatted_date,
        'nm_usuario': fake_name}
    lista_bairro.append(bairro_data)
    i = i + 1

try:
    db_config = {"user":"rm94156", 
        "password":'120703',
        "dsn":"oracle.fiap.com.br/orcl"}

    # Establish a database connection
    with oracledb.connect(**db_config) as connection:
        # Define the SQL INSERT statement
        sql = '''
        INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario) 
        VALUES (:id_bairro, :id_cidade, :nm_bairro, :nm_zona_bairro, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)
        '''

        # Create a cursor
        with connection.cursor() as cursor:
            for bairro_data in lista_bairro:
                # Execute the INSERT statement for each dictionary in lista_bairro
                cursor.execute(sql, bairro_data)
                connection.commit()  # Commit the changes to the database

        print("Data inserted successfully.")
except Exception as erro:
    #print(erro)
    traceback.print_exc()
    raise erro







