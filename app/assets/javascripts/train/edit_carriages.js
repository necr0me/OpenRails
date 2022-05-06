function inputKeyUp(input)
{
    var filter, ul, li, a, i, txtValue;
    filter = input.value.toUpperCase();
    ul = document.getElementById("carriage-ul");
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

function carriageClick(id)
{
    const value = id.substring(carriageOffsetIndex)
    const carriage = document.getElementById(id)
    if (newCarriage === "")
    {
        paintListItem(carriage, 'cornflowerBlue', 'white', 'true')
        newCarriage = value;
    }
    else
    {
        if(carriage.dataset.chosen === 'true')
        {
            paintListItem(carriage, '#eee', 'black', 'false')
            newCarriage = "";
        }
        else
        {
            const prevCarriage = document.getElementById('carriage-' + newCarriage);
            paintListItem(prevCarriage, '#eee', 'black', 'false')
            paintListItem(carriage, 'cornflowerBlue', 'white', 'true')
            newCarriage = value;
        }
    }
    console.log(newCarriage)
}

function paintListItem(item, bgColor, color, choose)
{
    item.style.backgroundColor = bgColor;
    item.style.color = color;
    item.dataset.chosen = choose;
}