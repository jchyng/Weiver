const fs = require('fs');
const path = require('path');

function findJspFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findJspFiles(filePath, fileList);
    } else if (filePath.endsWith('.jsp')) {
      fileList.push(filePath);
    }
  });
  return fileList;
}

const viewsDir = path.join(process.cwd(), 'src/main/webapp/WEB-INF/views');
const jspFiles = findJspFiles(viewsDir);

jspFiles.forEach(filePath => {
  let content = fs.readFileSync(filePath, 'utf8');

  // Fix tailwind class typo
  content = content.replace(/border-color: rgba\(251, 191, 36, 0.25\);/g, "");
  content = content.replace(/border-color: rgba\(251, 191, 36, 0.3\);/g, "");
  
  if (content.includes("box-shadow: 0 0 15px rgba(212, 175, 55, 0.3); border-color: rgba(212, 175, 55, 0.5);")) {
       // it's ok
  } else if (content.includes("box-shadow: 0 0 15px rgba(212, 175, 55, 0.3); border-color: rgba(212, 175, 55, 0.8);")) {
       // it's ok
  }

  // Update back links to use / paths
  content = content.replace(/href="\${baseURL}\/musicalDetail\//g, 'href="${baseURL}/musical-detail/');

  fs.writeFileSync(filePath, content, 'utf8');
});

console.log('Fixed JSP files.');
