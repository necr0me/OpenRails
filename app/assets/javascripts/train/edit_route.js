function inputKeyUpRoute(input)
{
    var filter, ul, li, button , i, txtValue;
    filter = input.value.toUpperCase();
    ul = document.getElementById("routeAccordion");
    li = ul.getElementsByClassName('accordion-item');

    // Loop through all list items, and hide those who don't match the search query
    for (i = 0; i < li.length; i++) {
        button = li[i].getElementsByTagName("button")[0];
        txtValue = button.textContent || button.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}

function accClick(event)
{
    if (event.target.tagName === 'BUTTON')
    {
        let targetId = event.target.dataset.bsTarget.substring('#route-'.length)
        if (targetId === route)
            route = ""
        else
            route = targetId
    }
    console.log(route)
}
