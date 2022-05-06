function accClick(event)
{
    if (event.target.tagName === 'BUTTON')
    {
        let targetId = event.target.dataset.bsTarget.substring('#carriageType-'.length)
        if (targetId === carriageType)
            carriageType = ""
        else
            carriageType = targetId
    }
    console.log(carriageType)
}