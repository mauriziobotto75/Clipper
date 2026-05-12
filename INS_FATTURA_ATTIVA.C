
struct FatturaAttiva {
    char codFatt[11];
    char data[11];      // formato GG/MM/AAAA
    char codSoc[11];
    char codOrd[11];
    double importo;
    bool pagata;
};
/*--------------------------------------------------
   Funzione che controlla se una fattura esiste
--------------------------------------------------*/
bool fatturaEsistente(const char* codice) {
    FatturaAttiva f;
    ifstream file("FATTA.dat", ios::binary);

    if (!file) return false;

    while (file.read((char*)&f, sizeof(FatturaAttiva))) {
        if (strcmp(f.codFatt, codice) == 0) {
            file.close();
            return true;
        }
    }

    file.close();
    return false;
}
#include <iostream>


#include <fstream>
#include <cstring>
using namespace std;


int main()
{
using namespace std;





/*--------------------------------------------------
   MAIN
--------------------------------------------------*/
int main() {
    FatturaAttiva fatt;
    char risposta;

    cout << "INSERIMENTO FATTURA ATTIVA\n\n";

    cout << "Codice Fattura: ";
    cin >> fatt.codFatt;

    if (strlen(fatt.codFatt) == 0) {
        cout << "Codice obbligatorio.\n";
        return 0;
    }

    if (fatturaEsistente(fatt.codFatt)) {
        cout << "Codice gia' presente in archivio!\n";
        return 0;
    }

    cout << "Data (GG/MM/AAAA): ";
    cin >> fatt.data;

    cout << "Codice Societa': ";
    cin >> fatt.codSoc;

    cout << "Codice Ordine: ";
    cin >> fatt.codOrd;

    cout << "Importo: ";
    cin >> fatt.importo;

    cout << "Pagata? (s/n): ";
    cin >> risposta;
    fatt.pagata = (risposta == 's' || risposta == 'S');

    ofstream file("FATTA.dat", ios::binary | ios::app);
    file.write((char*)&fatt, sizeof(FatturaAttiva));
    file.close();

    cout << "\nFattura attiva inserita correttamente!\n";

    return 0;
}
}
