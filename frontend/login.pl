login(Mensage,_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Login')],
        [h1([class='row mx-3 p'],'Login'), p([],[]),
            p([class="text-danger"],Mensage),
            form([action='/recebeLogin', method='POST'],[
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
                            [])),
                p(['Ainda nao possui uma conta? ',
                    a([ href('/cadastro'),
                        class([ 'primary-link','text-decoration-none'])],'Cadastre-se')])
            ])
        ]).

recebe_login(post, Pedido) :-
    http_read_data(Pedido,
                    [email=AtomEmail, senha=Senha, funcao=Funcao, submit='Enviar']
                    , []),
    atom_string(AtomEmail, Email),    
    (usuario:senha_valida(Email,Senha,Id_User), %%% Login CORRETO!
    funcao(Id_User,Funcao,_,_),!,
    ((Funcao=admin,tabelas_adm(_));   % REDIRECIONA ADM
    (Funcao=user,home(_)))      % REDIRECIONA USER
    );
    login('Login Falhou',_).                    %%% Login INCORRETO!