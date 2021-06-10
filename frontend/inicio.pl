/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

home(_Pedido) :-
    reply_html_page(
        bootstrap,
        [ title('Gestão de Viagens')],
        [ h1([class='row mx-3'],'Proposta de desenvolvimento de software para gestão de viagens da DEAD/UFVJM - SIGEV'),
          nav(class(['nav', 'flex-column','row mx-3 p-3']),
             [h3(a([ class(['nav-link']),
              href('/form1')],
              'Formulário 1 ')),
              h3(a([ class(['nav-link']),
              href('/form2')],
              'Formulário 2 '))]),
              h3(a([ class(['nav-link']),
              href('/tbl_viajantes')],
              'Tabela do Formulário 1 ')),
              h3(a([ class(['nav-link']),
              href('/tbl_locais')],
              'Tabela do Formulário 2 '))
        ]).
