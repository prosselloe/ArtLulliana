/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var alfabet = ["B", "C", "D", "E", "F", "G", "H", ".I", "K"];
var A = ["bonesa", "grandesa", "eternitat", "poder",
    "saviesa", "voluntat", "virtut", "veritat", "glòria"];
var T = ["diferència", "concordança", "contrarietat", "començament",
    "mitjà", "fi", "majoritat", "igualtat", "menoritat"];
var cambres = [];
var columna = 0;
const myWindow = window.open("", "_blank", "width=912, height=666, left=15, top=15, \n\
        location=0, menubar=0, resizable=0, scrollbars=0, status=0, titlebar=0, toolbar=0");

function generar_columnes() {
    myWindow.document.open();
    myWindow.document.write("<html><head><title>Multipliació Quarta Figura" +
        "</title></head><body style='background-size: 320px 302px; " + 
        'background-image: url("img/password.png"); background-repeat: no-repeat;' + "'>" + 
        "<table border='1' style='border-collapse: collapse'>" +
        "<tr><th><span style='color:red'>co</span>/<span style='color:#0096FF'>ca");
    for (var cambra = 1; cambra <= 20; cambra++) {
        if (cambra < 10) cambra = "0" + cambra.toString();
        myWindow.document.write("</th><th><span style='color:#0096FF'>" + cambra);
    }
    myWindow.document.write("</span></th></tr>");
    for (var i = 0; i <= alfabet.length - 3; i++) {
        for (var j = i + 1; j <= alfabet.length - 2; j++) {
            for (var k = j + 1; k <= alfabet.length - 1; k++) {
                columna++;
                if (columna < 10) columna = "0" + columna.toString();
                myWindow.document.write("<tr><td><b><center><span style='color:red'>" + columna + 
                    "</span></center></b></td>")
                // myWindow.document.write("<td>" + alfabet[i] + alfabet[j] + alfabet[k] + "</td>")                
                generar_cambres(alfabet[i], alfabet[j], alfabet[k]);                
                myWindow.document.write("</tr>")                
            }
        }        
    }    
    myWindow.document.write("</table></body></html>");
    myWindow.document.close();            
}

function generar_cambres(u1, u2, u3) {
    cambres[0] = cambres[3] = u1;
    cambres[1] = cambres[4] = u2;
    cambres[2] = cambres[5] = u3;
    // window.alert(cambres);
    for (var i = 0; i <= alfabet.length - 6; i++) {
        for (var j = i + 1; j <= alfabet.length - 5; j++) {
            for (var k = j + 1; k <= alfabet.length - 4; k++) {
                // myWindow.document.write("<td>" + cambres[i] + cambres[j] + cambres[k] + "</td>")
                generar_sortida(i, j, k, cambres[i], cambres[j], cambres[k])
            }
        }        
    }    
}

function generar_sortida(i, j, k, u1, u2, u3) {
    if (i == alfabet.length - 6) {
        myWindow.document.write("<td title=" + 
            T[alfabet.indexOf(u1)] + "-" + 
            T[alfabet.indexOf(u2)] + "-" + 
            T[alfabet.indexOf(u3)] + ">" + 
            // "t" + u1 + u2 + u3 + "</td>");
            "<span style='color:blue'>t</span>" + 
            color_fons(u1) + 
            color_fons(u2) + 
            color_fons(u3) + 
            "</td>");
    } else if ((j >= alfabet.length - 6) && 
               (j <= alfabet.length - 5)) {
        myWindow.document.write("<td title=" + 
            A[alfabet.indexOf(u1)] + "-" + 
            T[alfabet.indexOf(u2)] + "-" + 
            T[alfabet.indexOf(u3)] + ">" + 
            // u1 + "t" + u2 + u3 + "</td>");
            "<span style='background-color:DodgerBlue'>" + u1 + 
            "</span><span style='color:blue'>t</span>" + 
            color_fons(u2) + 
            color_fons(u3) + 
            "</td>");
    } else if ((k >= alfabet.length - 6) && 
               (k <= alfabet.length - 4)) {
        myWindow.document.write("<td title=" + 
            A[alfabet.indexOf(u1)] + "-" + 
            A[alfabet.indexOf(u2)] + "-" + 
            T[alfabet.indexOf(u3)] + ">" + 
            // u1 + u2 + "t" + u3 + "</td>");
            "<span style='background-color:DodgerBlue;'>" + u1 + u2 + 
            "</span><span style='color:blue'>t</span>" + 
            color_fons(u3) + 
            "</td>");
    } else  {
        myWindow.document.write("<td title=" + 
            A[alfabet.indexOf(u1)] + "-" + 
            A[alfabet.indexOf(u2)] + "-" + 
            A[alfabet.indexOf(u3)] + ">" + 
            // u1 + u2 + u3 + "</td>");
            "<span style='background-color:DodgerBlue;'>" + u1 + u2 + u3 + 
            "</span><span style='color:blue'>t</span>" + 
            "</span></td>");        
    }
}

function color_fons(u0) {
    switch (alfabet.indexOf(u0)) {
        case 0: 
        case 1:
        case 2:
            return "<span style='background-color:LimeGreen;'>" + u0 + "</span>";
        case 3:
        case 4: 
        case 5:
            return "<span style='background-color:Tomato;'>" + u0 + "</span>";
        case 6:
        case 7:
        case 8:
            return "<span style='background-color:Yellow;'>" + u0 + "</span>";
    }    
}
