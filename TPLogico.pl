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

% personaje(Nombre, Ocupacion)
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

% encargo(Solicitante, Encargado, Tarea). 
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
	length(Parejas,CantidadDeParejas),
	CantidadDeParejas = 1.

acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador, Empleado).
	
acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador,Persona),
	acataOrden(Persona, Empleado).
	
esPeligroso(Personaje):-
	personaje(Personaje, mafioso(maton)).

esPeligroso(Personaje):-
	robaLicorerias(Personaje).	
	
esPeligroso(Personaje):-
	trabajaPara(Empleador, Personaje),
	esPeligroso(Empleador).

robaLicorerias(Personaje):-
	personaje(Personaje, ladron(Ocupaciones)),
	member(licorerias, Ocupaciones).

sanCayetano(Persona):-
	encargo(Persona, OtraPersona, _),
	trabajaPara(OtraPersona, Persona).
	
sanCayetano(Persona):-
	encargo(Persona, OtraPersona, _),	
	amigo(OtraPersona,Persona).

