const fs = require('fs');
const { DOMParser, XMLSerializer } = require('xmldom');

// Read XML file content
const xmlContent = fs.readFileSync('C:\\Users\\AONE MANAGEMENT\\OneDrive\\Desktop\\structureCont\\kdxml\\RSOS-231309 - B copy.xml', 'utf8');

// Parse XML content
const parser = new DOMParser();
const xmlDoc = parser.parseFromString(xmlContent, 'text/xml');

// Remove <workflow> tags and its contents
const workflowElements = xmlDoc.getElementsByTagName('workflow');
while (workflowElements.length > 0) {
    const workflowElement = workflowElements[0];
    workflowElement.parentNode.removeChild(workflowElement);
}

// Remove <production-house> tags and its contents
const productionNotesElements = xmlDoc.getElementsByTagName('production-notes');
while (productionNotesElements.length > 0) {
    const productionNotesElement = productionNotesElements[0];
    productionNotesElement.parentNode.removeChild(productionNotesElement);
}

// Serialize XML back to string
const serializedXml = new XMLSerializer().serializeToString(xmlDoc);

// Write modified XML content back to file
fs.writeFileSync('RSOS-231309 - B copy2.xml', serializedXml);
