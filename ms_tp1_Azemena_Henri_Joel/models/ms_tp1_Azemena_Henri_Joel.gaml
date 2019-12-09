/***
* Name: mstp1AzemenaHenriJoel
* Author: azem
* Description: 
* Tags: Tag1, Tag2, TagN
***/


model mstp1AzemenaHenriJoel

global {
	
	/** Definition des parametres globals*/
	
	int n<-rnd(18);
	int k <-(3);
	int taille <- 4;
	int taille_point;
	int taille_centre;
	
	init {
		
		create PointNormal number:n; 
		create PointCentral number:k;
	}
}

// DEfinition des attributs de l'agent point general qui regoupe les ttributs des deux autre agents

species PointGeneral{
	
	point position;
	rgb couleur;
	int taille_point <- 2;
	int taille_centre <-3;
	
}

// DEfinition des attributs de l'agent Point NOrmal qui va heriter ses attributs de point general
species PointNormal parent:PointGeneral{
		reflex detect_centre {
			let mon_centre value: first(list(PointCentral) sort_by(self distance_to each));
			couleur <- mon_centre.couleur;
	}
	
		aspect base{
		draw circle (2) color: #black;
	}
		
}


// DEfinition des attributs de l'agent Point central qui va heriter ses attributs de point general
species PointCentral parent: PointGeneral{
	
	reflex detect_position {
		let my_group value: list(PointNormal) sort_by(self distance_to each);
	}
	
	aspect base{
		draw circle (2) color: #red;
	}
}


// Fonction principale
experiment mstp1AzemenaHenriJoel type: gui {
	
	/** Insert here the definition of the input and output of the model */
	output {
		
		display my_display{
			species PointNormal aspect:base;
			species PointCentral aspect:base;
			
		}
	}
}
