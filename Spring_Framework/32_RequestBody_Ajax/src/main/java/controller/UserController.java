package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import vo.UserVO;

@Controller
public class UserController {
	public static final String VIEW_PATH = "/WEB-INF/views/";
	
	@RequestMapping(value="/join.do", method = {RequestMethod.GET})
	public @ResponseBody Map<String, Object> get_join_param(UserVO user) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    System.out.println("input");
	    map.put("name", user.getName());
	    map.put("age", user.getAge());
	    map.put("email", user.getEmail());
	    return map;
	}
	
	@RequestMapping(value="/join.do", method = {RequestMethod.POST})
	public @ResponseBody Map<String, Object> post_join_json(@RequestBody UserVO user) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    System.out.println("input");
	    map.put("name", user.getName());
	    map.put("age", user.getAge());
	    map.put("email", user.getEmail());
	    return map;
	}

		
}
