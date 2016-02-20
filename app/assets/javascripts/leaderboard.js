$(document).ready(getLeaderBoardInfoFromServer);

LEADERS = {};

function getLeaderBoardInfoFromServer() {
    if (window.location.pathname.slice(0,6) != "/comps") {
        return;
    }
    $.ajax({
        url: window.location.pathname + "/leaders",
        method: 'get'
    }).done(function(leaders) {
        LEADERS = leaders;
        renderLeadersForGender(leaders, "males");
    });
}

function renderLeadersForGender(leaders, gender) {
    clearLeaders();
    focusLeaderTab(gender);
    renderLeadersForDiscipline(leaders, gender, "boulder");
    renderLeadersForDiscipline(leaders, gender, "sport");
    renderLeadersForDiscipline(leaders, gender, "speed");
}

function renderLeadersForDiscipline(leaders, gender, discipline) {
    var ul = document.getElementById(discipline);

    for (var i = 0, leader; leader = leaders[gender][discipline][i]; i++) {
        var li = document.createElement("li");
        li.id = discipline + i;

        var name = document.createElement("div");
        name.appendChild(document.createTextNode(leader.name));
        li.appendChild(name);

        var school = document.createElement("div");
        school.appendChild(document.createTextNode(leader.college_name));
        li.appendChild(school);

        var points = document.createElement("div");
        if (discipline !== "speed") {
            points.appendChild(
                document.createTextNode(leader[discipline + "_score"])
            );
            li.appendChild(points);
        } else {
            points.appendChild(document.createTextNode(leader.speed));
        }
        li.appendChild(points);

        ul.appendChild(li);
    }
}

function clearLeaders() {
    for (var j = 0, gender; gender = ["males", "females"][j]; j++) {
        for (var k = 0, type; type = ["boulder", "sport", "speed"][k]; k++) {
            for (var i = 0; i < LEADERS[gender][type].length; i++) {
                var li = document.getElementById(type+i);
                if (li) {
                    li.remove();
                }
            }
        }
    }
}

function focusLeaderTab(genderToFocus) {
    var males = $("#malesTab");
    var females = $("#femalesTab");
    var colleges = $("#collegesTab");
    var tabs = {males: males, females: females, colleges: colleges};
    for (var gender in tabs) {
        var tab = tabs[gender];
        if (!tab) {
            continue;
        }
        tab.addClass("inactive");
        tab.removeClass("active");
        if (gender == genderToFocus) {
            tab.addClass("active");
            tab.removeClass("inactive");
        }
    }
}
