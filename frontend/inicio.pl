/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

home(_Pedido) :-
    reply_html_page(
        bootstrap,
        [ title('Gestao de Viagens')],
        [ h1([class='row mx-3'],'Proposta de desenvolvimento de software para gestao de viagens da DEAD/UFVJM - SIGEV'),
          div([class='row justify-content-center mx-3'],
          [ 
            div([class='col-md-2'],
            [
              div([button([ class='btn btn-dark dropdown-toggle', type='button', id='dropdownMenuButton', data-bs-toggle='dropdown', aria-expanded='false'], 'Tabelas'),
              ul([ class='dropdown-menu', aria-labelledby='dropdownMenuButton'],
              [
                li([], a([ class(['dropdown-item']), href('/tbl_viajantes')], 'Tabela do Formulario 1 ')),
                li([], a([ class(['dropdown-item']), href('/tbl_locais')], 'Tabela do Formulario 2 ')),
                li([], a([ class(['dropdown-item']), href('/tbl_veiculo')], 'Tabela do Formulario 3 ')),
                li([], a([ class(['dropdown-item']), href('/tbl_motoristas')], 'Tabela do Formulario 4 '))
              ])
              ])
            ])
          ]),
          div([class='row justify-content-center mx-3'],
          [ 
            div([class='col-md-2'],
            [
              div([button([ class='btn btn-dark dropdown-toggle', type='button', id='dropdownMenuButton', data-bs-toggle='dropdown', aria-expanded='false'], 'Formularios'),
              ul([ class='dropdown-menu', aria-labelledby='dropdownMenuButton'],
              [
                li([], a([ class(['dropdown-item']), href('/form1')], 'Formulario 1 ')),
                li([], a([ class(['dropdown-item']), href('/form2')], 'Formulario 2 ')),
                li([], a([ class(['dropdown-item']), href('/form3')], 'Formulario 3 ')),
                li([], a([ class(['dropdown-item']), href('/form4')], 'Formulario 4 ')),
                li([], a([ class(['dropdown-item']), href('/form5')], 'Formulario 5 ')),
                li([], a([ class(['dropdown-item']), href('/form6')], 'Formulario 6 '))              
              ])
              ])
            ])
          ]),
        ]).
