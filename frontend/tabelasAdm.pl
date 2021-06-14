tabelas_adm(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            \tabela_usuarios,
            \tabela_viajantes,
            \tabela_locais,
            \tabela_veiculos,
            \tabela_motoristas,
            \tabela_viagens,
            \tabela_alocacao,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).