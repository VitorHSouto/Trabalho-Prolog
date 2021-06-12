:- consult(tabelaViajantes).

form1(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 1')],
        [h1([class='row mx-3 p'],'Formulario 1'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar viajantes'), p([],[]),
         form([action='/receptorF1', method='POST'],               
               [  br([],[]),
                  br([],[]),
                  br([],[]), 
                     div([class='row justify-content-center mx-3'],
                       [                     
                       div([class='col-md-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='min-width:200px max-width:450px', id='floatingInputGrid',placeholder='Joao Dos Santos',name=name]),
                             label([for='floatingInputGrid'],'Nome') ]) ]),
                       div([class='col-md-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width:220px', id='floatingInputGrid',placeholder='111-222-333-44',name=cpf]),
                             label([for='floatingInputGrid'],'CPF') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-3'],[div([class='form-floating mb-3'],
                           [ input([type=email, class='form-control', style='max-width:350px', id='floatingInputGrid',placeholder='name@example.com',name=email]),
                             label([for='floatingInputGrid'],'Email') ]) ]),
                       div([class='col-md-3'],[div([class='form-floating mb-3'],
                           [ input([type='password', type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',placeholder='**********',name=senha]),
                             label([for='floatingInputGrid'],'Senha') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                    [div([class='form-floating col-md-3'],
                           [select([class='form-select',style='max-width:300px',name='funcao', value='Tutor', id='floatingSelectGrid'],
                           [option([id='floatingSelectGrid', value='Colaborador'], 'Coloborador Enventual'),
                            option([id='floatingSelectGrid', value='Servidor'], 'Servidor'),
                            option([id='floatingSelectGrid', value='Tutor'], 'Tutor') ]),
                           label([class='mx-2',for="floatingSelectGrid"],'Escolha a funcao') ])
                    ]),
                  br([],[]),
                  div([class='row justify-content-center mx-3'],
                  [
                    p([class='col-md-3'],
                       input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                             [])),
                  
                 p([class='col-md-2'], 
                 [
                    a([class='btn btn-primary', href='/', style='width: 200px'], 'Voltar ao inicio')])
                  ]),
                  br([],[])
                  ])
                  ]).

recebe_form1(post, Pedido) :-
    http_read_data(Pedido,
                    [name=Nome, cpf=Cpf, email=Email, senha=Senha, funcao=Tutor, submit='Enviar']
                    , []),
    viajantes:insere(_,Cpf,Nome,Tutor,Email,Senha,'base'),
    tbl_viajantes(_).

editar_form1(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, name=Nome, cpf=Cpf, email=Email, senha=Senha, funcao=Tutor, submit='Enviar']
                      , []),
      atom_number(AtomId, Id),
      viajantes:atualiza(Id,Cpf,Nome,Tutor,Email,Senha,'base'),
      tbl_viajantes(_).
