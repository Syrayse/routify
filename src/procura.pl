% #########################################################
% ## SRCR - Routify, metodos de procura aplicados.       ##
% ## Trabalho individual aluno nº 84930.                 ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: procura.pl                                ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## encapsular todos os metodos de  procura  utilizados ##
% ## ao longo do sistema.                                ##
% #########################################################

% #########################################################
% Metodos de Procura Nao-Informada.

% ---- 0) Vizinhos, calcula todos os vizinhos.
vizinhos(S,P1,R,V,Q) :-
      findall((A,[(Pt,A)|P1]),
            (aresta(Pt, S, A,_),
            ord_nonmember(A, V),
            nao(queue_member((A,_), Q))
            ), R).

% ---- 1) Breadth-First.
breadth_first(X, Y, P) :-
      list_queue( [(X,[(-1,X)])],Q ),           % Init fila com 1 elem.
      breadth_first_aux( Y,Q,R,[] ),
      inverso(R, P).

breadth_first_aux(Y, Q, P,V) :-              % Se o prox elem for o destino, sai.
      queue_head(Q,(Y,P)).
breadth_first_aux(Y, Q, P,V) :-              % Pop da fila de espera
      append_queue([(S,P1)], Qp, Q),
      ord_add_element(V,S,Vf),                  % Se nao foi visitado
      vizinhos(S,P1,R,V,Q),                    % Adiciona todos os vizinhos de S
      queue_append(Qp, R, Qf),
      breadth_first_aux(Y,Qf,P,Vf).

% ---- 2) Depth-First.
depth_first(X, Y, P) :-
      list_queue( [(X,[(-1,X)])],Q ),           % Init fila com 1 elem.
      depth_first_aux( Y,Q,R,[] ),
      inverso(R, P).

depth_first_aux(Y, Q, P,V) :-              % Se o prox elem for o destino, sai.
      queue_head(Q,(Y,P)).
depth_first_aux(Y, Q, P,V) :-              % Pop da fila de espera
      append_queue([(S,P1)], Qp, Q),
      ord_add_element(V,S,Vf),                  % Se nao foi visitado
      vizinhos(S,P1,R,V,Q),                    % Adiciona todos os vizinhos de S
      append_queue(R, Qp, Qf),
      depth_first_aux(Y,Qf,P,Vf).

% ---- 3) Iterative Deepening Depth-First.

% #########################################################
% Metodos de Procura Informada.

% ---- 1) Greedy Search.

% ---- 2) A-star.

% ---- 3) Iterative Deepening A-star.

% #########################################################
% Metodos de Incremental Cutout.

% ---- 1) Esferico.

% ---- 2) Inteligente.

% #########################################################
