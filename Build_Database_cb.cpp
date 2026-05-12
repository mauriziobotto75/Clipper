 // build_database_cb.cpp
// Code::Blocks + MinGW-w64 (C++17) - Crea tabelle .DBF (dBASE III+) + CDX placeholder.
// Differenze dal PRG VFP:
//   - 'I AUTOINC'     -> N(10,0) (niente autoincrement nativo dBase III)
//   - 'NOTE M (memo)' -> C(254)  (evitiamo FPT; posso fornirti variante con memo reali)

 // build_database_compat.cpp
// Versione compatibile Dev-C++ 5.11 (MinGW 4.9.2)
// Niente <filesystem>, niente C++11 necessario.

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <direct.h>     // _mkdir()
#include <iostream>
#include <string>
#include <vector>

struct Field {
    const char* name;   // max 11 chars
    char        type;   // 'C','N','L','D'
    unsigned char length;
    unsigned char dec;
};

// Crea una directory se non esiste
void make_dir(const char* dir) {
    _mkdir(dir);   // su Windows non da errore se esiste già
}

// Scrive un file DBF dBase III+ con 0 record
void write_dbf(const char* filename, const std::vector<Field>& fields) {
    FILE* f = fopen(filename, "wb");
    if (!f) {
        std::cout << "Errore creazione file: " << filename << "\n";
        return;
    }

    // Header DBF (32 bytes)
    unsigned char header[32];
    memset(header, 0, 32);

    header[0] = 0x03; // dBASE III (no memo)

    // Data odierna
    time_t t = time(NULL);
    struct tm* lt = localtime(&t);

    header[1] = (unsigned char)((lt->tm_year + 1900) - 1900); // YY
    header[2] = (unsigned char)(lt->tm_mon + 1);              // MM
    header[3] = (unsigned char)(lt->tm_mday);                 // DD

    // Numero record (4 byte LE) = 0
    // header_len
    unsigned short header_len = (unsigned short)(32 + fields.size() * 32 + 1);
    header[8]  = (unsigned char)(header_len & 0xFF);
    header[9]  = (unsigned char)((header_len >> 8) & 0xFF);

    // record_len = flag deleted (1 byte) + somma campi
    unsigned short record_len = 1;
    for (size_t i = 0; i < fields.size(); i++)
        record_len += fields[i].length;

    header[10] = (unsigned char)(record_len & 0xFF);
    header[11] = (unsigned char)((record_len >> 8) & 0xFF);

    fwrite(header, 1, 32, f);

    // Field descriptors (32 bytes ognuno)
    for (size_t i = 0; i < fields.size(); i++) {
        unsigned char fd[32];
        memset(fd, 0, 32);

        // Nome max 11 char
        for (int j = 0; j < 11; j++) {
            if (j < (int)strlen(fields[i].name))
                fd[j] = fields[i].name[j];
            else
                fd[j] = 0x00;
        }

        fd[11] = fields[i].type;     // Tipo
        fd[16] = fields[i].length;   // Lunghezza
        fd[17] = fields[i].dec;      // Decimali

        fwrite(fd, 1, 32, f);
    }

    // Terminatore
    unsigned char term = 0x0D;
    fwrite(&term, 1, 1, f);

    fclose(f);
}

// Funzione helper
void make_table(const char* outdir, const char* name, const std::vector<Field>& fields) {
    char dbf[256];
    char cdx[256];

    sprintf(dbf, "%s/%s.dbf", outdir, name);
    sprintf(cdx, "%s/%s.cdx", outdir, name);

    remove(dbf);
    remove(cdx);

    write_dbf(dbf, fields);

    // crea un CDX vuoto come placeholder
    FILE* f = fopen(cdx, "wb");
    if (f) fclose(f);

    std::cout << "Creato: " << dbf << " + " << cdx << "\n";
}

int main() {
    const char* OUTDIR = "DBF_OUT";
    make_dir(OUTDIR);

    // ================
    // TABELLE
    // ================

    make_table(OUTDIR, "PAGAMENT", {
        {"PAG_ID",'N',10,0},
        {"DESCR",'C',60,0},
        {"NUMRATE",'N',4,0},
        {"GG1",'N',4,0},
        {"GG2",'N',4,0},
        {"GG3",'N',4,0},
        {"FINEMES",'L',1,0},
        {"SCOSTA",'N',4,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "CLIENTI", {
        {"CLI_ID",'N',10,0},
        {"RAGSOC",'C',80,0},
        {"PIVA",'C',16,0},
        {"CFISC",'C',16,0},
        {"INDIR",'C',80,0},
        {"CAP",'C',5,0},
        {"CITTA",'C',40,0},
        {"PROV",'C',2,0},
        {"TEL",'C',20,0},
        {"EMAIL",'C',80,0},
        {"IDPAG",'N',10,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "FORNITOR", {
        {"FOR_ID",'N',10,0},
        {"RAGSOC",'C',80,0},
        {"PIVA",'C',16,0},
        {"CFISC",'C',16,0},
        {"INDIR",'C',80,0},
        {"CAP",'C',5,0},
        {"CITTA",'C',40,0},
        {"PROV",'C',2,0},
        {"TEL",'C',20,0},
        {"EMAIL",'C',80,0},
        {"IDPAG",'N',10,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "ARTICOLI", {
        {"ART_ID",'N',10,0},
        {"CODART",'C',30,0},
        {"DESCR",'C',80,0},
        {"UM",'C',6,0},
        {"PREZZO",'N',14,2},
        {"IVA_ALI",'N',5,2},
        {"BARCODE",'C',20,0},
        {"ATTIVO",'L',1,0},
        {"CATEG",'C',30,0}
    });

    make_table(OUTDIR, "ORDINI", {
        {"ORD_ID",'N',10,0},
        {"DATA",'D',8,0},
        {"IDCLI",'N',10,0},
        {"RIF",'C',30,0},
        {"DATCONS",'D',8,0},
        {"STATO",'C',1,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "BOLLE", {
        {"BOL_ID",'N',10,0},
        {"DATA",'D',8,0},
        {"NUMDOC",'C',20,0},
        {"IDCLI",'N',10,0},
        {"IDFOR",'N',10,0},
        {"IDORD",'N',10,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "FAT_ATT", {
        {"FAA_ID",'N',10,0},
        {"NUMDOC",'C',20,0},
        {"DATA",'D',8,0},
        {"IDCLI",'N',10,0},
        {"IDPAG",'N',10,0},
        {"IMPON",'N',14,2},
        {"IVA",'N',14,2},
        {"TOTALE",'N',14,2},
        {"SALDATO",'L',1,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "FAT_PAS", {
        {"FAP_ID",'N',10,0},
        {"NUMDOC",'C',20,0},
        {"DATA",'D',8,0},
        {"IDFOR",'N',10,0},
        {"IDPAG",'N',10,0},
        {"IMPON",'N',14,2},
        {"IVA",'N',14,2},
        {"TOTALE",'N',14,2},
        {"SALDATO",'L',1,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "SCADENZE", {
        {"SCA_ID",'N',10,0},
        {"TIPO",'C',1,0},
        {"IDDOC",'N',10,0},
        {"NUMRATA",'N',4,0},
        {"DTSCAD",'D',8,0},
        {"IMPORTO",'N',14,2},
        {"PAGATA",'L',1,0},
        {"DTPAG",'D',8,0},
        {"NOTE",'C',254,0}
    });

    make_table(OUTDIR, "RIGHE_DOC", {
        {"RIG_ID",'N',10,0},
        {"TIPO",'C',1,0},
        {"IDDOC",'N',10,0},
        {"RIGA",'N',4,0},
        {"IDART",'N',10,0},
        {"CODART",'C',30,0},
        {"DESCR",'C',80,0},
        {"QTA",'N',14,3},
        {"PREZZO",'N',14,2},
        {"SCONTO",'N',6,2},
        {"IVA",'N',5,2},
        {"TOTALE",'N',14,2}
    });

    std::cout << "\nTabelle create correttamente in DBF_OUT.\n";
    return 0;
}
