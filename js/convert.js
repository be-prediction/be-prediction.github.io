function invest() {
    k = $("#k").val();
    b = $("#b").val();
    sc = Number($("#sc").val());
    i = Number($("#i").val());
    mc = marketchange2(i,sc,k,b);
    $("#s1").val(round(mc.s1));
    $("#s2").val(round(mc.s2));
    $("#s").val(round(mc.s));
    $("#p1").val(round(mc.p1));
    $("#p2").val(round(mc.p2));
    if (round(mc.p1)==round(mc.p2)){
        $("#p").val(0);
        $("#avgp").val(0);
    } else {
        $("#p").val(round(mc.p));
        $("#avgp").val(round(mc.avgp));
    };
    $("#pc").val(round(-i));
};

function sell() {
    k = $("#k").val();
    b = $("#b").val();
    sc1 = Number($("#s_sc1").val());
    sc2 = Number($("#s_sc2").val());
    i = Number($("#s_i").val());
    ps = Number($("#s_ps").val());
    mc1 = marketchange(i,sc1,k,b);
    $("#s_sh").val(round(mc1.s)); // Shares held based on initial purchase
    s1 = scoreToNetSales(sc2,b);
    $("#s1").val(round(s1));
    sw = shareWorth(sc2,mc1.s,b,k);
    $("#s_sw").val(round(sw));
    $("#s_ps").attr('max', round(sw));
    mc2 = marketchange(-ps,sc2,k,b);
    $("#s2").val(round(mc2.s2));
    $("#s").val(-round(mc2.s));
    $("#p1").val(round(mc2.p1));
    $("#p2").val(round(mc2.p2));
    if (round(mc2.p1)==round(mc2.p2)){
        $("#p").val(0);
        $("#avgp").val(0);
    } else {
        $("#p").val(round(mc2.p));
        $("#avgp").val(round(mc2.avgp));
    }
    $("#pc").val(round(ps));
}

function round(num) {
    rounded = Math.round(1000*num)/1000
    return rounded
}

function marketchange(investment,score,kprm,bprm){
    p1 = score*kprm;
    s1 = scoreToNetSales(score,bprm);
    //pointstozero = netSalesToPoints(
    s2 = Math.log(Math.exp((2*investment)/(bprm*kprm)+Math.log(1+Math.exp(2*s1/bprm)))-1)*(bprm/2);
    s = s2-s1;
    p2 = kprm * Math.exp(2*s2/bprm)/(Math.exp(2*s2/bprm)+1);
    p = p2-p1;
    avgp = investment / s;
    return {s1: s1, s2: s2, s: s, p1: p1, p2: p2, p: p, avgp: avgp}
}

function marketchange2(investment,yesScore,kprm,bprm){
    p1 = yesScore*kprm;
    s1 = scoreToNetSales(yesScore,bprm);
    if (investment>=0){
        // Initial net sales in yes position, correct Yes-score is yesScore
        s2 = Math.log(Math.exp((2*investment)/(bprm*kprm)+Math.log(1+Math.exp(2*s1/bprm)))-1)*(bprm/2);
    } else {
        // Initial net sales in no position, correct noScore is 1-yesScore
        no_s1 = scoreToNetSales(1-yesScore,bprm);
        // Net sales in yes position after sale (note minus sign since opposite sales in no position)
        s2 = -Math.log(Math.exp(-(2*investment)/(bprm*kprm)+Math.log(1+Math.exp(2*no_s1/bprm)))-1)*(bprm/2);
    }
    s = s2-s1; // Note that s1, initial net sales, is calculated for the Yes position, and different from the no_s1
    p2 = kprm * Math.exp(2*s2/bprm)/(Math.exp(2*s2/bprm)+1);
    p = p2-p1;
    avgp = investment / s;
    return {s1: s1, s2: s2, s: s, p1: p1, p2: p2, p: p, avgp: avgp}
}

function scoreToNetSales(score,b){
    netSales = 0.5 * b * Math.log(score/(1-score));
    return netSales;
}

function netSalesToPoints(s1,s2,b,k){
    points = 0.5 * b * k * (Math.log(1+Math.exp(2*s2/b))-Math.log(1+Math.exp(2*s1/b)));
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
                sell();
            }
        } else if ($(this).val()<Number(this.min)  && this.hasAttribute("min")){
            $(this).val(Number(this.min));
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell();
            }
        } else {
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell();
            }
        };
    }); 


    $('.input').change(function () {
        selectedType = $('#type').val();
        if (selectedType=="invest"){
            invest();
        } else if (selectedType=="sell"){
            sell();
        }
    }); 
});