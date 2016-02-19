$(document).ready(getLeaderBoardInfoFromServer());

function getLeaderBoardInfoFromServer() {
    console.log(window.location.pathname);
    $.ajax({
        url: window.location.pathname,
        method: 'get'
    }).done(function(leaderBoard) {
        console.log(leaderBoard);
    });
}
