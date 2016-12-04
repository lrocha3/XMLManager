/*
 * File:   client.cpp
 * Author: Luis Rocha
 *
 */


#include "client.h"

void CreateClientDocument() {
    XMLDocument xmlDoc;
    XMLNode * pRoot = xmlDoc.NewElement("CLIENT");
    xmlDoc.InsertFirstChild(pRoot);
    XMLElement * pElement = xmlDoc.NewElement("ID");
    pElement->SetText(value);
    pRoot->InsertEndChild(pElement);
    xmlDoc.SaveFile("clients.xml");
}
