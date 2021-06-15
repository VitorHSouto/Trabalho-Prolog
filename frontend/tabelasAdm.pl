tabelas_adm(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [   
            \navbar_adm('navbar'),
            br([],[]),
            \titulo_da_tabela('Usuarios'),
            \tabela_usuarios,
            \titulo_da_tabela('Viajantes'),
            \tabela_viajantes,
            \titulo_da_tabela('Locais'),
            \tabela_locais,
            \titulo_da_tabela('Veiculos'),
            \tabela_veiculos,
            \titulo_da_tabela('Motoristas'),
            \tabela_motoristas,
            \titulo_da_tabela('Viagens'),
            \tabela_viagens,
            \titulo_da_tabela('Alocacao de Veiculo'),
            \tabela_alocacao,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ]),
            br([],[])
        ]).