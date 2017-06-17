%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
 
%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

saleCon(Persona1, Persona2):-
	pareja(Persona1, Persona2).

saleCon(Persona1, Persona2):-
	pareja(Persona2, Persona1).