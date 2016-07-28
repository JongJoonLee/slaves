package com.example.dao;

import org.springframework.data.mongodb.core.MongoTemplate;

import com.example.bean.TestVO;
 
 
public class InsertThread implements Runnable{
 
    private MongoTemplate mongoTemplate;
    private long l;
    
    private final int DEST_NUMBER = 200000;
    
    
    public InsertThread(MongoTemplate mongoTemplate, long startNumber){
        this.mongoTemplate = mongoTemplate;
        this.l = startNumber;
    }
    
    @Override
    public void run() {
        // TODO Auto-generated method stub
        TestVO testVO = null;
        
        for(long start = l; start < (l+DEST_NUMBER); start++){
            
            testVO = new TestVO();
            testVO.setName("에반게리온 " + start +" 호기");
            testVO.setId("test"+ start);
            
            mongoTemplate.insert(testVO, "person3");
            
            try {
                Thread.sleep(1);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            
        }
        
    }
 
    
    
}
