package com.sh.mvc.board.model.service;
import com.sh.mvc.board.model.dao.BoardDao;
import com.sh.mvc.board.model.entity.Attachment;
import com.sh.mvc.board.model.entity.Board;
import com.sh.mvc.board.model.entity.BoardComment;
import com.sh.mvc.board.model.vo.BoardVo;
import org.apache.ibatis.session.SqlSession;
import java.util.List;
import java.util.Map;
import static com.sh.mvc.common.SqlSessionTemplate.getSqlSession;
public class BoardService {
    private BoardDao boardDao = new BoardDao();
    public List<Board> findAll() {
        SqlSession session = getSqlSession();
        List<Board> boards = boardDao.findAll(session);
        session.close();
        return boards;
    }

    public BoardVo findById(long id, boolean hasRead) {
        SqlSession session = getSqlSession();
        BoardVo board = null;
        int result = 0;
        try {
            // 조회수 증가처리
            if (!hasRead)
                result = boardDao.updateBoardReadCount(session, id);

            // 조회
            board = boardDao.findById(session, id);
            List<BoardComment> comments = boardDao.findCommentByBoardId(session, id);
            board.setComments(comments);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
//        BoardVo board = boardDao.findById(session, id); // select * from board where id = ?
//        Member member = memberDao.findById(session, board.getMemberId()); // select * from member where id = ?
//        List<Attachment> attachments = boardDao.findAttachmentByBoardId(session, id); // select * from attachment where board_id = ?
//        board.setMember(member);
//        board.setAttachments(attachments);
        return board;
    }

    /**
     * 조회수 상관없이 게시글 조회해야 하는 경우
     *
     * @param id
     * @return
     */
    public BoardVo findById(long id) {
        return findById(id, true);
    }
    /**
     * 트랜잭션관리
     * - Board등록
     * - Attachment등록
     *
     * @param board
     * @return
     */
    public int insertBoard(BoardVo board) {
        int result = 0;
        SqlSession session = getSqlSession();
        try {
            // board 테이블에 등록
            result = boardDao.insertBoard(session, board);
            System.out.println("BoardService#insertBoard : board#id = " + board.getId());
            // attachment 테이블에 등록
            List<Attachment> attachments = board.getAttachments();
            if (!attachments.isEmpty()) {
                for (Attachment attach : attachments) {
                    attach.setBoardId(board.getId()); // fk boardId 필드값 대입
                    result = boardDao.insertAttachment(session, attach);
                }
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
    public int updateBoard(BoardVo board) {
        int result = 0;
        SqlSession session = getSqlSession();
        try {
            // board테이블 수정
            result = boardDao.updateBoard(session, board);

            // attachment테이블 삭제
            List<Long> delFiles = board.getDelFiles();
            if (!delFiles.isEmpty()) {
                for (Long id : delFiles) {
                    result = boardDao.deleteAttachment(session, id);
                }
            }
            // attachment테이블 등록
            List<Attachment> attachments = board.getAttachments();
            if (!attachments.isEmpty()) {
                for (Attachment attach : attachments) {
                    attach.setBoardId(board.getId()); // fk 등록
                    result = boardDao.insertAttachment(session, attach);
                }
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
    public int deleteBoard(long id) {
        int result = 0;
        SqlSession session = getSqlSession();
        try {
            result = boardDao.deleteBoard(session, id);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
    public int getTotalCount() {
        SqlSession session = getSqlSession();
        int totalCount = boardDao.getTotalCount(session);
        session.close();
        return totalCount;
    }
    public List<BoardVo> findAll(Map<String, Object> param) {
        SqlSession session = getSqlSession();
        List<BoardVo> boards = boardDao.findAll(session, param);
        session.close();
        return boards;
    }
    public int insertBoardComment(BoardComment comment) {
        int result = 0;
        SqlSession session = getSqlSession();
        try {
            result = boardDao.insertBoardComment(session, comment);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    public int deleteBoardComment(long id) {
        int result = 0;
        SqlSession session = getSqlSession();
        try {
            result = boardDao.deleteBoardComment(session, id);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
}