edita_usuario_adm(Id,_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Cadatrar Usuario')],
        [h1([class='row mx-3 p'],'Cadatrar Usuario'), p([],[]),
            form([action='/editarUsuario', method='POST'],[
                div([class='col'],[div([class='form-floating mb-3'],
                    [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=Id,readonly,name=id]),
                    label([for=id],'Id') ]) ]),
                \cadastro_form
            ])
        ]).