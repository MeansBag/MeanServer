package com.fh.service.manager.user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.DateUtil;
import com.fh.util.PageData;


@Service("userDetailService")
public class UserDetailService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public PageData findByUserCode(PageData pd)throws Exception{
	    return (PageData)dao.findForObject("UserDetailMapper.findByUserCode", pd);
	}
	
	/**
	 * @describe:分页查询用户列表
	 * @author: zhangchunming
	 * @date: 2016年9月28日下午4:51:06
	 * @param page
	 * @throws Exception
	 * @return: List<PageData>
	 */
    public List<PageData> listPageUserDetail(Page page)throws Exception{
        return (List<PageData>) dao.findForList("UserDetailMapper.userbuylistPage", page);
    }
    /**导出报表查询符合条件所有数据
     * @describe:
     * @author: zhangchunming
     * @date: 2016年9月28日下午4:51:21
     * @param pd
     * @throws Exception
     * @return: List<PageData>
     */
    public List<PageData> listUserDetail(PageData pd)throws Exception{
        return (List<PageData>) dao.findForList("UserDetailMapper.userbuylist", pd);
    }
    /**
     * @describe:查询下级会员，及对应奖励
     * @author: zhangchunming
     * @date: 2016年9月26日下午5:58:27
     * @param page
     * @throws Exception
     * @return: List<PageData>
     */
    public List<PageData> listPageVIP(Page page)throws Exception{
        return (List<PageData>) dao.findForList("UserDetailMapper.listPageVIP", page);
    }
    
    /**
     * @describe:更新订单状态
     * @author: kezhiyi
     * @date: 2016年9月25日
     * @param pd
     * @throws Exception
     * @return: void
     */
    public void updateBuyStatus(PageData pd)throws Exception{
        pd.put("operator", "sys");
        dao.update("UserDetailMapper.updatebuyflag", pd);
    }
    /**
     * @describe:更新订单状态
     * @author: kelvin
     * @date: 2016年9月25日
     * @param pd
     * @throws Exception
     * @return: void
     */
    public void updateUserType(PageData pd)throws Exception{
        pd.put("operator", "sys");
        dao.update("UserDetailMapper.changeusertype", pd);
        dao.update("UserDetailMapper.changeusertypedetail", pd);
        dao.update("UserDetailMapper.changeusertypefriend", pd);
        
        
    }
    
    
    /**
     * @describe:更新用户状态
     * @author: zhangchunming
     * @date: 2016年9月26日下午4:57:44
     * @param pd
     * @throws Exception
     * @return: void
     */
    public void updateUserStatus(PageData pd)throws Exception{
        dao.update("UserDetailMapper.updateUserStatus", pd);
    }
    public void resetPassword(PageData pd)throws Exception{
        dao.update("UserDetailMapper.resetPassword", pd);
    }
    /**
     * @describe:根据id查询会员信息
     * @author: zhangchunming
     * @date: 2016年9月26日下午6:03:11
     * @param page
     * @throws Exception
     * @return: PageData
     */
    public PageData getUserDetailById(Page page)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.getUserDetailById", page);
    }
    /**
     * @describe:根据用户名查询会员信息
     * @author: zhangchunming
     * @date: 2016年9月26日下午6:02:49
     * @param pd
     * @throws Exception
     * @return: PageData
     */
    public PageData findByUserName(PageData pd)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.findByUserName", pd);
    }
    /**
     * @describe:根据手机号查询会员信息
     * @author: zhangchunming
     * @date: 2016年9月26日下午6:02:49
     * @param pd
     * @throws Exception
     * @return: PageData
     */
    public PageData findByPhone(PageData pd)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.findByPhone", pd);
    }
    /**
     * @describe:查询会员数量
     * @author: zhangchunming
     * @date: 2016年9月26日下午8:15:58
     * @param pd
     * @throws Exception
     * @return: PageData
     */
    public PageData findcount(PageData pd)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.findcount", pd);
    }
    public PageData findUserInfoByPhone(String phone)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.findUserInfoByPhone", phone);
    }
    
    public PageData findUserInfoByUserName(String userName)throws Exception{
        return (PageData)dao.findForObject("UserDetailMapper.findUserInfoByUserName", userName);
    }
    /**
     * @describe:根据条件查询所有手机号
     * @author: zhangchunming
     * @date: 2016年10月20日下午4:52:08
     * @param pd
     * @throws Exception
     * @return: List<PageData>
     */
    public List<PageData> findAllPhoneByCondition(PageData pd)throws Exception{
        return (List<PageData>)dao.findForList("UserDetailMapper.findAllPhoneByCondition", pd);
    }
}

