pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, bianca).
pareja(bernardo, charo).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(Empleador, bernardo):-
	trabajaPara(marsellus, Empleador),
	Empleador \= jules.
trabajaPara(Empleador, george):-
	saleCon(Empleador,bernardo).

saleCon(Persona1, Persona2):-
	pareja(Persona1, Persona2).

saleCon(Persona1, Persona2):-
	pareja(Persona2, Persona1).

esFiel(Persona):-
	saleCon(Persona, _),
	findall(Persona,saleCon(Persona,_),Parejas),
	length(Parejas,CantidadDeParejas),
	CantidadDeParejas = 1.
