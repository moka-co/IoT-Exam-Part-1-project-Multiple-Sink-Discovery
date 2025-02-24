//Variable parameter
set sensitivity 0.77
int drssi_threshold_min 15
int drssi_threshold_max 48

//Get Neighbours
atnd n_neigh v

//Set variables
int partial_sum n_neigh
int counter 1
int average 1
int drssi_score 0
set nn 0

//Send number of neighbors to neighbors
send n_neigh

//Loop
loop


//Receive in broadcast the number of neighbors from neighbors
//and read drssi from latest neighbor
receive nn
drssi read_drssi

set temp5 drssi_score
set temp6 read_drssi
set drssi_score (temp5+temp6)


if(nn>=0)
	inc counter //increase the counter of received messages

	int temp1 nn
	int temp2 partial_sum
	set partial_sum (temp1+temp2)
end

//Compute average
int temp1 partial_sum
int temp2 counter
set temp3 temp1/temp2
int average temp3


//Compute a portion of the average
set temp4 average*sensitivity
int paverage temp4


//Compute the DRSSI score as the sum of DRSSI divided by n_neigh
int temp7 drssi_score
int temp8 counter
set temp9 temp7/temp8

//Print drssi score, number of neighbors and portion of the average
//print "drssi_score=" temp9 " n_neigh=" n_neigh " tdaverage=" temp4

//Check if the number of neighbors is less than "paverage"
//and if it's between the two drssi thresholds
if((n_neigh<=paverage)&&(temp9>drssi_threshold_min)&&(temp9<drssi_threshold_max))
	mark 1
else
	mark 0
end


delay 1000