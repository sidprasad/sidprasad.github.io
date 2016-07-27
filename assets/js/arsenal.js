
var teamNumber;
tnme = "Loading";
var leagueTableURL;
var arsenalURL;
var arsenalNextMonthURL;
var arsenalPastMonthURL;
var leagueURL = 'http://api.football-data.org/v1/competitions/398/teams';

var pastFixtures;
var options = new Object;



function LTable()
{

	if(document.getElementById("_table").style.display == "inline") {
		
		document.getElementById("_table").style.display = "none";
		document.getElementById("tablebutton").style.backgroundColor = "initial";
	} else {
	
		document.getElementById("_table").style.display = "inline";
		document.getElementById("tablebutton").style.backgroundColor = "#b3b3b3";
	/* League table */
		$.ajax({
		  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
		  url: leagueTableURL,
		  dataType: 'json',
		  type: 'GET',
		}).done( function (response) {
			console.log(response);
			document.getElementById("_table").innerHTML = "<h2>" + response.leagueCaption + "</h2>";
			builtLeagueTable(response.standing);
		});
	}
}

function pastMonth()
{
	if(document.getElementById("past").style.display == "inline") {
		
		document.getElementById("past").style.display = "none";
		document.getElementById("pastbutton").style.backgroundColor = "inline";
	} else {
	
		document.getElementById("past").style.display = "inline";
		document.getElementById("pastbutton").style.backgroundColor = "#b3b3b3";
		
	/*$.ajax({
	  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
	  url: arsenalPastMonthURL,
	  dataType: 'json',
	  type: 'GET',
	}).done( function (response) {
		console.log(response);*/
		
		document.getElementById("past").innerHTML = "<h2>Past Fixtures </h2>";
		console.log(pastFixtures);
		buildPastTable(pastFixtures.fixtures);
		
		
	//});

	}
}


function get_team() {
	
	var teamNumber = localStorage.getItem("team")
	if(teamNumber == undefined || teamNumber == null) {
		teamNumber = 'http://api.football-data.org/v1/teams/57';
		localStorage.setItem("team", teamNumber);
	}
	

	

	leagueTableURL = "http://api.football-data.org/v1/competitions/398/leagueTable";
	arsenalURL = teamNumber;
	arsenalNextMonthURL = teamNumber + '/fixtures?timeFrame=n30';
	arsenalPastMonthURL = teamNumber +'/fixtures?timeFrame=p30';
}

function buildSelector(teams) {
	
	var x = document.getElementById("chooseteam");
	
	
	for (i in teams) {
	
		var option = document.createElement("option");
		option.text = teams[i].name;
		

		options[option.text] = teams[i]._links.self.href;
		
		x.add(option);
		

	}

	
}


function newTeam (t) {
	
	localStorage.setItem("team", options[t]);
	location.reload();
}

function getRecent()
{
	
	get_team();


	$.ajax({
		  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
		  url: arsenalURL,
		  dataType: 'json',
		  type: 'GET',
		}).done( function (response) {
			
			document.getElementById("teamName").innerHTML = "<h1>" + response.name + "</h1>";
			tnme = response.name;
			
			
	});
	
	
	var leagueTeams = localStorage.getItem("teamlist");

	$.ajax({
		  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
		  url: leagueURL,
		  dataType: 'json',
		  type: 'GET',
		}).done( function (response) {

			
			buildSelector(response.teams);
			
	});
	
	
	

	$.ajax({
	  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
	  url: arsenalPastMonthURL,
	  dataType: 'json',
	  type: 'GET',
	}).done( function (response) {
		
		pastFixtures = response;
		var latestscore = document.getElementById("latestscore");
		var ls;
		if (response.count == 0) {
			
			ls = "<h2>No recent fixtures </h2>";
		} else {
			
			var newest = response.fixtures[response.count - 1];
			ls = "<h2>" + newest.homeTeamName + " ("+ newest.result.goalsHomeTeam + ") - (" +  newest.result.goalsAwayTeam + ") " + newest.awayTeamName + "</h2>";
			ls = ls + new Date(newest.date) + "<br> Matchday" + newest.matchday;
		}
		
		latestscore.innerHTML = ls + "<hr>";
		
	});


}

function nextMonth()
{
	if(document.getElementById("upcoming").style.display == "inline") {
		
		document.getElementById("upcoming").style.display = "none";
		document.getElementById("upcomingbutton").style.backgroundColor = "initial";
	} else {
	
		document.getElementById("upcoming").style.display = "inline";
		document.getElementById("upcomingbutton").style.backgroundColor = "#b3b3b3";
		
		$.ajax({
		  headers: { 'X-Auth-Token': '564ab25c92d04e2aa984fc04e398bbb6' },
		  url: arsenalNextMonthURL,
		  dataType: 'json',
		  type: 'GET',
		}).done( function (response) {
			console.log(response);
			document.getElementById("upcoming").innerHTML = "<h2>Upcoming Fixtures</h2>";
			buildUpcomingTable(response.fixtures);
			console.log(response.fixtures);

		});
	}
}


function builtLeagueTable(ltable) {
	
	var $table = $( "<table></table>" );
	var $line = $( "<tr></tr>" );
	$line.append( $( "<td></td>" ).html( "Position") );
		$line.append( $( "<td></td>" ).html( "Team" ) );
		$line.append( $( "<td></td>" ).html( "Played" ) );
		$line.append( $( "<td></td>" ).html( "Wins" ) );
		$line.append( $( "<td></td>" ).html( "Draws" ) );
		$line.append( $( "<td></td>" ).html( "Losses" ) );
		$line.append( $( "<td></td>" ).html( "Goal Difference" ) );
		$line.append( $( "<td></td>" ).html( "Points" ) );
		
		$table.append( $line );
	
	
	
	for ( var i = 0; i < ltable.length; i++ ) {
		var team = ltable[i];
		var $line = $( "<tr></tr>" );
		$line.append( $( "<td></td>" ).html( team.position ) );
		var st = "";
		var et = "";
		if(team.teamName == tnme) {
			st = "<b>";
			et = "</b>";
		} 
			
			
		$line.append( $( "<td></td>" ).html(st + team.teamName + et ) );
		$line.append( $( "<td></td>" ).html(st + team.playedGames + et ) );
		$line.append( $( "<td></td>" ).html(st + team.wins + et ) );
		$line.append( $( "<td></td>" ).html(st + team.draws + et ) );
		$line.append( $( "<td></td>" ).html(st + team.losses + et ) );
		$line.append( $( "<td></td>" ).html(st + team.goalDifference + et ) );
		$line.append( $( "<td></td>" ).html(st + team.points + et ) );

		$table.append( $line );
	}


	$table.appendTo( $(_table) );
	goToByScroll("_table");
}

	
function buildUpcomingTable(fixtures) {
	
	var $table = $( "<table></table>" );

	
	
	for ( var i = 0; i < fixtures.length; i++ ) {
		var $fixture = fixtures[i];
		var $line = $( "<tr></tr>" );
		$line.append( $( "<td></td>" ).html( $fixture.homeTeamName ) );
		$line.append( $( "<td></td>" ).html( $fixture.awayTeamName ) );
		
		var date = new Date($fixture.date);
		var ds = (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear().toString().substr(2,2);
		
		
		$line.append( $( "<td></td>" ).html( ds  ));
		$table.append( $line );
	}

	if(fixtures.length < 1) {
		document.getElementById("upcoming").innerHTML = "<h2> Upcoming Fixtures </h2> No fixtures in the upcoming month";
	} else {


		$table.appendTo( $(upcoming) );
	}
	
	goToByScroll("upcoming");
}

function buildPastTable(fixtures) {
	
	var $table = $( "<table></table>" );

	
	
	for ( var i = 0; i < fixtures.length; i++ ) {
		var $fixture = fixtures[i];
		var $line = $( "<tr></tr>" );
		var ht = $fixture.result.goalsHomeTeam;
		var at = $fixture.result.goalsAwayTeam;
		var b;
		if (ht > at) {

			$line.append( $( "<td></td>" ).html( "<b>" + $fixture.homeTeamName + "(" + ht + ") </b>"  ) );
			$line.append( $( "<td></td>" ).html( $fixture.awayTeamName + "(" + at + ")") );
		} else if (ht < at) {
			
			$line.append( $( "<td></td>" ).html( $fixture.homeTeamName + "(" + ht + ")"  ) );
			$line.append( $( "<td></td>" ).html("<b>" + $fixture.awayTeamName + "(" + at + ") </b>") );
			
		} else {
			$line.append( $( "<td></td>" ).html( $fixture.homeTeamName + "(" + ht + ")"  ) );
			$line.append( $( "<td></td>" ).html( $fixture.awayTeamName + "(" + at + ")") );
		}

		var date = new Date($fixture.date);
		var ds = (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear().toString().substr(2,2);
		
		
		$line.append( $( "<td></td>" ).html( ds  ));
		$table.append( $line );
	}

	if(fixtures.length < 1) {
		document.getElementById("past").innerHTML = "<h2>Past Fixtures </h2> No fixtures in the past month";
	} else {

	$table.appendTo( $(past) );
	}
	
	goToByScroll("past");
}


function goToByScroll(id){
      // Remove "link" from the ID
    id = id.replace("link", "");
      // Scroll
    $('html,body').animate({
        scrollTop: $("#"+id).offset().top},
        'slow');
}



function timeLeft () {

	var t = document.getElementById("transfer");

	if(t.style.display == "inline") {
		
		t.style.display = "none";
		document.getElementById("transferbutton").style.backgroundColor = "initial";
	} else {
	
		t.style.display = "inline";
		document.getElementById("transferbutton").style.backgroundColor = "#b3b3b3";


		var TransferOpen = "1 July 2016, 00:00:01"
		var oneDay = 24*60*60*1000;
		var transferDate = new Date(TransferOpen);
		var secondDate = new Date();

		var diffDaysArsenal = Math.abs((transferDate.getTime() - secondDate.getTime())/(oneDay));
		var percentDone;


		if( transferDate <= new Date("31 August 2016, 10:45:00") ) {
			TransferpercentDone = Math.abs(100 * (1 - (Math.abs((new Date("31 August 2016, 10:45:00").getTime() - secondDate.getTime())/(oneDay))/61)));

		}




		s3 = '<br> <progress  value="' + TransferpercentDone +'" max="100"> </progress> <br>';
		s1 = "<h2> Transfer Window </h2> The transfer window has been open for " + diffDaysArsenal.toFixed(0) + " days." + s3 + TransferpercentDone.toFixed(2) + "% of the window is over. <br> <i> Transfer news coming soon </i> <hr>";

		if(TransferpercentDone <= 100) {
			t.innerHTML= s1;
			
		} else {
			t.innerHTML="<h2> Transfer Window </h2> The window has closed. No more silly season!";
		}
		goToByScroll("transfer");
	}

}



