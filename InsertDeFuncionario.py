import random
import traceback
import datetime
import oracledb
from faker import Faker

lista_funcionarios = []
i = 2
cont = 0
rgs_adicionados = set()
cpfs_adicionados = set()
nomes_adicionados = set()
medicos_adicionados = set()
motoristas_adicionados = set()
gestores_adicionados = set()

funcionarios_data = {
        'id_func': 1,
        'id_superior': 1,
        'nm_func': 'Charles Carvalho',
        'ds_cargo': 'Presidente',
        'dt_nascimento': '1997/09/11',
        'vl_salario': 50000,
        'nr_rg': 534888169, 
        'nr_cpf': 41638159632,
        'st_func': 'A',
        'dt_cadastro': '1997/09/11',                
        'nm_usuario': 'Luan Dias' 
        }
lista_funcionarios.append(funcionarios_data)
rgs_adicionados.add('534888169')
cpfs_adicionados.add(41638159632)
nomes_adicionados.add('Charles Carvalho')
nomes_adicionados.add('Luan Dias')
gestores_adicionados.add(1)

while i <= 50000:
    fake = Faker('pt_BR')

    fake_name_masc = fake.name_male()[:25]
    fake_name_fem = fake.name_female()[:25]
    names = [fake_name_masc, fake_name_fem]
    name = random.choice(names)

    fake_cpf = None
    while True:
        fake_cpf = fake.cpf()
        cpf_sem_traço = fake_cpf.translate({ord('-'): None})
        cpf_final = cpf_sem_traço.translate({ord('.'): None})
        if cpf_final not in cpfs_adicionados:
            cpfs_adicionados.add(cpf_final)
            break   
    fake_rg = None
    while True:
        fake_rg = fake.rg()
        if not any(char.isalpha() for char in fake_rg):
            if fake_rg not in rgs_adicionados:
                rgs_adicionados.add(fake_rg)
                break


    start_date = datetime.date(1920, 1, 1)  
    end_date = datetime.date(2023, 10, 31)
    random_date = start_date + datetime.timedelta(days=random.randint(0, (end_date - start_date).days))
    data_nascimento = random_date.strftime("%Y-%m-%d")

    cargos_saude = [
    "Médico(a)",
    "Enfermeiro(a)",
    "Farmacêutico(a)",
    "Gestor(a)",
    "Nutricionista",
    "Psicólogo(a)",
    "Terapeuta Ocupacional",
    "Motorista"
    ]
    while True:
        cargo_selecionado = random.choice(cargos_saude)
        if cargo_selecionado == "Motorista" and len(motoristas_adicionados) <= 1000:
            motoristas_adicionados.add(i)
            break
        elif cargo_selecionado == "Médico(a)" and len(medicos_adicionados) <= 5000:
            medicos_adicionados.add(i)
            break
        elif cargo_selecionado == "Gestor(a)" and len(gestores_adicionados) <= 500:
            gestores_adicionados.add(i)
            break
        else:
            break    
    while True:
        gestores_lista = list(gestores_adicionados)
        if len(gestores_adicionados) != 0 and cargo_selecionado != "Gestor(a)":
            id_gestor = random.choice(gestores_lista)
            break
        elif len(gestores_adicionados) != 0 and cargo_selecionado == "Gestor(a)":
            id_gestor = random.choice(gestores_lista)
            if id_gestor == i:
                continue
            else:
                break
        elif len(gestores_lista) == 0:
            id_gestor = i
            break
    
    salario = random.randint(1000, 30000)

    status_func = ["A", "I"]
    status_funcionalidade = random.choice(status_func)

    start_date_cad = datetime.date(2015, 1, 1)  
    end_date_cad = datetime.date(2023, 10, 31)
    random_date_cad = start_date_cad + datetime.timedelta(days=random.randint(0, (end_date_cad - start_date_cad).days))
    formatted_date_cad = random_date_cad.strftime("%Y-%m-%d")
    
    fake_name_user = fake.name()[:25]
       
    funcionarios_data = {
        'id_func': int(i),
        'id_superior': id_gestor,
        'nm_func': name,
        'ds_cargo': cargo_selecionado,
        'dt_nascimento': data_nascimento,
        'vl_salario': salario,
        'nr_rg': int(fake_rg), 
        'nr_cpf': int(cpf_final),
        'st_func': status_funcionalidade,
        'dt_cadastro': formatted_date_cad,                
        'nm_usuario': fake_name_user
        }
    lista_funcionarios.append(funcionarios_data)
    print(i)
    i = i + 1
    
try:
    db_config = {"user":"rm94156", 
        "password":'120703',
        "dsn":"oracle.fiap.com.br/orcl"}

    # Establish a database connection
    with oracledb.connect(**db_config) as connection:
        # Define the SQL INSERT statement
        sql = '''
        INSERT INTO t_rhstu_funcionario (id_func, id_superior, nm_func, ds_cargo, dt_nascimento, vl_salario, nr_rg, nr_cpf, st_func, dt_cadastro, nm_usuario) 
        VALUES (:id_func, :id_superior, :nm_func, :ds_cargo, TO_DATE(:dt_nascimento, 'YYYY-MM-DD'), :vl_salario, :nr_rg, :nr_cpf, :st_func, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)
        '''


        # Create a cursor
        with connection.cursor() as cursor:
            for funcionarios_data in lista_funcionarios:
                # Execute the INSERT statement for each dictionary in lista_bairro
                cursor.execute(sql, funcionarios_data)
                  # Commit the changes to the database
        connection.commit()
        print("Data inserted successfully.")
except Exception as erro:
    #print(erro)
    traceback.print_exc()
    raise erro