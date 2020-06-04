% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Trabalho individual aluno nº 84930.                 ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: operacoes.pl                              ##
% ## Descricao: O presente ficheiro tem como objetivo  a ##
% ## definicao  de  operacoes  de  interesse do posto de ##
% ## vista de eficiencia  de codigo. Definem-se, tambem, ##
% ## predicados para insercao e  remocao das respectivas ##
% ## entidades.                                          ##
% #########################################################

% #########################################################
% Incremental cutout - utils

% Retira da base de conhecimento todos os Predicados indicados.
retract_all([]) :- !.
retract_all([X|T]) :-
	retract(X),
	retract_all(T).

% Insere na base de conhecimento todos os Predicados indicados.
assert_all([]) :- !.
assert_all([X|T]) :-
	assert(X),
	assert_all(T).

% Retorna conjunto de arestas que quebrem o metodo de esferico.
teste_esferico(X, Y, OX, OY, RHS) :-
	LHS is (X - OX)*(X - OX) + (Y - OY)*(Y - OY),
	LHS > RHS.

candidatos_esfericos(GI, GF, K, R) :-
	nodo(GI,OX,OY,_,_,_,_,_,_,_,_),
	nodo(GF,DX,DY,_,_,_,_,_,_,_,_),
	Dist2 is (DX-OX)*(DX-OX) + (DY-OY)*(DY-OY),
	RHS is K*K*Dist2,
	findall(
		aresta(C, G1, G2, D),
		( aresta(C, G1, G2, D),
		  ( ( nodo(G1,X,Y,_,_,_,_,_,_,_,_),
		      teste_esferico(X,Y,OX,OY,RHS) ) ;
		    ( nodo(G2,X,Y,_,_,_,_,_,_,_,_),
    		      teste_esferico(X,Y,OX,OY,RHS) )) ),
		R
	),
	retract_all(R).

% Retorna conjunto de arestas que quebrem o metodo de inteligente.
teste_inteligente(X, Y, OX, OY, DX, DY, Vx, Vy, RHS, Psi) :-
	Nx is -Vy,
	Ny is Vx,
	LHS1 is (X - OX)*(X - OX) + (Y - OY)*(Y - OY),
	LHS2 is (X - DX)*(X - DX) + (Y - DY)*(Y - DY),
	LHSP1 is Vx*(X - OX) + Vy*(Y - OY) ,
	LHSP2 is Vx*(X - DX) + Vy*(Y - DY) ,
	LHSP3 is Nx*(X - (OX - K*Psi*Nx)) + Ny*(Y - (OY - K*Psi*Ny)) ,
	LHSP4 is Nx*(X - (DX + K*Psi*Nx)) + Ny*(Y - (DY + K*Psi*Ny)) ,
	(LHS1 > RHS ;
	 LHS2 > RHS ;
	 LHSP1 < 0 ;
	 LHSP2 > 0 ;
	 LHSP3 < 0 ;
	 LHSP3 > 0).

candidatos_inteligente(GI, GF, K, R) :-
	nodo(GI,OX,OY,_,_,_,_,_,_,_,_),
	nodo(GF,DX,DY,_,_,_,_,_,_,_,_),
	RHS is K*K*500*500,
	Psi is 500,
	Fc is sqrt( (DX-OX)*(DX-OX) + (DY-OY)*(DY-OY) ),
	Vx is (DX - OX) / Fc,
	Vy is (DY - OY) / Fc,
	findall(
		aresta(C, G1, G2, D),
		( aresta(C, G1, G2, D),
		  ( ( nodo(G1,X,Y,_,_,_,_,_,_,_,_),
		      teste_inteligente(X,Y,OX,OY,Dist2,RHS) ) ;
		    ( nodo(G2,X,Y,_,_,_,_,_,_,_,_),
    		      teste_inteligente(X,Y,OX,OY,Dist2,RHS) )) ),
		R
	),
	retract_all(R).

% #########################################################
