import random
import traceback
import datetime
import oracledb
from faker import Faker

lista_pacientes = []
i = 100001
cont = 0
rgs_adicionados = set()
cpfs_adicionados = set()

while i <= 200000:
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
        if fake_rg not in rgs_adicionados:
            rgs_adicionados.add(fake_rg)
            break

    start_date = datetime.date(1920, 1, 1)  
    end_date = datetime.date(2023, 10, 31)
    random_date = start_date + datetime.timedelta(days=random.randint(0, (end_date - start_date).days))
    formatted_date = random_date.strftime("%Y-%m-%d")

    lista_sexob = ["F", "I", "M"]
    if name == names[0]:
        letra_sex = random.choice([lista_sexob[1], lista_sexob[2]])
    else:
        letra_sex = random.choice([lista_sexob[0], lista_sexob[1]])
    
    categorias_escolaridade = [
    "Creche",
    "Pré-Escola",
    "Ensino Fundamental",
    "Ensino Fundamental",
    "Ensino Médio",
    "Educação Técnica",
    "Graduação (Bacharelado)",
    "Graduação (Licenciatura)",
    "Graduação (Tecnólogo)",
    "Pós-Graduação",
    "Pós-Graduação",
    "Pós-Graduação",
    "Educação de Jovens e Adultos",
    "Educação a Distância",
    "Ed. Tecn ou Prof."
    ]
    escolaridades = random.choice(categorias_escolaridade)

    estados_civis = [
    "Solteiro(a)",
    "Casado(a)",
    "União Estável",
    "Divorciado(a)",
    "Viúvo(a)",
    "Separado(a) Judicialmente",
    "Outro"
    ]
    estado_civil = random.choice(estados_civis)

    grupos_sanguineos = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
    ]
    grupo_sangue = random.choice(grupos_sanguineos)

    altura = random.uniform(0.1, 2.99)
    altura_formatada = "{:.2f}".format(altura)

    peso = random.randint(1, 800)
    
    start_date_cad = datetime.date(2015, 1, 1)  
    end_date_cad = datetime.date(2023, 10, 31)
    random_date_cad = start_date_cad + datetime.timedelta(days=random.randint(0, (end_date_cad - start_date_cad).days))
    formatted_date_cad = random_date_cad.strftime("%Y-%m-%d")

    fake_name = fake.name()[:25]
       
    paciente_data = {
        'id_paciente': int(i),
        'nm_paciente': name,
        'nr_cpf': int(cpf_final),
        'nm_rg': str(fake_rg),
        'dt_nascimento': formatted_date,
        'fl_sexo_biologico': letra_sex,
        'ds_escolaridade': escolaridades,
        'ds_estado_civil': estado_civil,
        'nm_grupo_sanguineo': grupo_sangue,
        'nr_altura': altura_formatada,
        'nr_peso': peso,
        'dt_cadastro': formatted_date_cad,
        'nm_usuario': fake_name 
        }
    lista_pacientes.append(paciente_data)
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
        INSERT INTO t_rhstu_paciente (id_paciente, nm_paciente, nr_cpf, nm_rg, dt_nascimento, fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso, dt_cadastro, nm_usuario) 
        VALUES (:id_paciente, :nm_paciente, :nr_cpf, :nm_rg, TO_DATE(:dt_nascimento, 'YYYY-MM-DD'), :fl_sexo_biologico, :ds_escolaridade, :ds_estado_civil, :nm_grupo_sanguineo, :nr_altura, :nr_peso, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)
        '''


        # Create a cursor
        with connection.cursor() as cursor:
            for paciente_data in lista_pacientes:
                # Execute the INSERT statement for each dictionary in lista_bairro
                cursor.execute(sql, paciente_data)
                  # Commit the changes to the database
        connection.commit()
        print("Data inserted successfully.")
except Exception as erro:
    #print(erro)
    traceback.print_exc()
    raise erro
    