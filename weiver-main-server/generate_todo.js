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

let md = '# Weiver JSP Design Update Checklist\n\n';

jspFiles.forEach(filePath => {
  const content = fs.readFileSync(filePath, 'utf8');
  const fileName = path.basename(filePath);
  
  // Check criteria for "New Design System Applied"
  // E.g. inline body background, specific font classes
  const isApplied = content.includes('linear-gradient(180deg') || fileName === 'main.jsp' || fileName === 'musicalDetail.jsp';
  
  md += `- [${isApplied ? 'x' : ' '}] ${fileName}\n`;
});

fs.writeFileSync('todo.md', md, 'utf8');
console.log('todo.md generated.');
