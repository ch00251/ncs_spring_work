package com.gura.spring05.users.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gura.spring05.users.dao.UsersDao;

@Service
public class UsersSerivceImpl implements UsersService{

	@Autowired
	private UsersDao dao;
	//인자로 전달된 아이디가 존재하는지 여부를 Map 에 담아서 리턴하는 메소드
	@Override
	public Map<String, Object> isExistId(String inputId) {
		boolean isExist=dao.isExist(inputId);
		Map<String, Object> map=new HashMap<>();//Map에 {"isExist":true} 이런식으로 응답함
		map.put("isExist", isExist);//isExist라는 key값으로 true,false가 담긴다.
		return map;
	}

}
