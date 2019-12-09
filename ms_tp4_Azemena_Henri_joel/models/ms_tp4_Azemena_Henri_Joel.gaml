/***
* Name: ms_tp4_Azemena_Henri_Joel
* Author: azem
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model ms_tp4_Azemena_Henri_Joel

/* Insert your model definition here */

global{
	float dimension_du_terrain <- 35#m;
	geometry shape <- square(dimension_du_terrain);
	int nbre_herbe_initial<-100;
	int nbre_loup_initial<-5;
	int nbre_agneaux_initial<-10;
	float taille_min_general<-0.01;
	int esperance_vie<-0;
	
	reflex creer_herbe {
		create species:Herbe number:nbre_herbe_initial;
	}
	
	reflex creer_agneaux{
		create species:Agneaux number:nbre_agneaux_initial;
	}
	
	reflex creer_loup{
		create species:Loup number:nbre_loup_initial;
	}
	
//	reflex caos when:esperance_vie>10{
	//	do halt;
	//}
	
}


// L'AGENT HERBE
species Herbe{
	rgb couleur;
	float taille_herbe;
	
	init{
		taille_herbe<-0.0001;
		couleur<-#green;	
	}
	
	reflex herbe_grandir{
		taille_herbe<- taille_herbe + 0.01;
		if(taille_herbe>0.5){
			if(taille_herbe>0.5){
				do tuer_herbe;
			}
		}
	}
	
	float taille_herbe(float taille){
		float taille_exacte<- taille_herbe*taille/1000;
		float taille_courante<- taille_exacte;
		return taille_courante;
		
	}
	
	action tuer_herbe{
		write "HERBE MORT";
		esperance_vie <- esperance_vie + 1;
		do die;
	}
	
		aspect base {
		draw circle(0.07) color:#green;
	}
	
}




// L'AGENT AGNEAU
species Agneaux skills:[moving]{
	rgb couleur;
	float taille_agneau;
	
	reflex moving{
		do wander;
	}
	
	init{
		taille_agneau<-0.001;
		couleur<-#red;	
	}
	
	reflex agneau_grandir{
		taille_agneau<- taille_agneau + 0.01;
		if(taille_agneau>0.5){
			if(taille_agneau>0.5){
				do tuer_agneau;
			}
		}
	}
	
	float taille_agneau(float taille){
		float taille_exacte<- taille_agneau*taille;
		float taille_courante<- taille_exacte;
		return taille_courante;
		
	}
	
	action tuer_agneau{
		write "agneau MORT";
		esperance_vie <- esperance_vie + 1;
		do die;
	}
	aspect base{
		draw circle(0.3)color:#red;
	}
	
}




//L'AGENT LOUP
species Loup skills:[moving]{
	rgb couleur;
	float taille_loup;
	
		
	reflex moving{
		do wander;
	}
	
	init{
		taille_loup<-0.001;
		couleur<-#black;	
	}
	
	reflex loup_grandir{
		taille_loup<- taille_loup + 0.01;
		if(taille_loup>0.5){
			if(taille_loup>0.5){
				do tuer_loup;
			}
		}
	}
	
	float taille_loup(float taille){
		float taille_exacte<- taille_loup*taille;
		float taille_courante<-taille_exacte;
		return taille_courante;
		
	}
	
	action tuer_loup{
		write "LOUP MORT";
		esperance_vie <- esperance_vie + 1;
		do die;
	}
	
	aspect base{
		draw circle(0.4)color:#black;
	}
	
}

experiment My_Main{
	parameter "nombre de loup:" var: nbre_loup_initial;
	parameter "nombre agneau" var: nbre_agneaux_initial;
	parameter "nombre herbe" var: nbre_herbe_initial;
	
	output{
		
		display Affiche{
			species Loup aspect:base;
			species Agneaux aspect:base;
			species Herbe aspect:base;
		}
	}
}