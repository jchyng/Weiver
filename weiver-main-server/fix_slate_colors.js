const fs = require('fs');
const path = require('path');

const viewsDir = path.join(process.cwd(), 'src/main/webapp/WEB-INF/views');
const jspFiles = [];

function findJspFiles(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findJspFiles(filePath);
    } else if (filePath.endsWith('.jsp')) {
      jspFiles.push(filePath);
    }
  });
}
findJspFiles(viewsDir);

jspFiles.forEach(filePath => {
  let content = fs.readFileSync(filePath, 'utf8');

  // Replace Tailwind slate utility classes with theater theme classes
  content = content.replace(/bg-slate-900\/50/g, 'bg-black/60');
  content = content.replace(/bg-slate-900\/30/g, 'bg-black/40');
  content = content.replace(/bg-slate-900/g, 'bg-stage-bg');
  
  content = content.replace(/bg-slate-800\/50/g, 'bg-stage-surface/80');
  content = content.replace(/bg-slate-800/g, 'bg-stage-surface');
  
  content = content.replace(/border-slate-800\/50/g, 'border-white/5');
  content = content.replace(/border-slate-800/g, 'border-white/10');
  
  content = content.replace(/border-slate-700\/50/g, 'border-white/10');
  content = content.replace(/border-slate-700/g, 'border-white/20');
  
  content = content.replace(/border-slate-600/g, 'border-white/30');
  
  content = content.replace(/text-slate-700/g, 'text-stage-text-sub');
  content = content.replace(/text-slate-400/g, 'text-stage-text-sub');
  content = content.replace(/text-slate-900/g, 'text-black');
  
  content = content.replace(/decoration-slate-700/g, 'decoration-stage-secondary/50');
  
  content = content.replace(/hover:bg-slate-700/g, 'hover:bg-white/10');
  content = content.replace(/hover:bg-slate-800/g, 'hover:bg-white/5');
  content = content.replace(/hover:border-slate-700/g, 'hover:border-white/30');
  content = content.replace(/hover:border-slate-600/g, 'hover:border-white/40');
  
  // Fix CSS rgba colors representing slate (gray-blue)
  content = content.replace(/rgba\(30,\s*41,\s*59/g, 'rgba(26, 26, 26'); // slate-800 to stage-surface
  content = content.replace(/rgba\(15,\s*23,\s*42/g, 'rgba(10, 10, 10'); // slate-900 to stage-bg
  
  // Old gold to new gold in radial gradients
  content = content.replace(/rgba\(251,\s*191,\s*36/g, 'rgba(212, 175, 55');

  // Specific fixes for login/signup Glass Cards to match the theme
  if (content.includes('.glass-card {') && content.includes('rgba(255, 255, 255, 0.1)')) {
     content = content.replace(/border:\s*1px\s*solid\s*rgba\(255,\s*255,\s*255,\s*0\.1\);/, 'border: 1px solid rgba(212, 175, 55, 0.2);\n        box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);');
  }
  if (content.includes('.glass-card {') && content.includes('rgba(255, 255, 255, 0.08)')) {
     content = content.replace(/border:\s*1px\s*solid\s*rgba\(255,\s*255,\s*255,\s*0\.08\);/, 'border: 1px solid rgba(212, 175, 55, 0.2);\n      box-shadow: 0 0 40px rgba(0,0,0,0.8), 0 0 15px rgba(212, 175, 55, 0.05);');
  }
  
  const fileName = path.basename(filePath);
  // Make inputs in login/signup look more theatrical (gold border)
  if (fileName === 'login.jsp' || fileName === 'signup.jsp' || fileName === 'adminLogin.jsp' || fileName === 'adminSignup.jsp') {
      content = content.replace(/border-white\/20/g, 'border-stage-secondary/40');
  }

  fs.writeFileSync(filePath, content, 'utf8');
});
console.log('Slate colors completely replaced with Stage Design System colors.');