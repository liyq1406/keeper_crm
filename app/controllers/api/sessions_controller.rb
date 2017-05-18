# 登录
class Api::SessionsController < Api::BaseController
	skip_before_filter :authenticate_user
	# 说明
	# 	
	# Params
	#   login: [String] 用户手机
	#   password: [String] 用户密码
	# Return
	# 	status: [String] success
	#   current_user: [Hash] current_user infos
	# 	token: [String] authenication_token
	# Error
	# 	status: [String] failed
	# 	msg: [String] 请输入正确的手机号跟密码
	def create
		user = User.find_by_mobile(params[:login])
    #authenticate是has_secure_password引入的一个方法，用来判断user的密码与页面中传过来的密码是否一致
    if user && user.authenticate(params[:password])
      render json: {status: :success, current_user: user, token: user.t_value, menu: user.right_menu[user.role]}
    else
    	render json: {status: :failed, msg: '请输入正确的手机号跟密码'}
    end
	end

end