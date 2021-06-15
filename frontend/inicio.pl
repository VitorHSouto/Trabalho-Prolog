/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).



home(_Pedido) :-
    reply_html_page(
        bootstrap,
        [ 
          title('Gestao de Viagens')],
        [
          \html_requires(css('custom.css')),
          \html_requires(css('entrada.css')),
          \navbar_user('navbar'),
          \titulo_da_pagina('Proposta de desenvolvimento de software para gestao de viagens da DEAD/UFVJM - SIGEV')
         

        ]).

titulo_da_pagina(Titulo) -->
    html( div( class('container py-5'),
               div(class('d-flex'),
                   div(class('text-center align-items-center w-100 py-4'),
                       h1('display-3', Titulo))))).

titulo_da_tabela(Titulo) -->
    html( div( class('container py-3'),
               div(class('d-flex'),
                   div(class('text-center align-items-center w-75 py-3'),
                       h1('display-2', Titulo))))).








