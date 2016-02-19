var CLIMBS = [];

$(document).ready(getClimbsFromServer);

function getClimbsFromServer() {
    $.ajax({
        url: "/scoresheet/climbs",
        method: "get"
    }).done(function(climbs) {
        CLIMBS = climbs;
        renderClimbs(climbs, "boulder");
    });
}

function focusTab(discipline) {
    var boulder = $("#boulderTab");
    var sport = $("#sportTab");
    var speed = $("#speedTab");
    var tabs = {boulder: boulder, sport: sport, speed: speed};
    for (var disc in tabs) {
        var tab = tabs[disc];
        if (!tab) {
            continue;
        }
        tab.addClass("inactive");
        tab.removeClass("active");
        if (disc == discipline) {
          tab.addClass("active");
          tab.removeClass("inactive");
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////
// Render different parts of the view
function renderClimbs(climbs, discipline) {
    clearClimbs();
    focusTab(discipline);
    if (discipline == "speed") {
        renderSpeed();
        return;
    }
    if (!document.getElementById("cols")) {
        return;
    }
    var table = document.getElementById("table");
    document.getElementById("cols").style.visibility = "visible";
    for (var i = 0, climb; climb = climbs[i]; i++) {
        if (climb.discipline !== discipline) {
            continue;
        }
        var li = document.createElement("li");
        li = li.appendChild(document.createElement("button"));
        li.onclick = renderClimbInfo(climbs, i);
        li.id = i;
        var points = document.createElement("div");
        var color = document.createElement("div");
        var attempts = document.createElement("div");
        attempts.id = "attempts";

        points.appendChild(document.createTextNode(climb.points));
        color.appendChild(document.createTextNode(climb.color));
        var attemptTallies = "";
        for (var j = 0; j < climb.attempts; j++) {
            if (j % 5 == 0) {
                attemptTallies += " ";
            }
            attemptTallies += "|";
        }
        if (!attemptTallies) {
            attemptTallies = "0";
        }
        attempts.appendChild(document.createTextNode(attemptTallies));

        if (climb.sent) {
            li.style.border = "5px solid green";
        }

        li.appendChild(points);
        li.appendChild(color);
        li.appendChild(attempts);
        table.appendChild(li);
    }
}

function renderSpeed() {
    var table = document.getElementById("table");
    var columns = document.getElementById("cols");
    columns.style.visibility = "hidden";

    for (var i = 0; i < 2; i++) {
        var speed = document.createElement("div");
        speed.className = "speedBox";
        speed.id = "speed_" + i;
        var title = document.createElement("b");
        title.appendChild(document.createTextNode("Attempt #" + (i+1)));
        speed.appendChild(title);
        speed.appendChild(document.createElement("br"));
        //speed.appendChild(document.createTextNode("Time: "));
        var time = document.createElement("input");
        time.className = "speedInput";
        time.type = "number";
        time.id = "time_" + i;
        speed.appendChild(time);
        speed.appendChild(document.createTextNode(" seconds"));

        var submitButton = document.createElement("button");
        submitButton.appendChild(document.createTextNode("Submit Time"));
        submitButton.className = "submitButton";
        submitButton.onclick = registerSpeed(time.id);
        speed.appendChild(submitButton);

        table.appendChild(speed);
    }
}

function renderClimbInfo(climbs, index) {
    return function () {
        clearClimbs();
        var columns = document.getElementById("cols");
        columns.style.visibility = "hidden";

        var table = document.getElementById("table");
        var climb = climbs[index];

        var properties = ["name", "points", "color", "discipline", "grade", "locations",
            "notes", "attempts", "sent"]; // NOTE THAT THE CLEARCLIMBS IS HARDCODED TO 9
        for (i = 0; i < properties.length; i++) {
            if (climb[properties[i]]) {
                var li = document.createElement("li");
                li.id = i;
                var div = document.createElement("div");
                li.className = "info";
                div.className = "info";
                div.appendChild(document.createTextNode(
                    "" + properties[i].charAt(0).toUpperCase() + properties[i].slice(1)
                    + ": " + climb[properties[i]]
                ));
                li.appendChild(div);
                table.appendChild(li);
            }
        }

        var attempt = document.createElement("button");
        attempt.className = "registerButton";
        attempt.id = i; i++;
        attempt.appendChild(document.createTextNode("Register Attempt"));
        attempt.onclick = registerAttempt(climbs, index, climb.id);
        table.appendChild(attempt);

        var send = document.createElement("button");
        send.className = "registerButton";
        send.id = i; i++;
        send.appendChild(document.createTextNode("Register Send"));
        send.onclick = registerSend(climbs, index, climb.id);
        table.appendChild(send);
    };
}
/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// Register new climbs with the server
function registerAttempt(climbs, index, climbId) {
    return function () {
        $.ajax({
            url: "/routes/" + climbId + "/attemptClimb",
            method: "put"
        }).done(function(climb) {
            CLIMBS[index].attempts = climb.attempts;
            renderClimbInfo(CLIMBS, index)();
        });
    };
}

function registerSend(climbs, index, climbId) {
    return function () {
        $.ajax({
            url: "/routes/" + climbId + "/sendClimb",
            method: "put"
        }).done(function(climb) {
            CLIMBS[index].sent = "Yes!";
            CLIMBS[index].attempts = climb.attempts;
            renderClimbInfo(CLIMBS, index)();
        });
    };
}

function registerSpeed(timeId) {
    return function () {
        var time = document.getElementById(timeId).value;
        $.ajax({
            url: "/scoresheet/speed",
            method: "put",
            data: {time: time}
        }).done(function(climb) {
            if (!climb.error) {
                document.getElementById(timeId).setAttribute('readonly', true);
                document.getElementById(timeId).style.backgroundColor = "gray";
            }
        });
    };
}
/////////////////////////////////////////////////////////////////////////////////

function clearClimbs() {
    for (var i = 0; i < CLIMBS.length; i++) {
        var climb = document.getElementById("" + i);
        if (climb) {
            climb.remove();
        }
    }
    for (var i = 0; i < 9 + 3; i++) {
        var note = document.getElementById("" + i);
        if (note) {
            note.remove();
        }
    }
    for (var i = 0; i < 2; i++) {
        var speed = document.getElementById("speed_" + i);
        if (speed) {
            speed.remove();
        }
    }
}
