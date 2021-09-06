//var deadline = new Date("aug 31, 2021 14:45:00").getTime();
var duration = parseInt(document.getElementById("temp_information").getAttribute('data-duration'));
var time_elaspsed = parseInt(document.getElementById("temp_information").getAttribute('data-time'));
var secondsToAdd = duration - time_elaspsed
var currentDate = new Date();
var deadline = new Date(currentDate.getTime() + secondsToAdd*1000)
console.log("time_elaspsed:",time_elaspsed)
console.log("minutesToAdd:",secondsToAdd)
console.log("deadline:",deadline)
const current_path = location.pathname

var countdown_timer = setInterval(function() {

    var now = new Date().getTime();
    var diff = deadline - now;

    var hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((diff % (1000 * 60)) / 1000);

    document.getElementById("assessment-timer").innerHTML = hours + ":"+ minutes + ":" + seconds;

    if (diff < 0) {
        clearInterval(countdown_timer);
        document.getElementById("assessment-timer").innerHTML = "Finished";
    } else if(current_path != location.pathname) {
        clearInterval(countdown_timer);
    }
}, 1000);

function getMeta(metaName) {
    const metas = document.getElementsByTagName('meta');
    for (let i = 0; i < metas.length; i++) {
        if (metas[i].getAttribute('name') === metaName) {
            return metas[i].getAttribute('content');
        }
    }
    return '';
}

var update_timer_elapsed = setInterval(function() {

    var now = new Date().getTime();
    var elapsed = parseInt( ((now - currentDate.getTime()) / 1000) + time_elaspsed)
    var diff = deadline - now;

    console.log("elapsed:",elapsed)

    const auth_token = getMeta("csrf-token");
    const xhttp = new XMLHttpRequest();
    
    const fd  = new FormData(); 
    fd.append( "casestudy_user_id", 1 );
    fd.append( "time_elaspsed", elapsed );
    fd.append( "authenticity_token", auth_token );
    const fds = new URLSearchParams(fd).toString()
    
    xhttp.addEventListener( 'load', function( event ) { console.log( 'Yeah! Data sent and response loaded.' ); } );
    xhttp.addEventListener('error', function( event ) { console.log( 'Oops! Something went wrong.' ); } );

    xhttp.open("PATCH", "http://127.0.0.1:3000/update_time");
    xhttp.setRequestHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9");
    xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    
    xhttp.send(fds)

    console.log("status:", xhttp.status)
    if(diff < 0) {
        clearInterval(update_timer_elapsed);
        paths = current_path.split('/')
        location.replace("http://"+location.host+"/"+paths[1]+"/"+paths[2]+"/submit_assessment");
    } else if(current_path != location.pathname) {
        clearInterval(update_timer_elapsed);
    }

}, 10000);