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

personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).
 
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).



saleCon(Persona1, Persona2):-
	pareja(Persona1, Persona2).

saleCon(Persona1, Persona2):-
	pareja(Persona2, Persona1).

esFiel(Persona):-
	saleCon(Persona, _),
	findall(Persona,saleCon(Persona,_),Parejas),
	length(Parejas,1).

acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador, Empleado).
	
acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador,Persona),
	acataOrden(Persona, Empleado).

%Si. La clausula acataOrden es recursiva. Su caso base seria: acataOrden(marsellus, jules).

esPeligroso(Personaje):-
	personaje(Personaje, Ocupacion),
	ocupacionPeligrosa(Ocupacion).
	
ocupacionPeligrosa(mafioso(maton)).
ocupacionPeligrosa(ladron(Ocupaciones)) :-
	member(licorerias, Ocupaciones).
	
esPeligroso(Personaje):-
	trabajaPara(Empleador, Personaje),
	esPeligroso(Empleador).

sanCayetano(Persona):-
	encargo(Persona, OtraPersona, _),
	trabajaPara(OtraPersona, Persona).
	
sanCayetano(Persona):-
	encargo(Persona, OtraPersona, _),	
	amigo(OtraPersona,Persona).
	
nivelRespeto(vincent,15).
nivelRespeto(Personaje,NivelDeRespeto):-
	personaje(Personaje,Profesion),
	respeto(Profesion,NivelDeRespeto).	
	
respeto(actriz(Peliculas),NivelDeRespeto):-
	length(Peliculas, CantidadDePeliculas),
	NivelDeRespeto is CantidadDePeliculas /	10.
	
respeto(mafioso(resuelveProblemas), 10).

respeto(mafioso(capo), 20).

respetabilidad(Respetables,NoRespetables):-
	cantidadRespetables(Respetables),
	cantidadNoRespetables(NoRespetables).

esRespetable(Personaje):-
	nivelRespeto(Personaje,NivelDeRespeto),
	NivelDeRespeto>9.

noEsRespetable(Personaje):-
	personaje(Personaje,_),
	not(esRespetable(Personaje)).

cantidadRespetables(Respetables):-
	findall(Personaje,esRespetable(Personaje), ListaRespetables),
	length(ListaRespetables,Respetables).

cantidadNoRespetables(NoRespetables):-
	findall(Personaje,noEsRespetable(Personaje), ListaNoRespetables),
	length(ListaNoRespetables,NoRespetables).

masAtareado(UnPersonaje):-
	personaje(UnPersonaje,_),
	forall(personaje(OtroPersonaje,_),tieneMasEncargos(UnPersonaje,OtroPersonaje)).
	
tieneMasEncargos(UnPersonaje, OtroPersonaje):-
	cantidadEncargos(UnPersonaje, CantidadDeEncargos1),
	cantidadEncargos(OtroPersonaje, CantidadDeEncargos2),
	CantidadDeEncargos1 >= CantidadDeEncargos2.
	
cantidadEncargos(Personaje, CantidadDeEncargos):-
	findall(Personaje, encargo(_, Personaje,_), Encargos),
	length(Encargos,CantidadDeEncargos).
