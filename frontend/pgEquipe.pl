/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

equipe(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Equipe')],
        [
          \html_requires(css('custom.css')),
          \html_requires(css('entrada.css')),
          \navbar_user('navbar'),
          \titulo_da_pagina('Equipe'),
          div([class='row'],
          [
              div([class='col-sm-6'],
              [
                  div([class='card'],
                  [
                      div([class='card-body'],
                      [
                          h5([class='card-title'],'Nicolas de Paula'),
                          h6([class='card-subtitle mb-2 text-muted'], 'Desenvolvedor'),
                          p([class='card-text'], 'Aluno de Sistemas de Informacao pela Universidade Federal de Uberlandia')
                      ])
                  ])
              ]),
              div([class='col-sm-6'],
              [
                  div([class='card'],
                  [
                      div([class='card-body'],
                      [
                          h5([class='card-title'],'Vitor Hugo'),
                          h6([class='card-subtitle mb-2 text-muted'], 'Desenvolvedor'),
                          p([class='card-text'], 'Aluno de Sistemas de Informacao pela Universidade Federal de Uberlandia')
                      ])
                  ])
              ])
          ])


        ]).