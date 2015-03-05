function invest() {
    k = $("#k").val();
    b = $("#b").val();
    sc = Number($("#sc").val())/100;
    i = Number($("#i").val());
    mc = marketchange(i,sc,k,b);
    $("#s1").text(round(mc.s1));
    $("#s2").text(round(mc.s2));
    $("#s").text(round(mc.s));
    $("#p1").text(round(mc.p1));
    $("#p2").text(round(mc.p2));
    if (round(mc.p1)==round(mc.p2)){
        $("#p").text(0);
        $("#avgp").text(0);
    } else {
        $("#p").text(round(mc.p));
        $("#avgp").text(round(mc.avgp));
    };
    $("#pc").text(round(-i));
};

function sell(origin) {
    // Calculate initial stuff
    k = $("#k").val();
    b = $("#b").val();
    sc1 = Number($("#s_sc1").val())/100;
    i = Number($("#s_i").val());
    mc1 = marketchange(i,sc1,k,b);
    $("#s_sh").text(round(mc1.s)); // Shares held based on initial purchase
    // Don't update current position score if changing certain parameters:
    if (origin!="s_sc2" && origin!="s_ps" && origin!="b" && origin!="k"){
        $("#s_sc2").val(mc1.p2);
    }
    sc2 = Number($("#s_sc2").val())/100;
    s1 = scoreToNetSales(sc2,b);
    $("#s1").text(round(s1));
    sw = shareWorth(sc2,mc1.s,b,k);
    $("#s_sw").text(round(sw));
    $("#s_ps").attr('max', round(sw));
    if (sw < $("#s_ps").val()){
        $("#s_ps").val(round(sw));
    }
    ps = Number($("#s_ps").val());
    mc2 = marketchange(-ps,sc2,k,b);
    $("#s2").text(round(mc2.s2));
    $("#s").text(-round(mc2.s));
    $("#p1").text(round(mc2.p1));
    $("#p2").text(round(mc2.p2));
    if (round(mc2.p1)==round(mc2.p2)){
        $("#p").text(0);
        $("#avgp").text(0);
    } else {
        $("#p").text(round(mc2.p));
        $("#avgp").text(round(mc2.avgp));
    }
    $("#pc").text(round(ps));
}

function round(num) {
    rounded = Math.round(100*num)/100
    return rounded
}

function marketchange(investment,yesScore,kprm,bprm){
    p1 = yesScore*100;
    s1 = scoreToNetSales(yesScore,bprm);
    s2 = Math.log(Math.exp((investment)/(bprm*kprm)+Math.log(1+Math.exp(s1/bprm)))-1)*bprm;
    s = s2-s1; // Note that s1, initial net sales, is calculated for the Yes position, and different from the no_s1
    p2 = 100 * Math.exp(s2/bprm)/(Math.exp(s2/bprm)+1);
    p = p2-p1;
    avgp = 100*(investment / s);
    return {s1: s1, s2: s2, s: s, p1: p1, p2: p2, p: p, avgp: avgp}
}

function scoreToNetSales(score,b){
    netSales = b * Math.log(score/(1-score));
    return netSales;
}

function netSalesToPoints(s1,s2,b,k){
    points = b * k * (Math.log(1+Math.exp(s2/b))-Math.log(1+Math.exp(s1/b)));
    return points;
}

function shareWorth(score,shares,b,k){
    s1 = scoreToNetSales(score,b);
    s2 = s1 - shares;
    points = -netSalesToPoints(s1,s2,b,k);
    return points;
}

function openInfo(param){
    $(param).toggle();
}

$(document).ready(function () {
    $('.close').click(function(){
        $(this).parent().hide();
    });
    
    $('#transaction').change(function () {
        selectedType = $('#type').val();
        $('.alert').hide();
        if (selectedType == "sell"){
            $('#invest').hide();
            $( "#impact" ).text( "Sale");
            $( ".trTypeD" ).text( "sold");
            $( ".trTypeID" ).text( "sold");
            $( ".trTypeT" ).text( "sale");
            sell();
            $('#sell').show();
        } else if (selectedType == "invest"){
            $('#sell').hide();
            $( "#impact" ).text( "Investment");
            $( ".trTypeD" ).text( "purchased");
            $( ".trTypeT" ).text( "investment");
            $( ".trTypeID" ).text( "invested");
            invest();
            $('#invest').show();  
        };
    });

    $('.maxInput').change(function () {
        selectedType = $('#type').val();
        if (($(this).val() > Number(this.max)) && this.hasAttribute("max")){
            $(this).val(Number(this.max));
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell(this.id);
            }
        } else if ($(this).val()<Number(this.min)  && this.hasAttribute("min")){
            $(this).val(Number(this.min));
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell(this.id);
            }
        } else {
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell(this.id);
            }
        };
    }); 


    $('.input').change(function () {
        selectedType = $('#type').val();
        if (selectedType=="invest"){
            invest();
        } else if (selectedType=="sell"){
            sell(this.id);
        }
    }); 
});