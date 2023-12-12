package com.sh.mvc.common;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

/**
 * setter PreparedStatement에 ? 값대입
 * getter * 3 PreparedStatement/CallableStatement에서 값을 가져올때
 */
@MappedTypes(List.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class ListStringTypeHandler extends BaseTypeHandler<List<String>> {
    /**
     * List요소를 꺼내서 ,기준으로 연결해 하나의 문자열을 반환
     * @param preparedStatement
     * @param i
     * @param strings
     * @param jdbcType
     * @throws SQLException
     */
    @Override // setter는 null이 아닐때만 호출
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, List<String> strings, JdbcType jdbcType) throws SQLException {
        String value = "";
        for(int j=0; j<strings.size(); j++){
            String v = strings.get(j);
            value += v;
            if(j != strings.size() - 1)
                value += ",";
        }
        preparedStatement.setString(i, value);
    }

    @Override // null일 경우도 호출
    public List<String> getNullableResult(ResultSet resultSet, String columnName) throws SQLException {
        String value = resultSet.getString(columnName);
        if(value != null){
            return Arrays.asList(value.split(","));
        }
        return null;
    }

    @Override
    public List<String> getNullableResult(ResultSet resultSet, int colunmIndex) throws SQLException {
        String value = resultSet.getString(colunmIndex);
        if(value != null){
            return Arrays.asList(value.split(","));
        }
        return null;
    }

    @Override
    public List<String> getNullableResult(CallableStatement callableStatement, int colunmIndex) throws SQLException {
        String value = callableStatement.getString(colunmIndex);
        if(value != null){
            return Arrays.asList(value.split(","));
        }
        return null;
    }
}
