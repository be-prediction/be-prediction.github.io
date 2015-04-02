function invest() {
    k = $("#k").val();
    b = $("#b").val();
    sc = Number($("#sc").val())/100;
    i = Number($("#i").val());
    investtype = $("input[type='radio'][name='investtype']:checked").attr('id');
    mc = marketchange(i,sc,k,b,investtype);
    $("#s1").text(round(mc.s1));
    $("#s2").text(round(mc.s2));
    $("#s").text(round(mc.s));
    $("#p1").text(round(mc.p1));
    $("#p2").text(round(mc.p2));
    if (round(mc.p1) === round(mc.p2)){
        $("#p").text(0);
        $("#avgp").text(0);
    } else {
        $("#p").text(round(mc.p));
        $("#avgp").text(round(mc.avgp));
    };
    $("#pc").text(round(-Math.abs(i)));
};

function sell(origin) {
    // Calculate initial stuff
    k = $("#k").val();
    b = $("#b").val();
    sc1 = Number($("#s_sc1").val())/100;
    $("#p1").text($("#s_sc1").val());
    i = Number($("#s_i").val());
    selltype = $("input[type='radio'][name='selltype']:checked").attr('id');
    mc1 = marketchange(i,sc1,k,b,selltype);
    $("#s_sh").text(round(mc1.s)); // Shares held based on initial purchase
    // Don't update current position score if changing certain parameters:
    if (origin!="s_sc2" && origin!="s_ps" && origin!="b" && origin!="k"){
        $("#s_sc2").val(round(mc1.p2));
    }
    sc2 = Number($("#s_sc2").val())/100;
    s1 = scoreToNetSales(sc1,b);
    $("#s1").text(round(s1));
    sw = shareWorth(sc2,mc1.s,b,k);
    $("#s_sw").text(round(sw));
    $("#s_ps").attr('max', round(sw));
    if (sw < $("#s_ps").val()){
        $("#s_ps").val(round(sw));
    };
    //ps = Number($("#s_ps").val());
    //ps = Number($("#s_ps").val());
    mc2 = marketchange(0,sc2,k,b,selltype);
    $("#s2").text(round(mc2.s2));
    $("#s").text(-round(mc2.s));
    $("#p2").text(round(mc2.p2));
    if (round(mc2.p1)==round(mc2.p2)){
        $("#p").text(0);
        $("#avgp").text(0);
    } else {
        $("#p").text(round(mc2.p));
        $("#avgp").text(round(mc2.avgp));
    }
    //$("#pc").text(round(ps));
}

function riskreduce(){
    invest();
    k = $("#k").val();
    b = $("#b").val();
    sc = Number($("#r_sc").val())/100;
    s1 = scoreToNetSales(sc,b);
    i = Number($("#r_i").val());
    s = i/k;
    i_l = b*k*(Math.log(1+Math.exp((s+s1)/b))-Math.log(1+Math.exp(s1/b)));
    i_s = i-i_l;
    $("#r_long").text(round(i_l));
    $("#r_short").text(round(i_s));
    $("#pc").text(round(-Math.abs(i)));
    $("#s").text(round(s) + " long / " + -round(s) + " short");
}

function round(num) {
    rounded = Math.round(100*num)/100
    return rounded
}

function marketchange(investment,yesScore,kprm,bprm,position){
    p1 = yesScore*100;
    s1 = scoreToNetSales(yesScore,bprm);
    if (position=="short"){
        s1 = -s1; // Convert net sales in yes to net sales in no)
    }
    s2 = Math.log(Math.exp(investment/(bprm*kprm)+Math.log(1+Math.exp(s1/bprm)))-1)*bprm; // s2 in either yes or no market
    if (position=="short"){
        // Convert everything back to yes_sales:
        s1 = -s1;
        s2 = -s2;
    }
    s = s2-s1;
    p2 = 100 * Math.exp(s2/bprm)/(Math.exp(s2/bprm)+1);
    p = p2-p1;
    avgp = Math.abs(100/k*(investment / s));
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
    if (shares>=0){
        s1 = scoreToNetSales(score,b);
    } else if(shares<0){
        s1 = -scoreToNetSales(score,b);
    }
    s2 = s1 - Math.abs(shares);
    points = -netSalesToPoints(s1,s2,b,k);
    return points;
}



$(document).ready(function () {

    $('#transaction').change(function () {
        selectedType = $('#type').val();
        $('.alert').hide();
        if (selectedType == "sell"){
            $('#invest').hide();
            $('.invest').hide();
            sell();
            $('.shareworth').show();
            $('#sell').show();
        } else if (selectedType == "invest"){
            $('#sell').hide();
            $('.shareworth').hide();
            invest();
            $('.invest').show();
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
            } else if (selectedType=="riskreduce"){
                riskreduce();
            }
        } else if ($(this).val()<Number(this.min)  && this.hasAttribute("min")){
            $(this).val(Number(this.min));
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell(this.id);
            } else if (selectedType=="riskreduce"){
                riskreduce();
            }
        } else {
            if (selectedType=="invest"){
                invest();
            } else if (selectedType=="sell"){
                sell(this.id);
            } else if (selectedType=="riskreduce"){
                riskreduce();
            }
        };
    }); 


    $('.input').change(function () {
        selectedType = $('#type').val();
        if (selectedType=="invest"){
            invest();
        } else if (selectedType=="sell"){
            sell(this.id);
        } else if (selectedType=="riskreduce"){
            riskreduce();
        }
    }); 

    $('#investtype, #selltype').change(function () {
        selectedType = $('#type').val();
        if (selectedType=="invest"){
            invest();
        } else if (selectedType=="sell"){
            sell(this.id);
        }
    }); 
});