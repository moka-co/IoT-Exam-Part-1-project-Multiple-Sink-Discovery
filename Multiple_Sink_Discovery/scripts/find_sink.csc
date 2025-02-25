mark 0

//Algorithm Parameters
set sensitivity 0.67
int rssi_min 15
int rssi_max 65

//Get Neighbours
atnd n_neigh v

//Set variables
set partial_sum n_neigh
int counter n_neigh
int average 1
int rssi_score 0
set nn 0

//Send number of neighbors to neighbors
send n_neigh
//Loop
loop

//Receive in broadcast the number of neighbors from neighbors
//and read drssi from latest neighbor
receive nn
drssi read_rssi

int temp1 rssi_score
int temp2 read_rssi
set rssi_score (temp1+temp2)


if(nn>=0)
	dec counter //decrese after each received messages
	int temp1 nn
	int temp2 partial_sum
	set partial_sum (temp1+temp2)
end

if(counter==0)
	//Compute average
	int temp1 partial_sum
	int temp2 n_neigh
	set temp3 (temp1/temp2)
	int average temp3

	
	//Compute a portion of the average
	set temp1 average*sensitivity
	int paverage temp1


	//Compute the DRSSI score as the sum of DRSSI divided by n_neigh
	int temp1 rssi_score
	int temp2 n_neigh
	set avg_rssi_score temp1/temp2

	//Debug
	//print "rssi_score=" avg_rssi_score " n_neigh=" n_neigh " pdaverage=" paverage 

	//Check if the number of neighbors is less than "paverage"
	//and if it's between the two drssi thresholds
	if((n_neigh<paverage)&&(avg_rssi_score>rssi_min)&&(avg_rssi_score<rssi_max))
		mark 1
	end
	stop
end

delay 500