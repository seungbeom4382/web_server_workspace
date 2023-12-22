package com.sh.ajax.common;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;

import static com.sh.ajax.common.SqlSessionTemplate.getSqlSession;
import static org.assertj.core.api.Assertions.assertThat;

public class SqlSessionTest {

    @Test
    public void test() {
        SqlSession session = getSqlSession();
        assertThat(session).isNotNull();
    }
}
