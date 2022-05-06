function inputKeyUp()
{
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById('station-search-input');
    filter = input.value.toUpperCase();
    ul = document.getElementById("station-ul");
    li = ul.getElementsByTagName('li');

    // Loop through all list items, and hide those who don't match the search query
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}

function showStations()
{
    connectionsToAdd.length = 0;
    var stations = document.getElementsByClassName("stations_to_choose");
    for (var i = 0; i<stations.length; i++)
    {
        var station = stations.item(i);
        if (station.dataset.chosen === 'true')
        {
            station.style.backgroundColor = 'cornflowerBlue';
            station.style.color = 'white';
            connectionsToAdd.push(station.id.substring(offsetIndex));
        }
    }
}

function stationClick(id)
{
    const value = id.substring(offsetIndex)
    const station = document.getElementById(id)
    if(station.dataset.chosen === 'true')
    {
        const index = connectionsToAdd.indexOf(value);
        if (index !== -1) {
            connectionsToAdd.splice(index, 1);
        }
        station.style.backgroundColor = "#eee";
        station.style.color = 'black';
        station.dataset.chosen = 'false';
    }
    else
    {
        connectionsToAdd.push(value);
        station.style.backgroundColor = 'cornflowerBlue';
        station.style.color = 'white';
        station.dataset.chosen = 'true';
    }
    console.log(connectionsToAdd)
}