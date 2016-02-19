$(document).ready(getProfileInfoFromServer());

function getProfileInfoFromServer() {
    $.ajax({

    }).done(function(profile) {
        console.log(profile);
    });
}
