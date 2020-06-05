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

% ---- 1) Vizinhos em heap, calcula todos os vizinhos.
vizinhos_heap2(S,P1,R,V,Ct) :-
      findall( A,                          %(K,A,[(Pt,K,A)|P1]),
            (aresta(Pt, S, A,D),
            ord_nonmember(A, V),
            K is Ct + D
            ), R1),
      list_to_ord_set(R1,R2),
      heap_aux(S,P1,R2,V,Ct,[],R).

heap_aux(S,P1,[],V,Ct,R,R).
heap_aux(S,P1,[H|T],V,Ct,L,R) :-
      aresta(Pt,S,H,D),
      K is Ct + D,
      heap_aux(S,P1,T,V,Ct,[(K,H,[(Pt,K,H)|P1])|L],R).


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
      vizinhos(S,P1,R,Vf,Q),                    % Adiciona todos os vizinhos de S
      append_queue(R, Qp, Qf),
      depth_first_aux(Y,Qf,P,Vf).

% ---- 3) Uniform-Cost
add_all_heap(Hf, [], Hf).
add_all_heap(Hi, [(K,S,P)|T], Hf) :-
      add_to_heap(Hi, K, (K,S,P), H),
      add_all_heap(H, T, Hf).

uniform_cost(X, Y, P) :-
      (nao(nodo(X,_,_,_,_,_,_,_,_,_,_));
       nao(nodo(Y,_,_,_,_,_,_,_,_,_,_))),!,
       fail.
uniform_cost(X, Y, P) :-
      empty_heap(H),
      add_to_heap(H, 0, (0,X,[(-1,0,X)]) , Heap),
      uniform_cost_aux( Y,Heap,R,[] ),
      inverso(R, P).

uniform_cost_aux(Y, Heap, P,V) :-              % Se o prox elem for o destino, sai.
      min_of_heap(Heap, C, (C,Y,P)).
uniform_cost_aux(Y, Heap, P,V) :-              % Pop da fila de espera
      get_from_heap(Heap, K, (K,S,P1), Heap2), %append_queue([(S,P1)], Qp, Q),
      ord_add_element(V,S,Vf),                  % Se nao foi visitado
      vizinhos_heap(S,P1,R,V,K),                    % Adiciona todos os vizinhos de S
      add_all_heap(Heap2, R, Heapf), !,             %append_queue(R, Qp, Qf),
      uniform_cost_aux(Y,Heapf,P,Vf).

% #########################################################
% Metodos de Procura Informada.

% ---- 1) Greedy Search.

% ---- 2) A-star.


% #########################################################
% Metodos de Incremental Cutout.

% ---- 1) Esferico.

% ---- 2) Inteligente.

% #########################################################
