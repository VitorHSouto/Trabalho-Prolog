/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

home(_Pedido) :-
    reply_html_page(
        bootstrap,
        [ title('Gestao de Viagens')],
        [h1([class='row mx-3'],'Proposta de desenvolvimento de software para gestao de viagens da DEAD/UFVJM - SIGEV'),
        nav([class='navbar navbar-expand-lg navbar-light bg-light'],
        [
          div([class('container-fluid')],
          [
            a([class(['navbar-brand']), href(['/'])],
            'SIGEV'),
            div([button([class='navbar-toggler', type='button', data-bs-toggle='collapse', data-bs-target='#navbarNav', aria-controls='navbarNav', aria-expanded='false', aria-label='Toggle navigation'],
            [
              span([],[class='navbar-toggler-icon'])
            ])],
            [
              div([class='collapse navbar-collapse', id='navbarNavDropdown'],
              [
                ul([class='nav-bar'],
                [
                  li([class='nav-item'],
                  [
                    a([class='nav-link', href='/'], 'Equipe')
                  ]),
                  li([class='nav-item'],
                  [
                    a([class='nav-link', href='/'], 'Editar Perfil')
                  ]),
                  li([class='nav-item'],
                  [
                    a([class='nav-link', href='/form6'], 'Requisitar veiculo')
                  ])
                ])
              ])
            ])
          ])
        ])
        ]).



