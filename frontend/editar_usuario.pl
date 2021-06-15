edita_usuario_adm(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (usuario(Id,Nome,Email,_,_,_) ->
    reply_html_page(
        bootstrap,
        [title('Editar Usuario')],
        [h1([class='row mx-3 p'],'Editar Usuario'), p([],[]),
            form([action='/editarUsuarioAdm', method='POST'],[
                div([class='col'],[div([class='form-floating mb-3'],
                    [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=Id,readonly,name=id]),
                    label([for=id],'Id') ]) ]),
                \cadastro_form(Nome,Email)
            ])
        ])
    ).

confere_usuario(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Editar Usuario')],
        [h1([class='row mx-3 p'],'Digite seus dados'), p([],[]),
            form([action='/confere_usuario', method='POST'],[
                div([],[
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
                    div([class='form-floating mb-3'],
                        input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                                []))
                    ])
            ])
        ]).

recebe_confere_usuario(post, Pedido) :-
    http_read_data(Pedido,
                    [email=AtomEmail, senha=Senha, submit='Enviar']
                    , []),
    atom_string(AtomEmail, Email),    
    (usuario:senha_valida(Email,Senha,Id_User), %%% Login CORRETO!
    funcao(Id_User,user,_,_),!,
    atom_number(Atom_Id_User,Id_User),
    edita_usuario_user(Atom_Id_User,_));
    home(_). 

edita_usuario_user(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (usuario(Id,Nome,Email,_,_,_) ->
    reply_html_page(
        bootstrap,
        [title('Editar Usuario')],
        [h1([class='row mx-3 p'],'Editar Usuario'), p([],[]),
            form([action='/editarUsuario', method='POST'],[
                div([],[
                    div([class='form-floating mb-3 d-none'],
                    [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=Id,readonly,name=id]),
                    label([for=id],'Id') ]),
                    %%% Nome
                    div([class='form-floating mb-3'], [
                        input([ type=textarea, class='form-control', style='max-width:350px', value=Nome, id='floatingInputGrid',placeholder='Joao',name=nome]),
                                label([for='floatingInputGrid'],'Nome') 
                    ]),
                    %%% Email
                    div([class='form-floating mb-3'], [
                        input([ type=email, class='form-control', style='max-width:350px', value=Email, id='floatingInputGrid',placeholder='name@example.com',name=email]),
                                label([for='floatingInputGrid'],'Email') 
                    ]),
                    %%% Senha
                    div([class='form-floating mb-3'], [
                        input([type='password', type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',placeholder='**********',name=senha]),
                                    label([for='floatingInputGrid'],'Nova senha') 
                    ]),
                    div([class='form-floating mb-3'],
                        input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                                []))
                    ])
            ])
        ])
    ).

usuario_infos(Id,Nome,Email) -->
    {
        usuario(Id,Nome,Email,_,_,_)
    },
    html(p([],[])).