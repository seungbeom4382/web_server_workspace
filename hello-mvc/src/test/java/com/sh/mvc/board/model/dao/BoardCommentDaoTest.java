package com.sh.mvc.board.model.dao;

import com.sh.mvc.board.model.entity.BoardComment;
import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.List;

import static com.sh.mvc.common.SqlSessionTemplate.getSqlSession;
import static org.assertj.core.api.Assertions.assertThat;

public class BoardCommentDaoTest {
    private BoardDao boardDao;
    private SqlSession session;

    @BeforeEach
    public void setUp(){
        this.boardDao = new BoardDao();
        this.session = getSqlSession();
    }
    @AfterEach
    public void tearDown(){
        this.session.rollback();
        this.session.close();
    }

    @DisplayName("BoardDao, SqlSession은 null이 아니다.")
    @Test
    public void test1(){
        assertThat(boardDao).isNotNull();
        assertThat(session).isNotNull();
    }

    @DisplayName("특정 게시글에 대한 댓글조회")
    @Test
    public void test2(){
        long boardId = 367;
        List<BoardComment> comments = boardDao.findCommentByBoardId(session, boardId);
        assertThat(comments)
                .isNotNull()
                .allSatisfy((boardComment) -> {
                    assertThat(boardComment.getId()).isNotZero();
                    assertThat(boardComment.getBoardId()).isEqualTo(boardId);
                    assertThat(boardComment.getContent()).isNotNull();
                    assertThat(boardComment.getRegDate()).isNotNull();
                });
    }

    @DisplayName("댓글 등록")
    @Test
    public void test3(){
        long boardId = 367;
        String memberId = "abcde";
        String content = "댓글";
        int commentLevel = 1;

        BoardComment comment = new BoardComment();
        comment.setBoardId(boardId);
        comment.setMemberId(memberId);
        comment.setContent(content);
        comment.setCommentLevel(commentLevel);

        int result = boardDao.insertBoardComment(session, comment); // selectKey를 통해 id반환
        assertThat(result).isGreaterThan(0);
        assertThat(comment.getId()).isNotNull().isNotZero();

        BoardComment comment2 = boardDao.findCommentById(session, comment.getId());
        assertThat(comment2)
                .isNotNull()
                .satisfies((c) -> {
                    assertThat(c.getId()).isNotZero().isEqualTo(comment.getId());
                    assertThat(c.getBoardId()).isEqualTo(boardId);
                    assertThat(c.getMemberId()).isEqualTo(memberId);
                    assertThat(c.getContent()).isEqualTo(content);
                    assertThat(c.getCommentLevel()).isEqualTo(commentLevel);
                });
    }

    @DisplayName("대댓글 등록")
    @Test
    public void test4(){
        long boardId = 367;
        String memberId = "abcde";
        String content = "대댓글";
        int commentLevel = 2;
        long parentCommentId = 22;

        BoardComment comment = new BoardComment();
        comment.setBoardId(boardId);
        comment.setMemberId(memberId);
        comment.setContent(content);
        comment.setCommentLevel(commentLevel);
        comment.setParentCommentId(parentCommentId);

        int result = boardDao.insertBoardComment(session, comment); // selectKey를 통해 id반환
        assertThat(result).isGreaterThan(0);
        assertThat(comment.getId()).isNotNull().isNotZero();

        BoardComment comment2 = boardDao.findCommentById(session, comment.getId());
        assertThat(comment2)
                .isNotNull()
                .satisfies((c) -> {
                    assertThat(c.getId()).isNotZero().isEqualTo(comment.getId());
                    assertThat(c.getBoardId()).isEqualTo(boardId);
                    assertThat(c.getMemberId()).isEqualTo(memberId);
                    assertThat(c.getContent()).isEqualTo(content);
                    assertThat(c.getCommentLevel()).isEqualTo(commentLevel);
                    assertThat(c.getParentCommentId()).isEqualTo(parentCommentId);
                });
    }

    @DisplayName("댓글 삭제")
    @Test
    public void test5() {
        // given - 1번 댓글이 존재한다고 가정
        long id = 22;
        BoardComment comment = boardDao.findCommentById(session, id);
        assertThat(comment).isNotNull();
        // when
        int result = boardDao.deleteBoardComment(session, id);
        assertThat(result).isGreaterThan(0);
        // then
        BoardComment comment2 = boardDao.findCommentById(session, id);
        assertThat(comment2).isNull();
    }
}