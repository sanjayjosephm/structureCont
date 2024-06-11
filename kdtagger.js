var fs = require('fs');
var path = require('path');
var xsltproc = require('xsltproc')

function kdtagger() {
    return new Promise(async function (resolve, reject) {
        var xmlPath = path.resolve('C:/Users/Muthu Kumar/Downloads/structureCont-20240603T051903Z-001/structureCont/db/xml/newFile.xml')
        var dataOutput = fs.readFileSync(xmlPath)
        var html2XMLXSLDoc = path.resolve('C:/Users/Muthu Kumar/Downloads/structureCont-20240603T051903Z-001/structureCont/db/xslt/JATS2HTML.xsl');
        var d = new Date();
        var inputFile  = path.resolve('./tmp/'+'_' + d.getMinutes + 'sample.xml');
        var outputFile = 'newDoi.xml'
        fs.writeFileSync(inputFile, dataOutput);

        var xslt = xsltproc.transform(html2XMLXSLDoc, inputFile, {
            "output" : outputFile
        });

        xslt.stdout.on('data', function (data) {
            console.log('xsltproc stdout: ' + data);
        });
            
        xslt.stderr.on('data', function (data) {
            console.log('xsltproc stderr: ' + data);
        });
        console.log("Done");
    })
}


kdtagger();