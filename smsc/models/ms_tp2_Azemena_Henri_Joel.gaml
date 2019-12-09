/***
* Name: ms_tp2_Azemena_Henri_Joel
* Author: azem
* Description: Simulation du comportement des fourmits seance numero 2 ici on a encore plus d'agent
*  le systeme defvien plus complexe que le premier tp sur les points

* Tags: Tag1, Tag2, TagN
***/

model ms_tp2_Azemena_Henri_Joel

/* Insert your model definition here */

global {
	int NombreNids <-1;
	int NombreNouriture <-10;
	int NombreFourmit <-3;
	
	init {
		create Nid number:NombreNids;
		create Nouriture number:NombreNouriture;
		create Fourmit number:NombreFourmit;
	}
	
}

species Nid {
	float taille <-5;
	point position 	;				//<-rnd();
	rgb couleur ;
	
	aspect base {
		draw circle(7) color: #brown;
	}
	
}

species Nouriture skills:[moving]{
	float taile;
	point posititon;
	rgb couleur <- #red;
	
		aspect base {
		draw circle(2) color: #yellow;
	}
	
	
	
}

species Fourmit skills: [moving]{
	rgb couleur <-#blue;
	float taille <-3;
	float charge <- rnd(3);
	float vitesse <-rnd(7);
	int proximite <-5;
	bool is_my_charge <- flip(0.7);	
	
		aspect base {
		draw circle(3) color: #black;
	}
	
	reflex deplacement {
		do wander;
	}
	
	reflex prendre_nouriture when: !empty(Nouriture at_distance proximite){
		ask Fourmit at_distance proximite{
			if (self.is_my_charge){
				
			}
		}
		
	}
	
}

experiment mstp1AzemenaHenriJoel type: gui {
	
	/** Insert here the definition of the input and output of the model */
	output {
		
		display my_display{
			species Nid aspect:base;
			species Nouriture aspect:base;
			species Fourmit aspect:base;
			
		}
	}
}






