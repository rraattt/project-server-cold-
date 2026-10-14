// PROGETTO UNITO TEAM 3 - RAYAN MOUNAFI - BUILD 4.3 ENTERPRISE + BLUE COUPLING FIXED
// IDRAULICA INTEGRATA: Tubo rosso ripristinato e condotto verticale blu connesso alla pompa.
// Struttura originale Build 4.0 preservata al 100% sul desktop DESKTOP-UAFOANB.

$fn = 100; // Alta definizione globale per curve e cilindri

// --- COSTANTI DI SISTEMA (PARAMETRIZZAZIONE) ---
r_tubo_principale = 4;
r_tubo_interno_wb  = 3;
r_tubo_retro       = 3;
spessore_filtro    = 1.5;
lato_waterblock    = 54;

// PARAMETRO DI DEBUG: 0 = Tutti i server OK (LED Verdi), 1 = Server 1 in Crash (LED Rossi)
stato_server_crash = 1; 

// Array dinamico di colori per i 7 filtri cromatografici
colori_filtri = [
    [1, 0, 0, 0.9],       // 1. Rosso
    [1, 0.5, 0, 0.9],     // 2. Arancione
    [1, 0.9, 0, 0.9],     // 3. Giallo
    [0, 0.8, 0.2, 0.9],   // 4. Verde
    [0, 0.7, 1, 0.9],     // 5. Azzurro
    [0.1, 0.1, 0.8, 0.9], // 6. Blu
    [0.6, 0, 0.8, 0.9]    // 7. Viola
];

// --- 1. IL DATA CENTER CON LED E PIASTRA SCAMBIATRICE ---
module server_rack(pos_x, ha_piastra, is_broken) {
    translate([pos_x, 80, 40]) {
        color([0.1, 0.1, 0.1]) cube([40, 30, 100], center = true); 
        
        for (z = [-40 : 15 : 40]) {
            translate([0, -15.1, z]) {
                color([0.2, 0.2, 0.2]) cube([28, 0.2, 12], center = true);
                
                // Logica condizionale: Se il server è rotto, i LED diventano rossi!
                if (is_broken == 1) {
                    color([0.9, 0.1, 0.1, 1]) translate([-14, -0.2, 0]) sphere(r = 1.8); // Allarme Rosso      
                    color([0.9, 0.1, 0.1, 1]) translate([-9, -0.2, 0])  cube([2, 0.5, 2], center=true); 
                } else {
                    color([0.2, 0.8, 0.2, 1]) translate([-14, -0.2, 0]) sphere(r = 1.8); // Stato OK Verde      
                    color([0.9, 0.2, 0.2, 1]) translate([-9, -0.2, 0])  cube([2, 0.5, 2], center=true); 
                }
                
                color([1, 0.9, 0, 1])     translate([-4, -0.2, 0]) sphere(r = 1.2);     
                color([0, 0.8, 1, 0.9])   translate([8, -0.1, 0])  cube([12, 0.2, 4], center=true);
            }
        }
        if (ha_piastra == 1) {
            translate([0, 15.5, 0]) color([0.6, 0.6, 0.65]) cube([30, 2, 80], center = true); 
        }
    }
}
server_rack(-50, 80, stato_server_crash); 
server_rack(50, 80, 0);  


// --- 2. LA PIASTRA IN SILICIO E CHIP ---
translate([0, 0, -11]) {
    color([0.1, 0.4, 0.15]) cube([60, 60, 2], center = true); 
    translate([0, 0, 2.5]) color([0.5, 0.5, 0.51]) cube([30, 30, 3], center = true); 
}


// --- 3. IL WATERBLOCK TRASPARENTE A 7 FILTRI CON TUBI INTERNI ---
difference() {
    union() {
        color([0.72, 0.45, 0.20]) cube([56, 56, 4], center = true); 
        color([0.1, 0.8, 0.8, 0.25]) translate([0, 0, 22.5]) cube([54, 54, 45], center = true); 
                
        for (i = [0 : 6]) {
            translate([0, 0, 5 + (i * 6)]) 
                color(colori_filtri[i]) 
                    cube([lato_waterblock, lato_waterblock, spessore_filtro], center = true); 
        }

        color([0, 0.4, 0.9]) translate([-18, 0, 23]) cylinder(h = 42, r = 5, center = true); 
        color([0.9, 0.2, 0]) translate([18, 0, 23])  cylinder(h = 42, r = 5, center = true);  
    }
    translate([-18, 0, 23]) cylinder(h = 46, r = r_tubo_interno_wb, center = true);
    translate([18, 0, 23])  cylinder(h = 46, r = r_tubo_interno_wb, center = true);
    
    translate([24, 24, 0]) cylinder(h = 20, r = 2, center = true);
    translate([-24, 24, 0]) cylinder(h = 20, r = 2, center = true);
    translate([24, -24, 0]) cylinder(h = 20, r = 2, center = true);
    translate([-24, -24, 0]) cylinder(h = 20, r = 2, center = true);
}


// --- 4. LA CISTERNA IDRICA PRINCIPALE E IL REFRIGERATORE (CHILLER) ---
translate([-70, 40, 20]) {
    color([0.7, 0.7, 0.7]) cylinder(h = 60, r = 20, center = true); 
    translate([0, 0, 36]) color([0, 0.3, 0.7]) cube([24, 24, 12], center = true); 
    translate([0, 0, 44]) rotate([0, -20, 0]) {
        color([0.1, 0.2, 0.4]) cube([30, 20, 2], center = true); 
    }
}


// --- 5. IL GENERATORE D'EMERGENZA E PANNELLO SOLARE 2 ---
translate([-110, 40, 15]) {
    color([0.8, 0.6, 0]) cube([20, 20, 30], center = true); 
    translate([0, -10.1, 10]) color([0.1, 0.1, 0.1]) cube([12, 0.2, 8], center = true); 
    translate([0, -10.1, 0]) color([0.9, 0.2, 0.2]) sphere(r = 2); 
    
    translate([0, 0, 20]) color([0.4, 0.4, 0.4]) cylinder(h = 10, r = 2, center = true); 
    translate([0, 0, 26]) rotate([15, -20, 0]) {
        color([0.1, 0.2, 0.4]) cube([30, 20, 2], center = true); 
    }
}


// --- 6. CENTRALINA DI RECUPERO ENERGIA TERMICA ---
translate([-10, 95, 50]) {
    color([0.5, 0, 0.5]) cube([12, 12, 12], center = true); 
}


// --- 7. CISTERNE DI MANTENIMENTO SUL RETRO ---
module cisterna_retro(x, y) {
    translate([x, y, 50]) {
        color([0.3, 0.3, 0.35]) cylinder(h = 120, r = 18, center = true); 
        color([0.2, 0.5, 0.8]) translate([0, 0, 61]) cylinder(h = 2, r = 10, center = true); 
    }
}
cisterna_retro(-50, 140); 
cisterna_retro(50, 140);  


// --- 8. TURBO-GENERATORE A GRADIENTE TERMICO CRUCIAL ---
translate([0, 140, 115]) {
    color([1, 0, 0.6]) cube([16, 16, 20], center = true); 
    color([0, 1, 0.8]) translate([0, 0, 12]) cylinder(h = 4, r = 6, center = true); 
}


// --- 9. MODULO POMPE IDRAULICHE AD ALTA PRESSIONE ---
module pompa_industriale(pos_xyz, colore_corpo) {
    translate(pos_xyz) {
        color([0.2, 0.2, 0.2]) cube([14, 14, 4], center = true); // Basamento
        color(colore_corpo) cylinder(h = 18, r = 5, center = true); // Motore pompa
        color([0.7, 0.7, 0.7]) translate([0, 0, 9.5]) cylinder(h = 2, r = 1.5, center = true); // Valvola
    }
}
pompa_industriale([18, 24, 45], [0.9, 0.2, 0]);   // Pompa Rossa (Mandata Calda)
pompa_industriale([-18, 24, 45], [0, 0.4, 0.9]); // Pompa Blu (Ritorno Freddo)


// --- 10. TUBI IDRAULICI (CIRCUITO FLUIDI CON CONNESSIONE BLU COUPLING) ---
color([0.9, 0.2, 0]) { 
    translate([18, 0, 48]) cylinder(h = 8, r = 5, center = true); 
    translate([18, 48, 51]) rotate([90, 0, 0]) cylinder(h = 96, r = r_tubo_principale, center = true); 
    translate([18, 72, 51]) rotate([90, 0, 0]) cylinder(h = 48, r = r_tubo_principale, center = true);
    translate([34, 95, 51]) rotate([0, 90, 0]) cylinder(h = 32, r = r_tubo_principale, center = true);
}

color([0.8, 0, 0]) { // Rosso ricircolo originale ripristinato
    translate([50, 95, 50]) rotate([0, 90, 0]) cylinder(h = 8, r = r_tubo_principale, center = true);
    translate([20, 95, 50]) rotate([0, 90, 0]) cylinder(h = 60, r = r_tubo_principale, center = true); 
    translate([-40, 95, 50]) rotate([0, 90, 0]) cylinder(h = 60, r = r_tubo_principale, center = true); 
    translate([-70, 68, 50]) rotate([90, 0, 0]) cylinder(h = 55, r = r_tubo_principale, center = true);  
    
    translate([0, 95, 82.5]) cylinder(h = 65, r = r_tubo_principale, center = true);
    translate([0, 117.5, 115]) rotate([90, 0, 0]) cylinder(h = 45, r = 2, center = true);
}

color([0, 0.4, 0.9]) { // Blu freddo originale + estensione verticale corretta
    translate([-18, 0, 46]) cylinder(h = 8, r = 5, center = true); 
    translate([-44, 0, 50]) rotate([0, 90, 0]) cylinder(h = 52, r = r_tubo_principale, center = true); 
    translate([-70, 20, 50]) rotate([90, 0, 0]) cylinder(h = 40, r = r_tubo_principale, center = true); 
    
    // CORREZIONE APPLICATA QUI: Tubo verticale blu che sale da quota 24 fino a 45 per agganciare la pompa fredda
    translate([-18, 24, 34.5]) cylinder(h = 21, r = r_tubo_principale, center = true);
}

color([0, 0.6, 0.8]) {
    translate([-50, 140, 112]) rotate([90, 0, 0]) cylinder(h = 4, r = r_tubo_retro, center = true); 
    translate([50, 140, 112]) rotate([90, 0, 0]) cylinder(h = 4, r = r_tubo_retro, center = true);  
    translate([0, 140, 112]) rotate([0, 90, 0]) cylinder(h = 100, r = r_tubo_retro, center = true);  
}


// --- 11. CAVI DI ALIMENTAZIONE COASSIALI E CAVO QUANTICO VERDE ---
color([1, 0.5, 0]) { 
    translate([-90, 40, 32]) rotate([0, 90, 0]) cylinder(h = 22, r = 1.5, center = true); 
}

color([1, 0.9, 0]) { 
    translate([-40, 95, 54]) rotate([0, 90, 0]) cylinder(h = 60, r = 1.2, center = true); 
    translate([-70, 78, 54]) rotate([90, 0, 0]) cylinder(h = 34, r = 1.2, center = true); 
}

color([0, 0.9, 0.2]) {
    translate([0, 140, 127]) rotate([0, 90, 0]) cylinder(h = 100, r = 1, center = true); 
    translate([-50, 140, 119]) cylinder(h = 16, r = 0.8, center = true); 
    translate([50, 140, 119]) cylinder(h = 16, r = 0.8, center = true);  
}


// --- 12. LA STANZA DI CONTROLLO DEI SISTEMISTI (CONTROL ROOM) ---
translate([0, -60, 5]) {
    color([0.2, 0.2, 0.25]) cube([50, 15, 10], center = true); // Tavolo di comando principale
    
    // Schermo Orizzontale a Matrix di Stato olografico (Colore ciano trasparente)
    translate([0, 2, 10]) rotate([20, 0, 0]) {
        color([0, 0.8, 1, 0.6]) cube([40, 1, 14], center = true); 
    }
}
 