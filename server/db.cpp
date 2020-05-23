// pch.cpp: 미리 컴파일된 헤더에 해당하는 소스 파일입니다. 성공하려면 컴파일이 필요합니다.

#include "db.h"



DB::DB() : connection(NULL) {};
DB::DB(const char* host, const char* user, const char* passwd, const char* db) {
	mysql_init(&conn);
	if ((connection = mysql_real_connect(&conn, host, user, passwd, db, 3306, (char*)NULL, 0)) == NULL) {
		std::cout << "Mysql 에러 : " << mysql_error(&conn) << std::endl;
		class_stat = false;
		return;
	}

	if (mysql_select_db(&conn, db)) {
		std::cout << mysql_errno(&conn) << " 에러 : " << mysql_error(&conn) << std::endl;
		class_stat = false;
		return;
	}
	mysql_query(connection, "set session character_set_connection=euckr;");
	mysql_query(connection, "set session character_set_results=euckr;");
	mysql_query(connection, "set session character_set_client=euckr;");
	class_stat = true;
}
bool DB::exit_db() {
	if (class_stat) {
		mysql_close(connection);
		return true;
	}
	return false;
}
std::string DB::search(const char* table, int args, ...) {
	std::string tmp = "select *from ", result_str;
	tmp = tmp + table + " where ";
	va_list ap;
	va_start(ap, args);
	for (int i = 0; i < args - 1; i++) {
		tmp = tmp + va_arg(ap, const char*) + ", ";
	}
	tmp = tmp + va_arg(ap, const char*) + ");";
	va_end(ap);
	std::lock_guard<std::mutex> guard(DB_mtx);
	if ((query_stat = mysql_query(connection, tmp.c_str())) != 0) {
		std::cout << "Mysql 에러 : " << mysql_error(&conn) << std::endl;
		DB_mtx.unlock();
		return NULL;
	}
	if ((sql_result = mysql_store_result(connection)) == NULL) {
		std::cout << "Mysql 에러 : " << mysql_error(&conn) << std::endl;
		DB_mtx.unlock();
		return NULL;
	}
	int num_fields = mysql_num_fields(sql_result);
	while ((sql_row = mysql_fetch_row(sql_result)) != NULL) {
		for (int i = 0; i < num_fields; i++)
			result_str = result_str + sql_row[i] + " ";

		
	}
	mysql_free_result(sql_result);
	

	return result_str;
}