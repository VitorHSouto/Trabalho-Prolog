tabelas_adm(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            \tabela_usuarios,
            \tabela_alocacao,
            \tabela_locais,
            \tabela_motoristas,
            \tabela_veiculos,
            \tabela_viagens,
            \tabela_viajantes,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).