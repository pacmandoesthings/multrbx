;(function () {
    //by convention, all dropdownNav styling should use the class 'active'
    //apply attr 'data-drop-down-nav-container' to the container
    //apply attr 'drop-down-nav-button' to the button
    //this module will run it's self; also note it works for click and hover
    var dropDownNavContainers;
    var dropDownNavButtons;
      
    $(function() {
        dropDownNavContainers = $('[data-drop-down-nav-container]');
        dropDownNavButtons = $('[drop-down-nav-button]');
        
        $('[drop-down-nav-button]').bind('click', openDropDownNavClick);
        $('[drop-down-nav-button]').bind('mouseenter', openDropDownNavHover);
    });

    function showDropDownNav(event) {
        var clicked = $(event.target);
        if (!clicked.attr('drop-down-nav-button')) {
            clicked = clicked.parents('[drop-down-nav-button]');
        }
        clicked.addClass('active');
        var navName = clicked.attr('drop-down-nav-button');
        var navcontainer = dropDownNavContainers.filter('[data-drop-down-nav-container="' + navName + '"]');
        navcontainer.show();
        dropDownNavContainers.not(navcontainer).hide();
        dropDownNavButtons.not(clicked).removeClass('active');
        event.stopPropagation();
        clicked.trigger('showDropDown');
        
    }
    function openDropDownNavHover(event) {
        $('[drop-down-nav-button]').unbind('click', openDropDownNavClick);
        showDropDownNav(event);
        $('[drop-down-nav-button]').bind('mouseleave', closeDropDownNavHover);
    }
    function closeDropDownNavHover() {
        hideDropDownNavs();
        $('[drop-down-nav-button]').unbind('mouseleave', closeDropDownNavHover);
    }
    
    function openDropDownNavClick(event) {
        $('[drop-down-nav-button]').unbind('mouseenter', openDropDownNavHover);
        showDropDownNav(event);
        $(document).bind('click', function(event) {
            hideDropDownNavs();
        });
        $('[drop-down-nav-button]').bind('click', closeDropDownNavClick);
    }
    function closeDropDownNavClick() {
        $(document).unbind('click', function(event) {
            hideDropDownNavs();
        });
        hideDropDownNavs();
        $('[drop-down-nav-button]').bind('click', showDropDownNav);
    }

    function hideDropDownNavs() {
        dropDownNavContainers.hide();
        dropDownNavButtons.removeClass('active');
    }
})();