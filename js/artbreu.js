/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var alfabet = ["B", "C", "D", "E", "F", "G", "H", "I", "K"];
var A = ["bondat/bonesa", "magnitud/grandesa", "eternitat/duració", "poder/potestat",
    "saviesa/instint", "voluntat/apetit", "virtut", "veritat", "glòria"];
var T = ["diferència", "concordança", "contrarietat", "començament",
    "mitjà", "fi", "majoritat", "igualtat", "menoritat"];
var cambres = [];
var columna = 0;
const myWindow = window.open("", "_blank", "width=900, height=666, left=15, top=15,\n\
    location=0, menubar=0, resizable=0, scrollbars=0, status=0, titlebar=0, toolbar=0");

function generar_columnes() {
    myWindow.document.open();
    myWindow.document.write("<html><head><title>Combinatòria Figura Quarta" +
        "</title></head><body style='background-size: 320px 302px; " + 
        'background-image: url("img/password.png"); background-repeat: no-repeat;' + "'>" + 
        "<table border='1' style='border-collapse: collapse'>" +
        "<tr><th>Col.");
    for (var cambra = 1; cambra <= 20; cambra++) {
        if (cambra < 10) cambra = "0" + cambra.toString();
        myWindow.document.write("</th><th>" + cambra);
    }
    myWindow.document.write("</th></tr>");
    for (var i = 0; i <= 6; i++) {
        for (var j = i + 1; j <= 7; j++) {
            for (var k = j + 1; k <= 8; k++) {
                columna++;
                if (columna < 10) columna = "0" + columna.toString();
                myWindow.document.write("<tr><td><b><center>" + columna + "</center></b></td>")

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
    for (var i = 0; i <= 3; i++) {
        for (var j = i + 1; j <= 4; j++) {
            for (var k = j + 1; k <= 5; k++) {
                // myWindow.document.write("<td>" + cambres[i] + cambres[j] + cambres[k] + "</td>")
                generar_sortida(i, j, k, cambres[i], cambres[j], cambres[k])
            }
        }        
    }    
}

function generar_sortida(i, j, k, u1, u2, u3) {
    if (i == 3) {
        myWindow.document.write("<td>" + "t" + u1 + u2 + u3 + "</td>");
    } else if ((j >= 3) && (j <= 4)) {
        myWindow.document.write("<td>" + u1 + "t" + u2 + u3 + "</td>");
    } else if ((k >= 3) && (k <= 5)) {
        myWindow.document.write("<td>" + u1 + u2 + "t" + u3 + "</td>");
    } else  {
        myWindow.document.write("<td>" + u1 + u2 + u3 + "</td>");        
    }
}
