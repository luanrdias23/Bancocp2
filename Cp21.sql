

--
-- Criar sequence para o funcionario
--
DROP SEQUENCE SQ_RHSTU_FUNC;

DROP TABLE t_rhstu_bairro CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_cidade CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_consulta CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_consulta_forma_pagto CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_contato_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_email_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_endereco_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_endereco_unidhosp CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_estado CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_forma_pagamento CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_logradouro CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_medicamento CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_medico CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_motorista CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_paciente_plano_saude CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_plano_saude CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_prescricao_medica CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_telefone_paciente CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_tipo_contato CASCADE CONSTRAINTS;

DROP TABLE t_rhstu_unid_hospitalar CASCADE CONSTRAINTS;

CREATE SEQUENCE SQ_RHSTU_FUNC START WITH 1;
-- Criando a tabela de Estados
CREATE TABLE t_rhstu_estado (
    ID_ESTADO NUMBER(2) NOT NULL,
    SG_ESTADO CHAR(2) NOT NULL,
    NM_ESTADO VARCHAR2(30) NOT NULL,
    DT_CADASTRO DATE  NOT NULL,
    NM_USUARIO VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_estado ADD CONSTRAINT pk_rhstu_estado PRIMARY KEY ( id_estado );
-- Crie a tabela de Cidades
CREATE TABLE t_rhstu_cidade (
    id_cidade    NUMBER(8) NOT NULL,
    id_estado    NUMBER(2) NOT NULL,
    nm_cidade    VARCHAR2(29) NOT NULL,
    cd_ibge      NUMBER(8) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(29) NOT NULL
);


ALTER TABLE t_rhstu_cidade ADD CONSTRAINT pk_rhstu_cidade PRIMARY KEY ( id_cidade );
-- Crie a tabela de Bairros
CREATE TABLE t_rhstu_bairro (
    id_bairro       NUMBER(8) NOT NULL,
    id_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45) NOT NULL,
    nm_zona_bairro  VARCHAR2(20) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);
ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT uk_t_pkd_bairro_zona CHECK ( nm_zona_bairro IN (
        'CENTRO',
        'ZONA LESTE',
        'ZONA NORTE',
        'ZONA OESTE',
        'ZONA SUL'
        
    ) );


ALTER TABLE t_rhstu_bairro ADD CONSTRAINT pk_rhstu_bairro PRIMARY KEY ( id_bairro );
-- Crie a tabela de Louugradouro
CREATE TABLE t_rhstu_logradouro (
    id_logradouro   NUMBER(10) NOT NULL,
    id_bairro       NUMBER(8) NOT NULL,
    nm_logradouro   VARCHAR2(100)NOT NULL,
    nr_cep          NUMBER(8) NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);
ALTER TABLE t_rhstu_logradouro ADD CONSTRAINT pk_rhstu_logradouro PRIMARY KEY ( id_logradouro );
CREATE TABLE t_rhstu_consulta (
    id_unid_hospital  NUMBER(9) NOT NULL,
    id_consulta       NUMBER(10) NOT NULL,
    id_paciente       NUMBER(9) NOT NULL,
    id_func           NUMBER(10) NOT NULL,
    dt_hr_consulta    DATE NOT NULL,
    nr_consultorio    NUMBER(5) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);


ALTER TABLE t_rhstu_consulta ADD CONSTRAINT pk_rhstu_consulta PRIMARY KEY ( id_consulta,
                                                                            id_unid_hospital );

CREATE TABLE t_rhstu_consulta_forma_pagto (
    id_consulta_forma_pagto  NUMBER(10) NOT NULL,
    id_unid_hospital         NUMBER(9) NOT NULL,
    id_consulta              NUMBER(10) NOT NULL,
    id_paciente_ps           NUMBER(10) NOT NULL,
    id_forma_pagto           NUMBER(9) NOT NULL,
    dt_pagto_consulta        DATE,
    st_pagto_consulta        CHAR(1) NOT NULL,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT uk_rhstu_status_pagto_paci CHECK ( st_pagto_consulta IN (
        'A',
        'C',
        'P'
    ) );



ALTER TABLE t_rhstu_consulta_forma_pagto ADD CONSTRAINT pk_rhstu_consulta_forma_pagto PRIMARY KEY ( id_consulta_forma_pagto );

CREATE TABLE t_rhstu_contato_paciente (
    id_paciente      NUMBER(9) NOT NULL,
    id_contato       NUMBER(9) NOT NULL,
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_contato       VARCHAR2(40) NOT NULL,
    nr_ddi           NUMBER(3),
    nr_ddd           NUMBER(3),
    nr_telefone      NUMBER(10),
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);



ALTER TABLE t_rhstu_contato_paciente ADD CONSTRAINT pk_rhstu_contato_emerg_pac PRIMARY KEY ( id_contato,
                                                                                             id_paciente );

CREATE TABLE t_rhstu_email_paciente (
    id_email     NUMBER(9) NOT NULL,
    id_paciente  NUMBER(9) NOT NULL,
    ds_email     VARCHAR2(100) NOT NULL,
    tp_email     VARCHAR2(20) NOT NULL,
    st_email     CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT uk_rhstu_paciente_st_email CHECK ( st_email IN (
        'A',
        'I'
    ) );



ALTER TABLE t_rhstu_email_paciente ADD CONSTRAINT pk_rhstu_email_paciente PRIMARY KEY ( id_email );

CREATE TABLE t_rhstu_endereco_paciente (
    id_endereco            NUMBER(9) NOT NULL,
    id_paciente            NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

-- Alterações na tabela t_rhstu_endereco_paciente


ALTER TABLE t_rhstu_endereco_paciente ADD CONSTRAINT pk_rhstu_endereco_paciente PRIMARY KEY ( id_endereco );

CREATE TABLE t_rhstu_endereco_unidhosp (
    id_end_unidhosp        NUMBER(9) NOT NULL,
    id_unid_hospital       NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);


ALTER TABLE t_rhstu_endereco_unidhosp ADD CONSTRAINT pk_rhstu_endereco_pacientev1 PRIMARY KEY ( id_end_unidhosp );
CREATE TABLE t_rhstu_forma_pagamento (
    id_forma_pagto  NUMBER(9) NOT NULL,
    nm_forma_pagto  VARCHAR2(60) NOT NULL,
    ds_forma_pagto  VARCHAR2(500),
    st_forma_pagto  CHAR(1) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_forma_pagamento
    ADD CONSTRAINT uk_rhstu_status_pagto CHECK ( st_forma_pagto IN (
        'A',
        'C',
        'P'
    ) );



ALTER TABLE t_rhstu_forma_pagamento ADD CONSTRAINT pk_rhstu_forma_pagto PRIMARY KEY ( id_forma_pagto );
-- Definir as formas de pagamento usando UPDATE
UPDATE t_rhstu_forma_pagamento
SET 
    nm_forma_pagto = 'Gratuito',
    ds_forma_pagto = 'Descrição Gratuito',
    st_forma_pagto = 'A',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 1;

UPDATE t_rhstu_forma_pagamento
SET
    nm_forma_pagto = 'Plano de saúde',
    ds_forma_pagto = 'Descrição Plano de saúde',
    st_forma_pagto = 'A',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 2;


UPDATE t_rhstu_forma_pagamento
SET
    nm_forma_pagto = 'Dinheiro',
    ds_forma_pagto = 'Descrição Dinheiro',
    st_forma_pagto = 'C',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 3;

UPDATE t_rhstu_forma_pagamento
SET
    nm_forma_pagto = 'Cartão de Crédito',
    ds_forma_pagto = 'Descrição Cartão de Crédito',
    st_forma_pagto = 'C',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 4;

UPDATE t_rhstu_forma_pagamento
SET
    nm_forma_pagto = 'Cartão de Débito',
    ds_forma_pagto = 'Descrição Cartão de Débito',
    st_forma_pagto = 'C',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 5;

UPDATE t_rhstu_forma_pagamento
SET
    nm_forma_pagto = 'Pix',
    ds_forma_pagto = 'Descrição Pix',
    st_forma_pagto = 'C',
    dt_cadastro = SYSDATE,
    nm_usuario = 'Admin'
WHERE id_forma_pagto = 6;

CREATE TABLE t_rhstu_funcionario (
    id_func        NUMBER(10) NOT NULL,
    id_superior    NUMBER(10),
    nm_func        VARCHAR2(90) NOT NULL,
    ds_cargo       VARCHAR2(77) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    vl_salario     NUMBER(10, 2),
    nr_rg          VARCHAR2(12) NOT NULL,
    nr_cpf         NUMBER(12) NOT NULL,
    st_func        VARCHAR2(50) DEFAULT 'A' NOT NULL,
    dt_cadastro    DATE NOT NULL,
    nm_usuario     VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_funcionario
    ADD CHECK ( st_func IN (
        'A',
        'I'
    ) );


ALTER TABLE t_rhstu_funcionario ADD CONSTRAINT pk_rhstu_func PRIMARY KEY ( id_func );
CREATE TABLE t_rhstu_medicamento (
    id_medicamento            NUMBER(9) NOT NULL,
    nm_medicamento            VARCHAR2(50) NOT NULL,
    ds_detalhada_medicamento  VARCHAR2(4000),
    nr_codigo_barras          NUMBER NOT NULL,
    dt_cadastro               DATE NOT NULL,
    nm_usuario                VARCHAR2(30) NOT NULL
);



ALTER TABLE t_rhstu_medicamento ADD CONSTRAINT pk_rhstu_medicamento PRIMARY KEY ( id_medicamento );

CREATE TABLE t_rhstu_medico (
    id_func           NUMBER(10) NOT NULL,
    nr_crm            NUMBER(10) NOT NULL,
    ds_especialidade  VARCHAR2(50) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_medico.nr_crm IS
    'Esse atributo ir? receber o n?mero do CRM do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_medico.ds_especialidade IS
    'Esse atributo ir? receber a especialidade do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_medico.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_medico.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_medico ADD CONSTRAINT pk_rhstu_medico PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_motorista (
    id_func           NUMBER(10) NOT NULL,
    nr_cnh            NUMBER(14) NOT NULL,
    nm_categoria_cnh  VARCHAR2(70) NOT NULL,
    dt_validade_cnh   DATE NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_motorista.nr_cnh IS
    'Esse atributo ir? receber o n?mero da CNH  do motorista. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_validade_cnh IS
    'Esse atributo ir? receber a especialidade do m?dico. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_motorista.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_motorista ADD CONSTRAINT pk_rhstu_motorista PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_paciente (
    id_paciente         NUMBER(9) ,
    nm_paciente         VARCHAR2(80) ,
    nr_cpf              NUMBER(12) ,
    nm_rg               VARCHAR2(20),
    dt_nascimento       DATE ,
    fl_sexo_biologico   CHAR(1) NOT NULL,
    ds_escolaridade     VARCHAR2(40) NOT NULL,
    ds_estado_civil     VARCHAR2(25) NOT NULL,
    nm_grupo_sanguineo  VARCHAR2(6) NOT NULL,
    nr_altura           NUMBER(5, 2) DEFAULT 0.1 NOT NULL,
    nr_peso             NUMBER(5, 1) NOT NULL,
    dt_cadastro         DATE NOT NULL,
    nm_usuario          VARCHAR2(30) NOT NULL
);


ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_sexobio CHECK ( fl_sexo_biologico IN (
        'F',
        'I',
        'M'
    ) );




ALTER TABLE t_rhstu_paciente ADD CONSTRAINT pk_rhstu_paciente PRIMARY KEY ( id_paciente );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_cpf_paciente UNIQUE ( nr_cpf );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_rg_paciente UNIQUE ( nm_rg );

CREATE TABLE t_rhstu_paciente_plano_saude (
    id_paciente_ps  NUMBER(10) NOT NULL,
    id_paciente     NUMBER(9) NOT NULL,
    id_plano_saude  NUMBER(5) NOT NULL,
    nr_carteira_ps  NUMBER(15),
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente_ps IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente IS
    'Esse atributo ir? receber a chave prim?ria do paciente. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_plano_saude IS
    'Esse atributo ir? receber a chave prim?ria do plano de sa?de. Esse n?mero ? sequencial e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nr_carteira_ps IS
    'ESSE ATRIBUTO RECEBER? O NUMERO DA CARTEIRA DE CADA PACIENTE DO PLANO DE SA?DE';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_inicio IS
    'Esse atributo ir? receber a data de in?cio para atendimento do plano de sa?de do cliente aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_fim IS
    'Esse atributo ir? receber a data de encerramento do plano de sa?de aceito na RHSTU. Seu conte?do ? opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_cadastro IS
    'esse atributo receber? informa??es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nm_usuario IS
    'esse atributo receber? informa??es sobre o nome do usu?rio que realizou o cadastro na tabela, sendo obrigat?rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_paciente_plano_saude ADD CONSTRAINT pk_rhstu_pac_plano_saude PRIMARY KEY ( id_paciente_ps );

CREATE TABLE t_rhstu_plano_saude (
    id_plano_saude           NUMBER(5) NOT NULL,
    ds_razao_social          VARCHAR2(70) NOT NULL,
    nm_fantasia_plano_saude  VARCHAR2(80),
    ds_plano_saude           VARCHAR2(100) NOT NULL,
    nr_cnpj                  NUMBER(14) NOT NULL,
    nm_contato               VARCHAR2(30),
    ds_telefone              VARCHAR2(30),
    dt_inicio                DATE NOT NULL,
    dt_fim                   DATE,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);


ALTER TABLE t_rhstu_plano_saude ADD CONSTRAINT pk_rhstu_plano_saude PRIMARY KEY ( id_plano_saude );

CREATE TABLE t_rhstu_prescricao_medica (
    id_prescricao_medica  NUMBER(10) NOT NULL,
    id_unid_hospital      NUMBER(9) NOT NULL,
    id_consulta           NUMBER(10) NOT NULL,
    id_medicamento        NUMBER(9) NOT NULL,
    ds_posologia          VARCHAR2(150) NOT NULL,
    ds_via                VARCHAR2(40) NOT NULL,
    ds_observacao_uso     VARCHAR2(100),
    qt_medicamento        NUMBER(10, 4),
    nm_usuario            VARCHAR2(30) NOT NULL,
    dt_cadastro           DATE NOT NULL
);



ALTER TABLE t_rhstu_prescricao_medica ADD CONSTRAINT pk_rhstu_prescricao_medica PRIMARY KEY ( id_prescricao_medica );

CREATE TABLE t_rhstu_telefone_paciente (
    id_paciente  NUMBER(9) NOT NULL,
    id_telefone  NUMBER(9) NOT NULL,
    nr_ddi       NUMBER(3) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    nr_telefone  NUMBER(10) NOT NULL,
    tp_telefone  VARCHAR2(20) DEFAULT 'CELULAR' NOT NULL,
    st_telefone  CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_telefone_paciente
    ADD CHECK ( tp_telefone IN (
        'CELULAR',
        'COMERCIAL',
        'CONTATO OU RECADO',
        'RESIDENCIAL'
    ) );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT ck_rhstu_st_tel_pac CHECK ( st_telefone IN (
        'A',
        'I'
    ) );



ALTER TABLE t_rhstu_telefone_paciente ADD CONSTRAINT pk_rhstu_telefone_paciente PRIMARY KEY ( id_telefone,
                                                                                              id_paciente );

CREATE TABLE t_rhstu_tipo_contato (
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_tipo_contato  VARCHAR2(80) NOT NULL,
    dt_inicio        DATE NOT NULL,
    dt_fim           DATE,
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);



ALTER TABLE t_rhstu_tipo_contato ADD CONSTRAINT pk_rhstu_tipo_contato PRIMARY KEY ( id_tipo_contato );

CREATE TABLE t_rhstu_unid_hospitalar (
    id_unid_hospital           NUMBER(9) NOT NULL,
    nm_unid_hospitalar         VARCHAR2(80) NOT NULL,
    nm_razao_social_unid_hosp  VARCHAR2(80) NOT NULL,
    dt_fundacao                DATE,
    nr_logradouro              NUMBER(7),
    ds_complemento_numero      VARCHAR2(30),
    ds_ponto_referencia        VARCHAR2(50),
    dt_inicio                  DATE NOT NULL,
    dt_termino                 DATE,
    dt_cadastro                DATE NOT NULL,
    nm_usuario                 VARCHAR2(30) NOT NULL
);


ALTER TABLE t_rhstu_unid_hospitalar ADD CONSTRAINT pk_rhstu_uni_hosp_end PRIMARY KEY ( id_unid_hospital );

ALTER TABLE t_rhstu_logradouro
    ADD CONSTRAINT fk_rhstu_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_rhstu_bairro ( id_bairro );

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT fk_rhstu_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_rhstu_cidade ( id_cidade );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_consulta_forma_pagto FOREIGN KEY ( id_consulta,
                                                               id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_consulta_presc_medica FOREIGN KEY ( id_consulta,
                                                                id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_cidade
    ADD CONSTRAINT fk_rhstu_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_rhstu_estado ( id_estado );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_forma_pagto_consult FOREIGN KEY ( id_forma_pagto )
        REFERENCES t_rhstu_forma_pagamento ( id_forma_pagto );

ALTER TABLE t_rhstu_medico
    ADD CONSTRAINT fk_rhstu_func_medico FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_motorista
    ADD CONSTRAINT fk_rhstu_func_motorista FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_funcionario
    ADD CONSTRAINT fk_rhstu_func_superior FOREIGN KEY ( id_superior )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_logr_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_logr_unidhosp_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_med_consulta FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_medicamento_pm FOREIGN KEY ( id_medicamento )
        REFERENCES t_rhstu_medicamento ( id_medicamento );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_pac_consulta FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_pac_cont FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_pac_plano_pagto FOREIGN KEY ( id_paciente_ps )
        REFERENCES t_rhstu_paciente_plano_saude ( id_paciente_ps );

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT fk_rhstu_paciente_email FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_paciente_endereco FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_paciente_plano FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT fk_rhstu_paciente_telefone FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_plano_saude_pac FOREIGN KEY ( id_plano_saude )
        REFERENCES t_rhstu_plano_saude ( id_plano_saude );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_tipo_contato FOREIGN KEY ( id_tipo_contato )
        REFERENCES t_rhstu_tipo_contato ( id_tipo_contato );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_unid_hosp_consulta FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_unidhosp_end FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

CREATE OR REPLACE TRIGGER arc_trg_general_t_rhstu_medico BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_medico
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_trg_gene_t_rhstu_motorista BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_motorista
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

-- Inserindo os estados
INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (1, 'AC', 'Acre', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (2, 'AL', 'Alagoas', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (3, 'AP', 'Amap�', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (4, 'AM', 'Amazonas', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (5, 'BA', 'Bahia', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (6, 'CE', 'Cear�', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (7, 'ES', 'Esp�rito Santo', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (8, 'GO', 'Goi�s', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (9, 'MA', 'Maranh�o', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (10, 'MT', 'Mato Grosso', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (11, 'MS', 'Mato Grosso do Sul', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (12, 'MG', 'Minas Gerais', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (13, 'PA', 'Par�', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (14, 'PB', 'Para�ba', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (15, 'PR', 'Paran�', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (16, 'PE', 'Pernambuco', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (17, 'PI', 'Piau�', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (18, 'RJ', 'Rio de Janeiro', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (19, 'RN', 'Rio Grande do Norte', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (20, 'RS', 'Rio Grande do Sul', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (21, 'RO', 'Rond�nia', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (22, 'RR', 'Roraima', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (23, 'SC', 'Santa Catarina', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (24, 'SP', 'S�o Paulo', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (25, 'SE', 'Sergipe', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (26, 'TO', 'Tocantins', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_estado (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
VALUES (27, 'DF', 'Distrito Federal', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Inserindo as 10 cidades para o estado do Acre (Estado com ID 1)
-- Estado 1: Acre
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (1, 1, 'Rio Branco', 1200401, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (2, 1, 'Cruzeiro do Sul', 1200203, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (3, 1, 'Sena Madureira', 1200454, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (4, 1, 'Tarauac�', 1200603, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (5, 1, 'Feij�', 1200306, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (6, 1, 'Porto Acre', 1200802, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (7, 1, 'Pl�cido de Castro', 1200389, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (8, 1, 'Xapuri', 1200802, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (9, 1, 'Marechal Thaumaturgo', 1200306, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (10, 1, 'Brasil�ia', 1200389, 68, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 2: Alagoas
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (11, 2, 'Macei�', 2704302, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (12, 2, 'Arapiraca', 2700409, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (13, 2, 'Penedo', 2706703, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (14, 2, 'Palmeira dos �ndios', 2706307, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (15, 2, 'Rio Largo', 2707404, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (16, 2, 'Delmiro Gouveia', 2702405, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (17, 2, 'Campo Alegre', 2701407, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (18, 2, 'Santana do Ipanema', 2708907, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (19, 2, 'Uni�o dos Palmares', 2709301, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (20, 2, 'Maragogi', 2704906, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 3: Amap�
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (21, 3, 'Macap�', 1600303, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (22, 3, 'Santana', 1600600, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (23, 3, 'Mazag�o', 1600402, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (24, 3, 'Oiapoque', 1600501, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (25, 3, 'Laranjal do Jari', 1600279, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (26, 3, 'Cal�oene', 1600204, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (27, 3, 'Cutias', 1600212, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (28, 3, 'Pedra Branca do Amapari', 1600154, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (29, 3, 'Serra do Navio', 1600700, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (30, 3, 'Amap�', 1600105, 96, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 4: Amazonas
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (31, 4, 'Manaus', 1302603, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (32, 4, 'Manacapuru', 1302504, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (33, 4, 'Parintins', 1303403, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (34, 4, 'Itacoatiara', 1301902, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (35, 4, 'Iranduba', 1301803, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (36, 4, 'Tef�', 1304203, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (37, 4, 'Coari', 1301209, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (38, 4, 'Tabatinga', 1304062, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (39, 4, 'Manicor�', 1302504, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (40, 4, 'Humait�', 1301704, 92, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 5: Bahia
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (41, 5, 'Salvador', 2927408, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (42, 5, 'Feira de Santana', 2910800, 75, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (43, 5, 'Vit�ria da Conquista', 2932605, 77, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (44, 5, 'Cama�ari', 2904706, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (45, 5, 'Itabuna', 2914602, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (46, 5, 'Juazeiro', 2911103, 74, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (47, 5, 'Lauro de Freitas', 2919206, 71, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (48, 5, 'Ilh�us', 2910700, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (49, 5, 'Serrinha', 2930501, 75, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (50, 5, 'Porto Seguro', 2925304, 73, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 6: Cear�
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (51, 6, 'Fortaleza', 2304400, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (52, 6, 'Caucaia', 2303709, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (53, 6, 'Juazeiro do Norte', 2307304, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (54, 6, 'Maracana�', 2307650, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (55, 6, 'Sobral', 2312907, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (56, 6, 'Crato', 2304103, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (57, 6, 'Itapipoca', 2306406, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (58, 6, 'Maranguape', 2307650, 85, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (59, 6, 'Quixad�', 2311305, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (60, 6, 'Iguatu', 2305507, 88, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 7: Esp�rito Santo
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (61, 7, 'Vit�ria', 3205309, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (62, 7, 'Vila Velha', 3205200, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (63, 7, 'Cariacica', 3201307, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (64, 7, 'Serra', 3205001, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (65, 7, 'Linhares', 3203204, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (66, 7, 'Cachoeiro de Itapemirim', 3201208, 28, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (67, 7, 'Guarapari', 3202404, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (68, 7, 'Colatina', 3201503, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (69, 7, 'Aracruz', 3200604, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (70, 7, 'Nova Ven�cia', 3203905, 27, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 8: Goi�s
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (71, 8, 'Goi�nia', 5208707, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (72, 8, 'Aparecida de Goi�nia', 5201405, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (73, 8, 'An�polis', 5201108, 62, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (74, 8, 'Luzi�nia', 5212502, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (75, 8, '�guas Lindas de Goi�s', 5200259, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (76, 8, 'Valpara�so de Goi�s', 5221859, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (77, 8, 'Formosa', 5208006, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (78, 8, 'Caldas Novas', 5204906, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (79, 8, 'Itumbiara', 5209905, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (80, 8, 'Jata�', 5211901, 64, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 9: Maranh�o
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (81, 9, 'S�o Lu�s', 2111300, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (82, 9, 'Imperatriz', 2105302, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (83, 9, 'S�o Jos� de Ribamar', 2111250, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (84, 9, 'Timon', 2112233, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (85, 9, 'Caxias', 2103000, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (86, 9, 'Cod�', 2103307, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (87, 9, 'Pa�o do Lumiar', 2107606, 98, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (88, 9, 'A�ail�ndia', 2100055, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (89, 9, 'Bacabal', 2101202, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (90, 9, 'Balsas', 2101608, 99, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 10: Mato Grosso
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (91, 10, 'Cuiab�', 5103403, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (92, 10, 'V�rzea Grande', 5108402, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (93, 10, 'Rondon�polis', 5107602, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (94, 10, 'Sinop', 5107909, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (95, 10, 'Tangar� da Serra', 5107925, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (96, 10, 'Primavera do Leste', 5107040, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (97, 10, 'Barra do Gar�as', 5101704, 66, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (98, 10, 'Nova Mutum', 5106209, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (99, 10, 'Pontes e Lacerda', 5106753, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (100, 10, 'Campo Verde', 5102703, 65, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 11: Mato Grosso do Sul
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (101, 11, 'Campo Grande', 5002704, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (102, 11, 'Dourados', 5003702, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (103, 11, 'Tr�s Lagoas', 5008305, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (104, 11, 'Corumb�', 5003306, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (105, 11, 'Ponta Por�', 5006606, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (106, 11, 'Navira�', 5005707, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (107, 11, 'Amambai', 5001102, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (108, 11, 'Rio Brilhante', 5007208, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (109, 11, 'Nova Andradina', 5006200, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (110, 11, 'Coxim', 5003206, 67, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (111, 12, 'Belo Horizonte', 3106200, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (112, 12, 'Uberl�ndia', 3170206, 34, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (113, 12, 'Contagem', 3118601, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (114, 12, 'Juiz de Fora', 3136703, 32, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (115, 12, 'Betim', 3106705, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (116, 12, 'Montes Claros', 3143303, 38, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (117, 12, 'Ribeir�o das Neves', 3154805, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (118, 12, 'Uberaba', 3170107, 34, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (119, 12, 'Governador Valadares', 3127702, 33, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (120, 12, 'Ipatinga', 3131301, 31, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 13: Par�
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (121, 13, 'Bel�m', 1501402, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (122, 13, 'Ananindeua', 1500800, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (123, 13, 'Santar�m', 1506807, 93, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (124, 13, 'Marab�', 1504207, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (125, 13, 'Castanhal', 1502409, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (126, 13, 'Parauapebas', 1505535, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (127, 13, 'Itaituba', 1503605, 93, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (128, 13, 'Tucuru�', 1508308, 94, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (129, 13, 'Bel�m do Par�', 1501436, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (130, 13, 'Ananindeua do Par�', 1500824, 91, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 14: Para�ba
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (131, 14, 'Jo�o Pessoa', 2507507, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (132, 14, 'Campina Grande', 2504008, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (133, 14, 'Santa Rita', 2513703, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (134, 14, 'Patos', 2510808, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (135, 14, 'Bayeux', 2501805, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (136, 14, 'Cabedelo', 2503207, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (137, 14, 'Santa Luzia', 2513505, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (138, 14, 'Guarabira', 2506308, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (139, 14, 'Sousa', 2515939, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (140, 14, 'Cajazeiras', 2503909, 83, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Estado 15: Paran�
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (141, 15, 'Curitiba', 4106902, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (142, 15, 'Londrina', 4113709, 43, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (143, 15, 'Maring�', 4115209, 44, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (144, 15, 'Ponta Grossa', 4119904, 42, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (145, 15, 'Cascavel', 4104807, 45, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (146, 15, 'S�o Jos� dos Pinhais', 4125506, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (147, 15, 'Foz do Igua�u', 4108304, 45, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (148, 15, 'Colombo', 4105805, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (149, 15, 'Piraquara', 4119607, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (150, 15, 'Paranagu�', 4118105, 41, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 16: Pernambuco
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (151, 16, 'Recife', 2611606, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (152, 16, 'Jaboat�o dos Guararapes', 2607901, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (153, 16, 'Olinda', 2609600, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (154, 16, 'Caruaru', 2604106, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (155, 16, 'Petrolina', 2611101, 87, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (156, 16, 'Paulista', 2610608, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (157, 16, 'Cabo de Santo Agostinho', 2602907, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (158, 16, 'Camaragibe', 2604002, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (159, 16, 'S�o Louren�o da Mata', 2613708, 81, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (160, 16, 'Garanhuns', 2606007, 87, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 17: Piau�
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (161, 17, 'Teresina', 2211001, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (162, 17, 'Parna�ba', 2207701, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (163, 17, 'Picos', 2208006, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (164, 17, 'Campo Maior', 2201902, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (165, 17, 'Floriano', 2203908, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (166, 17, 'Barras', 2201175, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (167, 17, 'Jos� de Freitas', 2205359, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (168, 17, 'Piripiri', 2208502, 86, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (169, 17, 'Oeiras', 2207009, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (170, 17, 'Campo Alegre do Fidalgo', 2201902, 89, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 19: Rio de Janeiro
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (171, 19, 'Rio de Janeiro', 3304557, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (172, 19, 'S�o Gon�alo', 3304904, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (173, 19, 'Duque de Caxias', 3301701, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (174, 19, 'Nova Igua�u', 3303509, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (175, 19, 'Niter�i', 3303301, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (176, 19, 'Belford Roxo', 3300455, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (177, 19, 'Campos dos Goytacazes', 3301008, 22, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (178, 19, 'S�o Jo�o de Meriti', 3305157, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (179, 19, 'Bangu', 3300800, 21, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (180, 19, 'Nova Friburgo', 3303400, 22, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 20: Rio Grande do Norte
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (181, 20, 'Natal', 2408102, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (182, 20, 'Mossor�', 2408003, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (183, 20, 'Parnamirim', 2403251, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (184, 20, 'Maca�ba', 2407203, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (185, 20, 'Cear�-Mirim', 2402600, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (186, 20, 'Caic�', 2402204, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (187, 20, 'Currais Novos', 2403103, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (188, 20, 'S�o Gon�alo do Amarante', 2412005, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (189, 20, 'Apodi', 2401107, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (190, 20, 'Parelhas', 2408608, 84, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 21: Rio Grande do Sul
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (191, 21, 'Porto Alegre', 4314902, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (192, 21, 'Caxias do Sul', 4305108, 54, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (193, 21, 'Pelotas', 4314407, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (194, 21, 'Canoas', 4304600, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (195, 21, 'Santa Maria', 4316908, 55, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (196, 21, 'Novo Hamburgo', 4313400, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (197, 21, 'S�o Leopoldo', 4318706, 51, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (198, 21, 'Rio Grande', 4315603, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (199, 21, 'Uruguaiana', 4322401, 55, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (200, 21, 'Bag�', 4301606, 53, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 22: Rond�nia
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (201, 22, 'Porto Velho', 1100205, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (202, 22, 'Ji-Paran�', 1100122, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (203, 22, 'Ariquemes', 1100023, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (204, 22, 'Vilhena', 1100304, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (205, 22, 'Cacoal', 1100049, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (206, 22, 'Pimenta Bueno', 1100180, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (207, 22, 'Ouro Preto do Oeste', 1100156, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (208, 22, 'Guajar�-Mirim', 1100107, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (209, 22, 'Jaru', 1100909, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (210, 22, 'Rolim de Moura', 1100288, 69, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 23: Roraima
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (211, 23, 'Boa Vista', 1400100, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (212, 23, 'Caracara�', 1400233, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (213, 23, 'Rorain�polis', 1400472, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (214, 23, 'Mucaja�', 1400308, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (215, 23, 'Cant�', 1400234, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (216, 23, 'Pacaraima', 1400456, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (217, 23, 'Amajari', 1400027, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (218, 23, 'Bonfim', 1400105, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (219, 23, 'Caroebe', 1400257, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (220, 23, 'Iracema', 1400281, 95, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 24: Santa Catarina
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (221, 24, 'Florian�polis', 4205407, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (222, 24, 'Joinville', 4209102, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (223, 24, 'Blumenau', 4202404, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (224, 24, 'Crici�ma', 4204608, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (225, 24, 'Chapec�', 4204202, 49, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (226, 24, 'S�o Jos�', 4216603, 48, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (227, 24, 'Lages', 4209301, 49, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (228, 24, 'Jaragu� do Sul', 4208907, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (229, 24, 'Itaja�', 4208204, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (230, 24, 'Balne�rio Cambori�', 4202008, 47, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 25: S�o Paulo
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (231, 25, 'S�o Paulo', 3550308, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (232, 25, 'Guarulhos', 3518800, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (233, 25, 'Campinas', 3509502, 19, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (234, 25, 'S�o Bernardo do Campo', 3548708, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (235, 25, 'Santo Andr�', 3547809, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (236, 25, 'Osasco', 3534401, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (237, 25, 'Ribeir�o Preto', 3543402, 16, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (238, 25, 'Sorocaba', 3552203, 15, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (239, 25, 'Santos', 3548508, 13, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (240, 25, 'Jundia�', 3525904, 11, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 26: Sergipe
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (241, 26, 'Aracaju', 2800308, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (242, 26, 'Nossa Senhora do Socorro', 2804904, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (243, 26, 'Macei�', 2704302, 82, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (244, 26, 'Lagarto', 2803501, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (245, 26, 'Itabaiana', 2802900, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (246, 26, 'Est�ncia', 2802108, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (247, 26, 'S�o Crist�v�o', 2806704, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (248, 26, 'Nossa Senhora da Gl�ria', 2804902, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (249, 26, 'Tobias Barreto', 2807301, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (250, 26, 'Propri�', 2805602, 79, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 27: Tocantins
-- Cidade 1
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (251, 27, 'Palmas', 1721000, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (252, 27, 'Aragua�na', 1702109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (253, 27, 'Gurupi', 1709302, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (254, 27, 'Para�so do Tocantins', 1716109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (255, 27, 'Porto Nacional', 1718204, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (256, 27, 'Araguatins', 1702109, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (257, 27, 'Colinas do Tocantins', 1705508, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (258, 27, 'Guara�', 1709303, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (259, 27, 'Dian�polis', 1707000, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (260, 27, 'Miracema do Tocantins', 1713209, 63, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Estado 27: Distrito Federal
-- Cidade 2
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (261, 27, 'Taguatinga', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (271, 27, 'Lian�polis', 1607000, 613, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
-- Cidade 3
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (273, 27, 'Ceil�ndia', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 4
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (274, 27, 'Planaltina', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 5
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (275, 27, 'Sobradinho', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 6
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (276, 27, 'Gama', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 7
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (277, 27, 'Parano�', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 8
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (278, 27, 'Santa Maria', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 9
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (279, 27, 'Recanto das Emas', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');

-- Cidade 10
INSERT INTO t_rhstu_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro, nm_usuario)
VALUES (280, 27, 'Samambaia', 5300108, 61, TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'Admin');
 
-- Vamos inserir um funcionario 
--
INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
null,
'Oivlas Sakspildap',
'Presidente',
TO_DATE( '18/05/2000' , 'DD/MM/YYYY'),
65000,
176888772,
82737378312,
'A',
SYSDATE,
USER
);


INSERT INTO T_RHSTU_MEDICO
(
ID_FUNC,
NR_CRM,
DS_ESPECIALIDADE,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.CURRVAL,
234765,
'Neuro Cirugião',
SYSDATE,
USER
);

--
-- Confirma as transações pendentes
--
commit;


-- Diretor Transporte
INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
1,
'Monica Julio',
'Diretora de Transporte',
TO_DATE( '11/11/1995' , 'DD/MM/YYYY'),
33000,
324237689,
023948785,
'A',
SYSDATE,
USER
);

-- Funcionario motorista

INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
2,
'Sanoj Arievilo',
'Motorista de Ambulância',
TO_DATE( '01/01/1940' , 'DD/MM/YYYY'),
15700,
13213213,
77767,
'A',
SYSDATE,
USER
);

 
INSERT INTO T_RHSTU_MOTORISTA
(
ID_FUNC,
NR_CNH,
NM_CATEGORIA_CNH,
DT_VALIDADE_CNH,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.CURRVAL,
'12312312',
'D',
TO_DATE( '01/01/2029' , 'DD/MM/YYYY'),
SYSDATE,
USER
);

COMMIT;



-- Funcionario Alexandre

INSERT INTO T_RHSTU_FUNCIONARIO
(
ID_FUNC,
ID_SUPERIOR,
NM_FUNC,
DS_CARGO,
DT_NASCIMENTO,
VL_SALARIO,
NR_RG,
NR_CPF,
ST_FUNC,
DT_CADASTRO,
NM_USUARIO
)
VALUES
(
SQ_RHSTU_FUNC.NEXTVAL,
1,
'Erdnaxela Said ed Susej',
'Diretor Conselheiro',
TO_DATE( '25/12/1990' , 'DD/MM/YYYY'),
51000,
213124,
2438553,
'A',
SYSDATE,
USER
);




COMMIT;


-- Inserir tipo de contato Pai
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (1, 'Pai', SYSDATE, SYSDATE, 'Admin');

-- Inserir tipo de contato Mãe
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (2, 'Mãe', SYSDATE, SYSDATE, 'Admin');

-- Inserir tipo de contato Esposa
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (3, 'Esposa', SYSDATE, SYSDATE, 'Admin');

-- Inserir tipo de contato Primo
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (4, 'Primo', SYSDATE, SYSDATE, 'Admin');

-- Inserir tipo de contato Prima
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (5, 'Prima', SYSDATE, SYSDATE, 'Admin');

-- Inserir tipo de contato Outros contatos
INSERT INTO t_rhstu_tipo_contato (id_tipo_contato, nm_tipo_contato, dt_inicio, dt_cadastro, nm_usuario)
VALUES (6, 'Outros contatos', SYSDATE, SYSDATE, 'Admin');

INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (1, 'Razão Social 1', 'Fantasia 1', 'Plano de Saúde 1', 12345678900001, 'Contato 1', 'Telefone 1', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (2, 'Razão Social 2', 'Fantasia 2', 'Plano de Saúde 2', 12345678900002, 'Contato 2', 'Telefone 2', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 3
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (3, 'Razão Social 3', 'Fantasia 3', 'Plano de Saúde 3', 12345678900003, 'Contato 3', 'Telefone 3', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 4
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (4, 'Razão Social 4', 'Fantasia 4', 'Plano de Saúde 4', 12345678900004, 'Contato 4', 'Telefone 4', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 5
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (5, 'Razão Social 5', 'Fantasia 5', 'Plano de Saúde 5', 12345678900005, 'Contato 5', 'Telefone 5', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 6
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (6, 'Razão Social 6', 'Fantasia 6', 'Plano de Saúde 6', 12345678900006, 'Contato 6', 'Telefone 6', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 7
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (7, 'Razão Social 7', 'Fantasia 7', 'Plano de Saúde 7', 12345678900007, 'Contato 7', 'Telefone 7', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 8
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (8, 'Razão Social 8', 'Fantasia 8', 'Plano de Saúde 8', 12345678900008, 'Contato 8', 'Telefone 8', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 9
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (9, 'Razão Social 9', 'Fantasia 9', 'Plano de Saúde 9', 12345678900009, 'Contato 9', 'Telefone 9', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');

-- Registro 10
INSERT INTO t_rhstu_plano_saude (id_plano_saude, ds_razao_social, nm_fantasia_plano_saude, ds_plano_saude, nr_cnpj, nm_contato, ds_telefone, dt_inicio, dt_fim, dt_cadastro, nm_usuario)
VALUES (10, 'Razão Social 10', 'Fantasia 10', 'Plano de Saúde 10', 12345678900010, 'Contato 10', 'Telefone 10', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, SYSDATE, 'Admin');


SELECT * FROM t_rhstu_telefone_paciente; 

