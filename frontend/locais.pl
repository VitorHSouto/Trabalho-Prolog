:- consult(tabelaLocais).

form2(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 2')],
        [h1([class='row mx-3 p'],'Formulario 2'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar locais'), p([],[]),
         form([action='/receptorF2', method='POST'],
               [ div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='Sao Paulo',name=city]),
                             label([for='floatingInputGrid'],'Cidade') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',placeholder='12345-678',name=cep]),
                             label([for='floatingInputGrid'],'CEP') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 400px', id='floatingInputGrid',placeholder='Rua x',name=address]),
                             label([for='floatingInputGrid'],'Endereco') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                    [
                    div([class='col-md-2'],
                       input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                             [])),
                    div([class='col-md-2'], [a([class='btn btn-primary', href='/administrador', style='width: 150px'], 'Voltar as Tabelas')])
                    ]),
                  br([],[])
               ])
            ]).

recebe_form2(post, Pedido) :-
      http_read_data(Pedido,
                      [city=Cidade, cep=Cep, address=End, submit='Enviar']
                      , []),
      locais:insere(_,Cidade,Cep,End),
      tbl_locais(_).

editar_form2(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, city=Cidade, cep=Cep, address=End, submit='Enviar']
                      , []),
      atom_number(AtomId, Id),
      locais:atualiza(Id,Cidade,Cep,End),
      tbl_locais(_).
