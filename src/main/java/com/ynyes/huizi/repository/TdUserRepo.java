package com.ynyes.huizi.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ynyes.huizi.entity.TdUser;

/**
 * TdUser 实体数据库操作接口
 * 
 * @author Sharon
 *
 */

public interface TdUserRepo extends
		PagingAndSortingRepository<TdUser, Long>,
		JpaSpecificationExecutor<TdUser> 
{
    // 根据角色查找
    Page<TdUser> findByRoleIdOrderByIdDesc(Long roleId, Pageable page);
    
    Page<TdUser> findByRoleIdAndUserLevelIdOrderByIdDesc(Long roleId, Long UserLevelId, Pageable page);
    
    Page<TdUser> findByUsernameContainingOrMobileContainingOrEmailContainingOrderByIdDesc(String keywords1, String keywords2, String keywords3, Pageable page);
    
    Page<TdUser> findByUsernameContainingAndUserLevelIdOrMobileContainingAndUserLevelIdOrEmailContainingAndUserLevelIdOrderByIdDesc(String keywords1, Long userLevelId, String keywords2, Long userLevelId1, String keywords3, Long userLevelId2, Pageable page);
    
    Page<TdUser> findByUsernameContainingAndRoleIdOrMobileContainingAndRoleIdOrEmailContainingAndRoleIdOrderByIdDesc(String keywords1, 
                                                                Long roleId1,
                                                                String keywords2,
                                                                Long roleId2,
                                                                String keyword3,
                                                                Long roleId3,
                                                                Pageable page);
    
    Page<TdUser> findByUsernameContainingAndRoleIdAndUserLevelIdOrMobileContainingAndRoleIdAndUserLevelIdOrEmailContainingAndRoleIdAndUserLevelIdOrderByIdDesc(String keywords1, 
													            Long roleId1,Long UserLevelId,
													            String keywords2,
													            Long roleId2,Long UserLevelId1,
													            String keyword3,
													            Long roleId3,Long UserLevelId2,
													            Pageable page);
    
    TdUser findByMobileAndStatusIdOrMobileAndStatusId(String mobile, Long statusId, String mobile1, Long statusId1); // 手机号已验证查找
    
    
    TdUser findByUsernameAndStatusIdOrUsernameAndStatusId(String username, Long statusId, String username1, Long statusId1);
    
    TdUser findByUsername(String username);
    
    TdUser findByUsernameAndIdNot(String username, Long id);
    
    Page<TdUser> findByUpperUsernameAndStatusIdOrderByIdDesc(String upperUsername, Long statusId, Pageable page);
    
    Page<TdUser> findByUserLevelIdOrderByIdDesc(Long userlevelId, Pageable page);
    
    List<TdUser> findByStatusId(Long statusId);
    
    TdUser findByAlipayUserId(String alipay_userid); // 支付宝用户名查找
    
    TdUser findByQqUserId(String qqUserId);
    
    TdUser findByWeixinUserId(String weiUserId);
    
    TdUser findByOpenid(String openid);
}
