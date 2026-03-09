const fs = require('fs');

function fixBody(filePath) {
  let content = fs.readFileSync(filePath, 'utf8');
  if (!content.includes('linear-gradient(180deg, #0f0f0f')) {
    content = content.replace(/<body class="([^"]+)"/, '<body class="$1" style="background: linear-gradient(180deg, #0f0f0f 0%, #000000 100%); min-height: 100vh;"');
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('Fixed', filePath);
  }
}

fixBody('src/main/webapp/WEB-INF/views/actorDetail.jsp');
fixBody('src/main/webapp/WEB-INF/views/mypage.jsp');
