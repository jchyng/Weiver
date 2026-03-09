package weiver.web.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import weiver.service.LoginService;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
public class LoginViewController {
    @Autowired
    private LoginService loginService; 
    
    // 로그인 페이지
    @GetMapping(value = "/login")
    public String loginPage(HttpSession session, Model model) {
        if(session.getAttribute("userId") != null) {
            return "redirect:/";
        }        
        return "login";
    }
    
    // 회원가입 페이지
    @GetMapping(value = "/signup")
    public String signupPage() {
        return "signup";
    }
    
    // 로그아웃
    @GetMapping(value = "/logout")
    public String logout(HttpSession session) {
        if(session != null) {
            session.invalidate();
            log.info("로그 아웃 완료");
        }
        return "redirect:/";
    }
    
    // 회원 탈퇴
    @GetMapping(value = "/signOut")
    public String removeUser(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        
        try {
            loginService.removeUser(userId);
            session.invalidate();
            log.info("회원 탈퇴 처리됨: {}", userId);
        } catch (Exception e) {
            log.error("회원 탈퇴 중 오류 발생: {}", e.getMessage());
        }
        
        return "redirect:/";
    }
}
