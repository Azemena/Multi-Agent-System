/***
* Name: Kmeans
* Author: azem
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Kmeans

global {
	/** Insert the global definitions, variables and actions here */
	int number_points <- 250 parameter:"nombre de point" min:20 max:500;
	int number_means <- 5 parameter:"nombre des central" min:2 max:200;
	float point_size<-1.0 parameter:"taille des points" min:0.5 max:5.0;
	float mean_size<-2.0 parameter:"taille des moyennes" min:1.0 max:10.0;
	int old<-10000;
	init {
		create KMPoint number: number_points ;
		create Mean number: number_means;
		
	}
	int change<-0;
	reflex stop_condition{
		if(change=0 and old=0){
			do pause;
		} 
		old<-change;
		change <-0;
	}
	
}
species KMPoint{
	rgb color<-#black;
	Mean me<-nil;
	aspect view {
		draw circle(point_size) color:color;
	}
	aspect view3D {
		draw sphere(point_size) color:color;
	}
	action calc_change_mean{
		Mean tmp<-Mean with_min_of(each distance_to self);
		if(me!=tmp){
			me<-tmp;
			color<-me.color;
			change<-change+1;
		}
		
	}
	reflex change{
		do calc_change_mean;
	}
	
}
species Mean{
	rgb color<-rgb(rnd(255),rnd(255),rnd(100));
	aspect view {
		draw circle(mean_size) color:color;
	}
	aspect view3D {
		draw sphere(mean_size) color:color;
	}

	action move_maj{
		list<KMPoint> pts <- list(KMPoint) where (each.color=color);
		location<-mean(pts collect each.location);
	}
	
	reflex calc_move{
		do move_maj;
	}
}

experiment KMean type: gui {
	/** Insert here the definition of the input and output of the model */
	output {
		display main_display {
			species KMPoint aspect: view ;
			species Mean aspect: view ;
		}
		display changement {
		chart "Changement par cycle" type: series size: {1, 0.5} position: {0, 0} {
				data "Changement" value: change style: line color: #green ;				
			}
		}
	}
}
experiment KMean3D type: gui {
	output {
		display Display3D type: opengl synchronized: true background: #gray{
			species KMPoint aspect: view3D refresh:true;
			species Mean aspect: view3D refresh:true;
		}
		display changement {
		chart "Changement par cycle" type: series size: {1, 0.5} position: {0, 0} {
				data "Changement" value: change style: line color: #green ;				
			}
		}

	}

}