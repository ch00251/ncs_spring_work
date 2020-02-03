package com.gura.spring05.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.spring05.member.dto.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	//핵심 의존 객체를 spring 으로 부터 주입 받기 (Dependency Injection)
	@Autowired
	private SqlSession session;

	@Override
	public List<MemberDto> getList() {
		List<MemberDto> list=session.selectList("member.getList");
		return list;
	}
	
	@Override
	public void delete(int num) {//파라미터로 전달했으면 전달한 타입을 기억하기(int)
		//session을 이용해서 (member의 namespace.mapper의 id, 삭제할 번호) 전달
		session.delete("member.delete", num);
	}

	@Override
	public void insert(MemberDto dto) {
		session.insert("member.insert", dto);
		
	}

	@Override
	public MemberDto getData(int num) {
		MemberDto dto=session.selectOne("member.getData", num);
		return dto;
	}

	@Override
	public void update(MemberDto dto) {
		session.update("member.update",dto);
	}
	
	
}
