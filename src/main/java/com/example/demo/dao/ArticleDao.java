package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {

	@Insert("""
			INSERT INTO article
				SET regDate = NOW()
					, updateDate = NOW()
					, MemberId = #{loginedMemberId}
					, title = #{title}
					, `body` = #{body}
			""")
	public void writeArticle(int loginedMemberId, String title, String body);

	@Select("""
			SELECT LAST_INSERT_ID();
			""")
	public int getLastInsertId();

	@Select("""
			SELECT a.regDate, a.upDateDate, m.loginId, a.title, a.body
					FROM article AS a
					INNER JOIN `member` AS m
					ON a.memberId = m.id
					ORDER BY a.id DESC
			""")
	public List<Article> getArticles();

	@Select("""
			SELECT a.*, m.loginId
					FROM article AS a
					INNER JOIN `member` AS m
					ON a.memberId = m.id
					WHERE a.id = #{id}
					ORDER BY a.id DESC
			""")
	public Article getArticleById(int id);

	@Update("""
			<script>
			UPDATE article
				SET <if test="title != null and title !=''">
					title = #{title}
					</if>
					<if test="body != null and body !=''">
					, `body` = #{body}
					</if>
					, updateDate = NOW()
				WHERE id = #{id}
			</script>
			""")
	public void setArticle(int id, String title, String body);

	@Delete("""
			DELETE FROM article
				WHERE id = #{id}
			""")
	public void deleteArticle(int id);

}
