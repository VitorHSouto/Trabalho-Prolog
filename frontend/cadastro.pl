:- consult(tabelaCadastros).

cadastro(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Cadatrar Usuario')],
        [h1([class='row mx-3 p'],'Cadatrar Usuario'), p([],[]),
            form([action='/recebeCadastro', method='POST'],
            [
                \cadastro_form
            ]),
            p(['Ja possui uma conta? ',
                    a([ href('/'),
                        class(['primary-link','text-decoration-none'])],'Fazer Login')])
        ]).

cadastro_form -->
    html(   div([],[
            %%% Nome
            div([class='form-floating mb-3'], [
                input([ type=textarea, class='form-control', style='max-width:350px', id='floatingInputGrid',placeholder='name@example.com',name=nome]),
                        label([for='floatingInputGrid'],'Nome') 
            ]),
            %%% Email
            div([class='form-floating mb-3'], [
                input([ type=email, class='form-control', style='max-width:350px', id='floatingInputGrid',placeholder='name@example.com',name=email]),
                        label([for='floatingInputGrid'],'Email') 
            ]),
            %%% Senha
            div([class='form-floating mb-3'], [
                input([type='password', type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',placeholder='**********',name=senha]),
                            label([for='floatingInputGrid'],'Senha') 
            ]),
            %%% Funcao
            div([class='form-floating mb-3'],
                [select([class='form-select',style='max-width:300px',name='funcao', value='user', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='user'], 'Usuario'),
                option([id='floatingSelectGrid', value='admin'], 'Administrador') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Funcao')
            ]),
            div([class='form-floating mb-3'],
                input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                        []))
            ])
        ).

recebe_cadastro(post, Pedido) :-
    http_read_data(Pedido,
                    [nome=AtomNome, email=AtomEmail, senha=Senha, funcao=Funcao, submit='Enviar']
                    , []),
    atom_string(AtomNome, Nome),
    atom_string(AtomEmail, Email),    
    usuario:insere(IdUser,Nome,Email,Senha),
    funcao:insere(IdFunc,Funcao),
    usuario_funcao:insere(_,IdUser,IdFunc),
    login('',_).

editar_user(post, Pedido) :-
    http_read_data(Pedido,
                    [id=AtomId, nome=AtomNome, email=AtomEmail, senha=Senha, funcao=Funcao, submit='Enviar']
                    , []),
    atom_string(AtomNome, Nome),
    atom_string(AtomEmail, Email),    
    atom_number(AtomId, Id),
    usuario_funcao(_, Id, IdFunc, _, _),
    usuario:atualiza(Id,Nome,Email),
    usuario:atualiza_senha(Id,Senha),
    funcao:atualiza(IdFunc,Funcao),
    tabelas_adm(_).