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

% ---- 0.1) Vizinhos em heap, calcula todos os vizinhos.
vizinhos_heap(S,P1,R,V,Ct) :-
      findall( A,
            (aresta(Pt, S, A,D),
            ord_nonmember(A, V)
            ), R1),
      list_to_ord_set(R1,R2),
      heap_aux(S,P1,R2,V,Ct,[],R).

heap_aux(S,P1,[],V,Ct,R,R).
heap_aux(S,P1,[H|T],V,Ct,L,R) :-
      aresta(Pt,S,H,D),
      K is Ct + D,
      heap_aux(S,P1,T,V,Ct,[(K,K,H,[(Pt,K,H)|P1])|L],R).

% ---- 0.2) Vizinhos, calcula todos de forma greedy.
%vizinhos_greedy(S,P1,R,V,Dt,Y)
vizinhos_greedy(S,P1,R,V,Ct,Dest) :-
      findall( A,
            (aresta(Pt, S, A,D),
            ord_nonmember(A, V)
            ), R1),
      list_to_ord_set(R1,R2),
      greedy_aux(S,P1,R2,V,Ct,[],R,Dest).

greedy_aux(S,P1,[],V,Ct,R,R,Dest).
greedy_aux(S,P1,[H|T],V,Ct,L,R,Dest) :-
      aresta(Pt,S,H,D),
      nodo(H,X1,Y1,_,_,_,_,_,_,_,_),
      nodo(Dest,X2,Y2,_,_,_,_,_,_,_,_),
      Dist is sqrt( (X1 - X2)*(X1 - X2) + (Y1 - Y2)*(Y1 - Y2) ),
      Df is Ct + D,
      greedy_aux(S,P1,T,V,Ct,[(Dist,Df,H,[(Pt,Df,H)|P1])|L],R,Dest).

% ---- 0.2) Vizinhos, calcula todos de forma a estrela.
vizinhos_star(S,P1,R,V,Ct,Dest) :-
      findall( A,
            (aresta(Pt, S, A,D),
            ord_nonmember(A, V)
            ), R1),
      list_to_ord_set(R1,R2),
      star_aux(S,P1,R2,V,Ct,[],R,Dest).

star_aux(S,P1,[],V,Ct,R,R,Dest).
star_aux(S,P1,[H|T],V,Ct,L,R,Dest) :-
      aresta(Pt,S,H,D),
      nodo(H,X1,Y1,_,_,_,_,_,_,_,_),
      nodo(Dest,X2,Y2,_,_,_,_,_,_,_,_),
      Dist is sqrt( (X1 - X2)*(X1 - X2) + (Y1 - Y2)*(Y1 - Y2) ),
      Df is Ct + D,
      K is Dist + Df,
      star_aux(S,P1,T,V,Ct,[(K,Df,H,[(Pt,Df,H)|P1])|L],R,Dest).

% ---- 1) Breadth-First.
breadth_first(X, Y, P) :-
      list_queue( [(X,[(-1,X)])],Q ),
      breadth_first_aux( Y,Q,R,[] ),
      inverso(R, P).

breadth_first_aux(Y, Q, P,V) :-
      queue_head(Q,(Y,P)).
breadth_first_aux(Y, Q, P,V) :-
      append_queue([(S,P1)], Qp, Q),
      ord_add_element(V,S,Vf),
      vizinhos(S,P1,R,V,Q),
      queue_append(Qp, R, Qf),
      breadth_first_aux(Y,Qf,P,Vf).

% ---- 2) Depth-First.
depth_first(X, Y, P) :-
      list_queue( [(X,[(-1,X)])],Q ),
      depth_first_aux( Y,Q,R,[] ),
      inverso(R, P).

depth_first_aux(Y, Q, P,V) :-
      queue_head(Q,(Y,P)).
depth_first_aux(Y, Q, P,V) :-
      append_queue([(S,P1)], Qp, Q),
      ord_add_element(V,S,Vf),
      vizinhos(S,P1,R,Vf,Q),
      append_queue(R, Qp, Qf),
      depth_first_aux(Y,Qf,P,Vf).

% ---- 3) Uniform-Cost
add_all_heap(Hf, [], Hf).
add_all_heap(Hi, [(K,Dt,S,P)|T], Hf) :-
      add_to_heap(Hi, K, (K,Dt,S,P), H),
      add_all_heap(H, T, Hf).

uniform_cost(X, Y, P) :-
      (nao(nodo(X,_,_,_,_,_,_,_,_,_,_));
       nao(nodo(Y,_,_,_,_,_,_,_,_,_,_))),!,
       fail.
uniform_cost(X, Y, P) :-
      empty_heap(H),
      add_to_heap(H, 0, (0,0,X,[(-1,0,X)]) , Heap),
      uniform_cost_aux( Y,Heap,R,[] ),
      inverso(R, P).

uniform_cost_aux(Y, Heap, P,V) :-
      min_of_heap(Heap, C, (C,_,Y,P)).
uniform_cost_aux(Y, Heap, P,V) :-
      get_from_heap(Heap, K, (K,Dt,S,P1), Heap2),
      ord_add_element(V,S,Vf),
      vizinhos_heap(S,P1,R,V,K),
      add_all_heap(Heap2, R, Heapf), !,
      uniform_cost_aux(Y,Heapf,P,Vf).

% #########################################################
% Metodos de Procura Informada.

% ---- 1) Greedy Best-fist.
greedy_best_first(X,Y,P) :-
      (nao(nodo(X,_,_,_,_,_,_,_,_,_,_));
       nao(nodo(Y,_,_,_,_,_,_,_,_,_,_))),!,
       fail.
greedy_best_first(X,Y,P) :-
      empty_heap(H),
      add_to_heap(H, 0, (0,0,X,[(-1,0,X)]) , Heap),
      greedy_best_first_aux( Y,Heap,R,[] ),
      inverso(R,P).

greedy_best_first(Y,Heap,[],_) :-
      empty_heap(Heap), !, fail.
greedy_best_first_aux(Y, Heap, P,V) :-
      min_of_heap(Heap, C, (C,_,Y,P)).
greedy_best_first_aux(Y, Heap, P,V) :-
      get_from_heap(Heap, K, (K,Dt,S,P1), Heap2),
      ord_add_element(V,S,Vf),
      vizinhos_greedy(S,P1,R,V,Dt,Y),
      add_all_heap(Heap2, R, Heapf), !,
      greedy_best_first_aux(Y,Heapf,P,Vf).

% ---- 2) A-star.
a_star(X,Y,P) :-
      (nao(nodo(X,_,_,_,_,_,_,_,_,_,_));
       nao(nodo(Y,_,_,_,_,_,_,_,_,_,_))),!,
       fail.
a_star(X,Y,P) :-
      empty_heap(H),
      add_to_heap(H, 0, (0,0,X,[(-1,0,X)]) , Heap), !,
      a_star_aux( Y,Heap,R,[] ),
      inverso(R,P).

a_star_aux(Y, Heap, P,V) :-
      min_of_heap(Heap, C, (C,_,Y,P)).
a_star_aux(Y, Heap, P,V) :-
      get_from_heap(Heap, K, (K,Dt,S,P1), Heap2),
      ord_add_element(V,S,Vf),
      vizinhos_star(S,P1,R,V,Dt,Y),
      add_all_heap(Heap2, R, Heapf), !,
      a_star_aux(Y,Heapf,P,Vf).

% #########################################################
% Metodos de Cutout.

% ---- 1) Esferico.
metodo_esferico(SFunc, X, Y, K, R) :-
      K > 1,
      candidatos_esfericos(X, Y, K, Del),
      (call(SFunc, X, Y, R) ; (assert_all(Del), fail)),
      assert_all(Del).

% ---- 2) Inteligente.
metodo_inteligente(SFunc, X, Y, K, R) :-
      K > 1,
      candidatos_inteligente(X, Y, K, Del),
      (call(SFunc, X, Y, R) ; (assert_all(Del), fail)),
      assert_all(Del).

% #########################################################
