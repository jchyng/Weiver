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

  // Update tailwind config
  content = content.replace(/'stage-secondary':\s*'#[A-Fa-f0-9]+',/g, "'stage-secondary': '#D4AF37',");
  content = content.replace(/'stage-bg':\s*'#[A-Fa-f0-9]+',/g, "'stage-bg': '#0a0a0a',");
  content = content.replace(/'stage-surface':\s*'#[A-Fa-f0-9]+',/g, "'stage-surface': '#1a1a1a',");
  content = content.replace(/'stage-text-sub':\s*'#[A-Fa-f0-9]+',/g, "'stage-text-sub': '#a1a1aa',");
  if (content.includes('colors: {') && !content.includes("'stage-gold-glow'")) {
      content = content.replace(/colors:\s*{/, "colors: {\n              'stage-gold-glow': '#FFD700',");
  }

  // Update Fonts
  if (content.includes('family=Playfair+Display') && !content.includes('family=Cinzel')) {
      content = content.replace(/family=Playfair\+Display:wght@700&display=swap/g, "family=Playfair+Display:wght@700&family=Cinzel:wght@600;700&display=swap");
  }
  if (content.includes("serif: ['Playfair Display', 'serif']") && !content.includes("'Cinzel'")) {
      content = content.replace(/serif:\s*\['Playfair Display',\s*'serif'\]/g, "serif: ['Cinzel', 'Playfair Display', 'serif']");
  }

  // Update Body
  if (content.includes('<body class="') && !content.includes('linear-gradient')) {
      content = content.replace(/<body class="([^"]+)"/, '<body class="$1" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;"');
  }

  // Spotlight glow
  content = content.replace(/box-shadow:\s*0\s+0\s+\d+px\s+rgba\(251,\s*191,\s*36,\s*0\.\d+\);/g, "box-shadow: 0 0 15px rgba(212, 175, 55, 0.3); border-color: rgba(212, 175, 55, 0.5);");

  fs.writeFileSync(filePath, content, 'utf8');
});

console.log('Updated ' + jspFiles.length + ' JSP files.');
