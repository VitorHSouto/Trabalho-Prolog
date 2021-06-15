/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

navbar_user(_Pedido) -->
    html(nav([ class='navbar navbar-expand-lg navbar-light bg-light fixed-top'],
             [ div(class('container-fluid'),
                   [ a([ class='navbar-brand', href='/home'],
                       [ ' SIGEV']),
                     button([ class('navbar-toggler'),
                              type(button),
                              'data-bs-toggle'=collapse,
                              'data-bs-target'='#~w'-[navbarNav],
                              'aria-controls'=navbarNav,
                              'aria-expanded'=false,
                              'aria-label'='Toggle navigation'],
                            [span([class='navbar-toggler-icon'], [])]),
                     div([ class(['collapse', 'navbar-collapse']),
                           id=navbarNav ],
                         [ ul([class='navbar-nav ms-auto mb-2 mb-lg-0'],
                              [ 
                                \nav_item('/equipe', 'Equipe'),
                                \nav_item('/alocacao', 'Requisicao de Veiculo'),
                                \nav_item('/', 'Editar Pefil')
                              ]) 
                         ])
                   ])
             ])
             ).

navbar_adm(_Pedido) -->
    html(nav([ class='navbar navbar-expand-lg navbar-light bg-light fixed-top'],
             [ div(class('container-fluid'),
                   [ a([ class='navbar-brand', href='/administrador'],
                       [ ' SIGEV']),
                     button([ class('navbar-toggler'),
                              type(button),
                              'data-bs-toggle'=collapse,
                              'data-bs-target'='#~w'-[navbarNav],
                              'aria-controls'=navbarNav,
                              'aria-expanded'=false,
                              'aria-label'='Toggle navigation'],
                            [span([class='navbar-toggler-icon'], [])]),
                     div([ class(['collapse', 'navbar-collapse']),
                           id=navbarNav ],
                         [ ul([class='navbar-nav ms-auto mb-2 mb-lg-0'],
                              [ 
                                li([class='nav-item dropdown'],
                                [
                                    a([class='nav-link dropdown-toggle', href='', id='navbarDropdownMenuLink', role='button', data-bs-toggle='dropdown', aria-expanded='false'],
                                    'Cadastros'),
                                    ul([class='dropdown-menu dropdown-menu', aria-labelledby='navbarDropdownMenuLink'],
                                    [
                                    li([a([class='dropdown-item', href='/veiculo'], 'Cadastrar Veiculo')]),
                                    li([a([class='dropdown-item', href='/motoristas'], 'Cadastrar Motorista')]),
                                    li([a([class='dropdown-item', href='/viagens'], 'Cadastrar Viagem')]),
                                    li([a([class='dropdown-item', href='/locais'], 'Cadastrar Local')]),
                                    li([a([class='dropdown-item', href='/viajantes'], 'Cadastrar Viajante')])
                                    ])


                                ]),
                                \nav_item('/equipe', 'Equipe'),
                                \nav_item('/', 'Editar Perfil')
                               
                              ]) 
                         ])
                   ])
             ])
             ).


nav_item(Link, Rotulo) -->
    html(li([ class='nav-item'],
            [ a([class='nav-link menu-item', href=Link], Rotulo) ])).

