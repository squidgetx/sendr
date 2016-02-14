var CLIMBS = [];

$(document).ready(getClimbsFromServer());

function getClimbsFromServer() {
    $.ajax({
        url: "/scoresheet/climbs",
    method: "get"
    }).done(function(climbs) {
        CLIMBS = climbs;
        renderClimbs(climbs, "boulder");
    });
}

function renderClimbs(climbs, discipline) {
    clearClimbs();
    focusTab(discipline);
    if (discipline == "speed") {
        renderSpeed();
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

        li.appendChild(points);
        li.appendChild(color);
        li.appendChild(attempts);
        table.appendChild(li);
    }
}

function focusTab(discipline) {
    var boulder = document.getElementById("boulderTab");
    var sport = document.getElementById("sportTab");
    var speed = document.getElementById("speedTab");
    var tabs = {boulder: boulder, sport: sport, speed: speed};
    for (var disc in tabs) {
        var tab = tabs[disc];
        tab.style.width = "25%";
        tab.style.fontWeight = "normal";
        if (disc == discipline) {
            tab.style.width = "50%";
            tab.style.fontWeight = "bold";
        }
    }
}

function renderSpeed() {
    var columns = document.getElementById("cols");
    columns.style.visibility = "hidden";
}

function clearClimbs() {
    for (var i = 0; i < CLIMBS.length; i++) {
        var climb = document.getElementById("" + i);
        if (climb) {
            climb.remove();
        }
    }
    for (var i = 0; i < 8; i++) {
        var note = document.getElementById("" + i);
        if (note) {
            note.remove();
        }
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
            "notes", "attempts"]; // NOTE THAT THE CLEARCLIMBS IS HARDCODED TO 8
        for (var i = 0; i < properties.length; i++) {
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
    };
}
