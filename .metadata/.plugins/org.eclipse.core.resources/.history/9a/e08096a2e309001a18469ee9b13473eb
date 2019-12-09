/***
* Name: Fourmis
* Author: azem
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Fourmis


global {
	/** Insert the global definitions, variables and actions here */
	float delta <- 0.001 parameter:"delta";
	init {
		create Nid number: 2;
		create Nourriture number: 3;
		create Fourmis number: 20 ;
		
	}

}
species Nid{
	int size <-3;
	rgb couleur <-rgb(255,rnd(100)+255,255);
	
	aspect view2D{
		draw square(size) color:#blue;
	}
	
}
species Fourmis skills:[moving]{
	float size<-rnd(1)+1.0;
	float puissance <-rnd(10)+20.0;
	float rayon_observation <- puissance*0.2;
	point target <- nil;
	Nid nid <-nil;
	int step<-7;
	float vitesse<- puissance*0.005;
	bool is_free<-true;
	init{
		nid<-Nid with_min_of(each distance_to self);
		location<-nid.location;
	}
	
	
	//les actions
	action laisser_signaux{
		create Signal number: 1 {
			self.puissance<-myself.puissance*10;
			self.target<-myself.target;
		}
	}
	action observer_nourriture{
		list<Nourriture> neighbours <-  list(Nourriture) where ((each distance_to self)<=rayon_observation);
		return length(neighbours)>0?neighbours:nil;  
	}
	action observer_signaux{
		list<Signal> neighbours <-  list(Signal) where (each distance_to self<=rayon_observation);
		return length(neighbours)>0?neighbours:nil; 
	}
	action chercher_signal {
		list<Signal> signaux <- observer_signaux;
		list<Nourriture> nourritures <-observer_nourriture;
		
		if(nourritures!=nil and length(nourritures)!=0){
			Nourriture n <- nourritures with_min_of(each distance_to self);
			target<-n.location;
		}else{
			if(signaux!=nil and length(signaux)!=0){
				Signal s <- signaux with_min_of(each distance_to self);
				target<-s.target;
			}
		}
	} 
	
	//les reflexe
	reflex signaler when:target!=nil {
		if(step mod 5=0){
			do laisser_signaux;
		}else{
			step<-step+1;
		}
	} 
	
	reflex par_hasard when:target=nil{
		do chercher_signal; // si je commente ça ca marche
		do wander amplitude:2.0 speed:vitesse;
		
		
	}
	
	reflex aller_retour when:target!=nil{
		if(target distance_to self<rayon_observation){
			list<Nourriture> l <-list(Nourriture); 
			write (length(l));
			Nourriture n <- l with_min_of(each distance_to self);// je debogue ici mon code ne marche pas
			n.quantite<-n.quantite-puissance;
			}
		if(nid.location distance_to self<rayon_observation and !is_free){
			is_free<-true;
			target<-nil;
			}
		if(is_free){
			do goto target:target;
		}else{
			do goto target: nid.location;
			is_free<-false;
		}
		
	}
	aspect view2D{
		draw circle(size) color:#red;
	}
}

species Nourriture{
	int size <- rnd(2)+2;
	rgb couleur <- #yellow;
	float quantite <- size*200.0;
	aspect view2D{
		draw circle(size) color:couleur;
	}
	
	
}
species Signal{
	int size<-3;
	rgb couleur <- #gray;
	float puissance<-0.0;
	point target;
	aspect view2D{
		draw circle(size) color:couleur;
	}
	action diminuer_puissance{
		puissance<-puissance-(puissance*delta);
	}
}

experiment Fourmis2D type: gui {
	/** Insert here the definition of the input and output of the model */
	output {
		display main_display{
			species Fourmis aspect: view2D;
			species Nid aspect: view2D;
			species Signal aspect: view2D;
			species Nourriture aspect: view2D;
		}
		
		
	}
}