package com.example.mvc1;
import static org.junit.Assert.*;
import org.junit.Test;
import com.example.controller.TestClass;
public class MyTest {
	@Test
	public void test1(){
		TestClass t = new TestClass();
		int result = t.sum(10, 30);
		assertEquals(45, result, 0);
		
	}
}
