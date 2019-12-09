/***
* Name: predator
* Author: azem
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model predator


global {
	/** Insert the global definitions, variables and actions here */
	
	
	init{
		create species:Grass number:30;
		create species:Lamb number:20;
	}
	reflex term{
		if(length(Lamb)=0){
			do pause;
		}
	}
}


species name: Grass parent:Creature{
	rgb color<-#green;
	float doubleSpeed<-50.0;
	int regenerate <-0;
	aspect vue2D{
		draw triangle(size) color:color;
	}
	
	reflex diee when:(regenerate>=10){
		do die;
	}
	reflex multiple when:(size>matureSize){
		doubleCount<-doubleCount+1;
		
		if(doubleCount>doubleSpeed){
			create Grass number:1{
				if(flip(0.25)){
					self.location<-{location.x+rnd(5.0), location.y+rnd(5.0)};
				}else if(flip(0.25)){
					self.location<-{location.x-rnd(5.0), location.y+rnd(5.0)};
				}else if(flip(0.25)){
					self.location<-{location.x+rnd(5.0), location.y-rnd(5.0)};
				}else{
					self.location<-{location.x-rnd(5.0), location.y-rnd(5.0)};
				}
					
				
				self.size<-0.2;
			}
			doubleCount<-0;
		}
	}
}

species Animal parent:Creature{
	int age <-0;
	int maxAge<-500;
	int starveTime<-0;
	float eatSpeed<-2.0;
	float speed<-2.0;
	int eatCount <-0;
	
	
	reflex growUp{
		age<-age+1;
	}
	
	reflex die_age when:(age>maxAge and starveTime>=50){
		do die;
	}
	
	
	
}


species Lamb skills:[moving] parent: Animal{
		float size <-3.0;
		rgb color<-#gray;
		float doubleSpeed<-90.0;
		Grass target <-nil;
		reflex search_food when:(target=nil){
			starveTime<-starveTime+1;
			list grass_seen <- list (Grass) where ((each distance_to self<= 10));
			list grass_eatable <- grass_seen where ((each.size>=1));
			if(length(grass_eatable)>0){
				target<- grass_eatable with_min_of(each distance_to self);
			}else{
				do wander amplitude:10.0;
			}
		}
		reflex eat_grass when:(target != nil){
			
			if(dead(target)){
				target<-nil;
			}else{
				do goto target:target;
				if(target.location=location){
					if(eatCount > eatSpeed){
					ask target{
						set regenerate <-regenerate+1;
						set size<-0.5;
					}
					}
					eatCount<-0;starveTime<-0;
					do goto target:any_location_in(world);
					target<-nil;
				}else{
					eatCount<-eatCount+1;
				}
			}
			
			
			
		}
		
		reflex multiple when:(size>matureSize and starveTime<10){
		doubleCount<-doubleCount+1;
		
		if(doubleCount>doubleSpeed){
			create Lamb number:1{
				self.location<-myself.location+rnd(5.0);
				self.size<-2.0;
			}
			doubleCount<-0;
		}
	}
		
		aspect vue2D{
			draw rectangle(size,size/2) color:color;
		}
}

species Creature{
	float size <-0.2;
	float maxSize<-2.0;
	float matureSize<-1.0;
	float doubleSpeed<-10.0;
	float growSpeed<-0.02;
	int growCount <-0;
	int doubleCount<-0;
	rgb color<-#black;
	
	
	reflex growUp when:(size<maxSize){
		size<-size+growSpeed;
		
	}
	
	reflex multiple when:(size>matureSize){	}
	
	
}
experiment predator type: gui {
	output {
		display pop{
			species Grass aspect:vue2D;
			species Lamb aspect:vue2D;
		}
		display graph{
			chart "Stat nombre" type: series {
            data "Nomnre de grass " value: length(Grass) style: line color: #magenta ;
            data "Nombre de lamb" value: length(Lamb) style: line color: #red ;
             }
		}
	}
}
