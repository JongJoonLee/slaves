package com.example.dao;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import com.example.bean.TestVO;
 
public class MongoDAO {
    
    private MongoTemplate mongoTemplate;
    
    public void setMongoTemplate(MongoTemplate mogoTemplate) {
        this.mongoTemplate = mogoTemplate;
    }
    
    public void insertTestVO(){
        TestVO testVO = new TestVO();
        testVO.setId("king");
        testVO.setName("고길동");
        testVO.setPassword("asd");
        
        mongoTemplate.insert(testVO, "person");
    }
    
    
    /**
     * 업데이트
     */
    public void updatePerson(){
        
        // 아래는 db.person.update( { "name" : "김석현" } ) 와 같은 구문( 수정할 대상의 조건 )
        Criteria criteria = new Criteria("name");
        criteria.is("김석현");
        // import org.springframework.data.mongodb.core.query.Query;
        // criteria는 그냥은 못쓰고 아래와 같이 Query를 이용한다.
        Query query = new Query(criteria);
        
        
        // import org.springframework.data.mongodb.core.query.Update;
        // 업데이트 할 항목 정의
        Update update = new Update();
        // 부분적으로 변경
        update.set("job", "백수");
        
        // 검색 결과의 하나를 수정
        mongoTemplate.updateFirst(query, update, "person");
 
        /*
        // 검색결과의 전부 ( 컬렉션에대해서 전체 문서 )
        mongoTemplate.updateMulti(query, update, "person");
        // 조건없이 전체 다 실행 ( 컬렉션에 있는 모든 문서한테 )
        mongoTemplate.updateMulti(new Query(), update, "person");
         */    
    }
    
    /**
     * 전체 삭제
     */
    public void deletePerson(){
        
        mongoTemplate.remove(new Query(), "person");
        
    }
    
    
    /**
     * 부분 삭제
     * @param name
     */
    public void deletePersonByName(String name){
        
        Criteria criteria = new Criteria("name");
        criteria.is(name);
        Query query = new Query(criteria);
        
        mongoTemplate.remove(query, "person");
        
        
    }

    
    
    /**
     * 대량 데이터 주입(Thread를 활용)
     */
    public void insertPersonMassive() {
          
          InsertThread threads[] = new InsertThread[5000];
          
          for( int i = 0 ; i < 16; i++) {
             threads[i] = new InsertThread(mongoTemplate, i * 200000);
             new Thread(threads[i]).start();
          }
    }
    
    
    /**
     * 데이터 찾기
     * 
     * @param name
     */
    public void findPersonByName(String name){
        
        Criteria criteria = new Criteria("name");
        criteria.is(name);
        
        Query query = new Query(criteria);
        
        // person3라는 컬렉션에서 query조건을 검색해 TestVO.class로 결과를 받아온다.
        TestVO testVO = mongoTemplate.findOne(query, TestVO.class, "person3");
        
        // 검색되어진 이름의 직업을 받아온다.
        System.out.println(testVO.getId());
        
    }
    
    
    



    
   
 
}