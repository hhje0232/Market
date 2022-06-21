package cart;

import java.sql.*;
import java.util.*;

import static db.jdbcUtil.*;

public class CartDAO {
	
	Connection con = null;
	PreparedStatement pstmt, pstmt2, pstmt3;
	ResultSet rs = null;
	
	public void insertCart(CartBean cart, String name, String id) {
		
		con = getConnection();
		int qty = 0;
		int price = 0;
		
		try {
			
			String sql = "SELECT * FROM cart WHERE name=? AND id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				
				sql = "INSERT INTO cart VALUES(?,?,?,?)";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setString(1, cart.getId());
				pstmt2.setString(2, cart.getName());
				pstmt2.setInt(3, cart.getQty());
				pstmt2.setInt(4, cart.getPrice());
				
				pstmt2.executeUpdate();
				
			} else {
				qty = rs.getInt("qty") + cart.getQty();
				price = rs.getInt("price") + cart.getPrice();
				
				
				sql = "UPDATE cart SET qty=?, price=? WHERE name=? AND id=?";
				pstmt3 = con.prepareStatement(sql);
				pstmt3.setInt(1, qty);
				pstmt3.setInt(2, price);
				pstmt3.setString(3, cart.getName());
				pstmt3.setString(4, id);
				
				pstmt3.executeUpdate();
				
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertCart()");
		} finally {
			close(rs);
			close(pstmt3);
			close(pstmt2);
			close(pstmt);
			close(con);
		}
		
	}
	
	public ArrayList<CartBean> selectCartList(String id){
		ArrayList<CartBean> cartList = null;
		
		con = getConnection();
		
		try {
			
			
			String sql = "SELECT * FROM cart WHERE id=?"; // 패스워드 조회 후 별도로 비교 시
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			
			cartList = new ArrayList<CartBean>();
			
			
			while(rs.next()) {
				CartBean cart = new CartBean();
				cart.setName(rs.getString("name")); 
				cart.setPrice(rs.getInt("price"));
				cart.setQty(rs.getInt("qty"));
				
				cartList.add(cart);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectCartList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		
		
		
		return cartList;
	}
	
	public ArrayList<CartBean> selectImageList(String name){
		ArrayList<CartBean> imageList = null;
		
		con = getConnection();
		
		try {
			
			
			String sql = "SELECT * FROM doll WHERE name=?"; // 패스워드 조회 후 별도로 비교 시
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			
			imageList = new ArrayList<CartBean>();
			
			
			while(rs.next()) {
				CartBean cart = new CartBean();
				cart.setImage(rs.getString("image"));
				
				imageList.add(cart);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectImageList()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		
		
		
		return imageList;
	}
	
	public int deleteCart(String id, String name) {
		int deleteCount = 0;
	
		con = getConnection();
		
		try {
			
			// 글번호와 패스워드가 모두 일치하는 게시물 조회
			String sql = "DELETE FROM cart WHERE id=? AND name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			
			
			deleteCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteCart()");
		} finally {
			close(pstmt);
			close(con);
		}
		
		
		
		return deleteCount;
		
	}
	
	
}
