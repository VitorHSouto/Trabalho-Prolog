/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

home(_Pedido) :-
    reply_html_page(
        bootstrap,
        [ title('Gest�o de Viagens')],
        [ h1([class='row mx-3'],'Proposta de desenvolvimento de software para gest�o de viagens da DEAD/UFVJM - SIGEV'),
          nav(class(['nav', 'flex-column','row mx-3 p-3']),
             [h3(a([ class(['nav-link']),
              href('/form1')],
              'Formul�rio 1 ')),
              h3(a([ class(['nav-link']),
              href('/form2')],
              'Formul�rio 2 ')),
              h3(a([ class(['nav-link']),
              href('/tbl_viajantes')],
              'Tabela do Formul�rio 1 ')),
              h3(a([ class(['nav-link']),
              href('/tbl_locais')],
              'Tabela do Formul�rio 2 ')),
              h3(a([ class(['nav-link']),
              href('/form3')],
              'Formulario 3 ')),
              h3(a([ class(['nav-link']),
              href('/form4')],
              'Formulario 4 ')),
              h3(a([ class(['nav-link']),
              href('/tbl_veiculo')],
              'Tabela do Formulario 3 ')),
              h3(a([ class(['nav-link']),
              href('/tbl_motoristas')],
              'Tabela do Formulario 4 ')),
              h3(a([ class(['nav-link']),
              href('/form6')],
              'Formulario 6 '))
        ]) ]).
