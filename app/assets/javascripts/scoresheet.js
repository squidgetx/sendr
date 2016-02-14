var CLIMBS = [];

$(document).ready(function() {
    $.ajax({
        url: "/scoresheet/climbs",
    method: "get"
    }).done(function(climbs) {
        CLIMBS = climbs;
        renderClimbs(climbs, "");
    });
});

function renderClimbs(climbs, disciplineToHide) {
    clearClimbs();
    var table = document.getElementById("table");
    for (var i = 0, climb; climb = climbs[i]; i++) {
        if (climb.discipline == disciplineToHide) {
            continue;
        }
        var li = document.createElement("li");
        // li = li.appendChild(document.createElement("button"));
        // li.onclick = attemptClick(climbs, num);
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

function clearClimbs() {
    for (var i = 0; i < CLIMBS.length; i++) {
        var climb = document.getElementById("" + i);
        if (climb) {
            climb.remove();
        }
    }
}
