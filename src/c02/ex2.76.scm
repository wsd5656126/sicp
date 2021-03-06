;; 新加入操作需要的操作:
;;   显式分派的通用性操作:
;;     加入新类型: 修改分派所有代码(manager修改所有过程)
;;     加入新操作: 增加分派的新操作(manager增加过程)
;;   数据导向的风格:最适合经常需要加入新操作的系统
;;     加入新类型: 将新类型的所有方法注册到表格中
;;     加入新操作: 将所有类型的新操作都加入到表格中
;;   消息传递的风格:最适合经常需要加入新类型的系统
;;     加入新类型: 不需要更改
;;     加入新操作: 所有类型的新操作都需要增加

;; 显示分派: 都不适合

;; 数据导向: 通过包机制增加新类型和新的通用操作,无论新类型和新操作,都适合

;; 消息传递: 适合增加新类型;但是不适合新操作,因为新操作必须全部重新实例化.
