$(document).ready(getLeaderBoardInfoFromServer);

function getLeaderBoardInfoFromServer() {
    if (window.location.pathname.slice(0,6) != "/comps") {
        return;
    }
    $.ajax({
        url: window.location.pathname + "/leaders",
        method: 'get'
    }).done(function(leaders) {
        renderLeaders(leaders);
    });
}

function renderLeaders(leaders) {
    renderLeadersForDiscipline(leaders, "boulder");
    renderLeadersForDiscipline(leaders, "sport");
    renderLeadersForDiscipline(leaders, "speed");
}

function renderLeadersForDiscipline(leaders, discipline) {
    var ul = document.getElementById(discipline);

    for (var i = 0; i < leaders[discipline].length; i++) {
        var li = document.createElement("li");
        var name = document.createElement("div");
        name.appendChild(document.createTextNode(leaders[discipline][i].climber_id));
        li.appendChild(name);

        var points = document.createElement("div");
        if (discipline !== "speed") {
            points.appendChild(
                document.createTextNode(leaders[discipline][i][discipline + "_score"])
            );
            li.appendChild(points);
        } else {
            points.appendChild(document.createTextNode(leaders[discipline][i].speed));
        }
        li.appendChild(points);

        ul.appendChild(li);
    }
}
