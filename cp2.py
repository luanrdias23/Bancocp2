import oracledb
import random

try:
        with oracledb.connect(
            user="rm94156", password='120703',
            dsn="oracle.fiap.com.br/orcl"                     
        ) as conexao:

           
    
fake = Faker()

cursor = conn.cursor()
# Lista de estados brasileiros
def associar_bairros_a_cidades(num_bairros):
    # Obtém todos os IDs disponíveis da tabela de cidades
    cursor.execute("SELECT id_cidade FROM t_rhstu_cidade")
    cidade_id = [row[0] for row in cursor.fetchall()]

    for i in range(1, num_bairros + 1):
        # Certifique-se de que há IDs de cidades disponíveis
        if not cidade_id:
            break

        # Seleciona aleatoriamente um ID de cidade
        cidade_id = random.choice(cidade_id)

        bairro_id = i

        # Insere o bairro associado a uma cidade
        cursor.execute(
            "INSERT INTO t_rhstu_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro, nm_usuario) VALUES (:1, :2, 'Bairro ' || TO_CHAR(:1), 'CENTRO', TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'Admin')",
            (bairro_id, cidade_id)
        )
    
        cidade_id.remove(cidade_id)

# Associe bairros a cidades
associar_bairros_a_cidades(50)  # Inserir pelo menos 50 bairros

# Função para associar logradouros a bairros
def associar_logradouros_a_bairros(num_logradouros):
    # Obtém todos os IDs disponíveis da tabela de bairros
    cursor.execute("SELECT id_bairro FROM t_rhstu_bairro")
    bairro_ids = [row[0] for row in cursor.fetchall()]

    for i in range(1, num_logradouros + 1):
        # Certifique-se de que há IDs de bairros disponíveis
        if not bairro_ids:
            break

        # Seleciona aleatoriamente um ID de bairro
        bairro_id = random.choice(bairro_ids)

        logradouro_id = i

        # Insere o logradouro associado a um bairro
        cursor.execute(
            "INSERT INTO t_rhstu_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, nm_usuario) VALUES (:1, :2, 'Rua ' || TO_CHAR(:1), 12345678, 'Admin')",
            (logradouro_id, bairro_id)
        )
    
        bairro_ids.remove(bairro_id)

# Associe logradouros a bairros
associar_logradouros_a_bairros(100)  

def inserir_pacientes_ficticios(num_pacientes):
    for i in range(1, num_pacientes + 1):
        paciente_id = i
        nome = fake.name()
        cpf = fake.unique.random_int(10000000000, 99999999999)
        rg = fake.random_int(1000000, 9999999)
        data_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=90)
        sexo = random.choice(['M', 'F'])
        escolaridade = fake.random_element(elements=('Ensino Médio', 'Superior', 'Pós-Graduação', 'Doutorado'))
        estado_civil = fake.random_element(elements=('Solteiro', 'Casado', 'Divorciado', 'Viúvo'))
        grupo_sanguineo = fake.random_element(elements=('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
        altura = fake.random.uniform(150, 200)
        peso = fake.random.uniform(40, 150)

        # Associe o paciente a um estado e cidade fictícia
        estado_id = fake.random_int(1, 27)  
        cidade_id = fake.random_int((estado_id - 1) * 10 + 1, estado_id * 10)

        cursor.execute("INSERT INTO t_rhstu_paciente (id_paciente, nm_paciente, nr_cpf, nm_rg, dt_nascimento, fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso, dt_cadastro, nm_usuario, id_estado, id_cidade) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'Admin', :12, :13)",
                        (paciente_id, nome, cpf, rg, data_nascimento, sexo, escolaridade, estado_civil, grupo_sanguineo, altura, peso, estado_id, cidade_id))
    
# Insira 400.000 pacientes fictícios
inserir_pacientes_ficticios(400000)

# Função para associar pacientes a endereços
def associar_pacientes_a_enderecos(num_pacientes):
    # Obtém todos os IDs disponíveis da tabela de logradouros
    cursor.execute("SELECT id_logradouro FROM t_rhstu_logradouro")
    logradouro_ids = [row[0] for row in cursor.fetchall()]

    for i in range(1, num_pacientes + 1):
        # Certifique-se de que há IDs de logradouro disponíveis
        if not logradouro_ids:
            break

        # Seleciona aleatoriamente um ID de logradouro
        endereco_id = random.choice(logradouro_ids)
        logradouro_ids.remove(endereco_id)

        paciente_id = i

        # Insere a associação do paciente ao endereço
        cursor.execute("INSERT INTO t_rhstu_endereco (id_paciente, id_logradouro, dt_cadastro, nm_usuario) VALUES (:1, :2, TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'Admin')",
                        (paciente_id, endereco_id))
    
# Associe pacientes a endereços únicos
associar_pacientes_a_enderecos(400000)

# Função para cadastrar tipos de contato
def cadastrar_tipos_contato():
    tipos_contato = [
        (1, 'Pai'),
        (2, 'Mãe'),
        (3, 'Esposa'),
        (4, 'Primo'),
        (5, 'Prima'),
        (6, 'Outros contatos')
    ]

    for tipo in tipos_contato:
        cursor.execute("INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_cadastro, nm_usuario) VALUES (:1, :2, TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'Admin')",
                       tipo)

# Cadastre tipos de contato
cadastrar_tipos_contato()

# Função para associar pacientes a contatos
def associar_pacientes_a_contatos(num_pacientes):
    # Obtém todos os IDs de tipos de contato disponíveis
    cursor.execute("SELECT id_tipo_contato FROM t_rhstu_tipo_contato")
    tipos_contato_ids = [row[0] for row in cursor.fetchall()]

    for i in range(1, num_pacientes + 1):
        # Certifique-se de que há IDs de tipos de contato disponíveis
        if not tipos_contato_ids:
            break

        paciente_id = i

        # Seleciona aleatoriamente um ID de tipo de contato
        tipo_contato_id = random.choice(tipos_contato_ids)
        tipos_contato_ids.remove(tipo_contato_id)

        # Insere a associação do paciente ao contato
        cursor.execute("INSERT INTO t_rhstu_contato (id_paciente, id_tipo_contato, dt_cadastro, nm_usuario) VALUES (:1, :2, TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'Admin')",
                        (paciente_id, tipo_contato_id))

# Cadastre tipos de contato
cadastrar_tipos_contato()
cursor.execute('SELECT COUNT(*) FROM t_rhstu_contato')

# Feche o cursor e a conexão
cursor.close()
conn.close()
