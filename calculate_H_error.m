function [H_area_ref,H_error] = calculate_H_error(X_area,Y_area,H_area,Parameter_calculate_H_error,TYPE)
% ���������������롰���洦���õ��ĵؾ�ƽ��߳�ͼ H_area�����Ӧ�����۸߳�ͼ
% H_area_ref���Լ����洦����������۸߳�ͼ����� H_error��
%
% ������
%   ����������ԭʼ����ʱ�����㳡��ģ�͸߳���Ϣ�ķ�����ֱ������
%   �� X_area , Y_area , H_area����������Ϣ����õ����Ӧ�����۸߳�ͼ����
%   ȱ����������Ȼû�н�б��ƽ��ĸ߳���Ϣ H_area ���յؾ�����ϵ����ͶӰ��Ҳ��
%   ��˵�ؾ�ƽ����Ȼ���ǵȼ���ġ�
%
% �������ݣ�
% 1��X_area  �Ǹ��洦�����յõ� H_area �󣬼���õ�����֮���Ӧ�ĵ��� x �����ꣻ
% 2��Y_area  ͬ�ϣ�����֮���Ӧ�ĵ��� y �����ꣻ
% 3��H_area  ����õ��ĸ߳���Ϣ�����Ҹ��洦���Ľ������
% 4��Parameter_calculate_H_error ����Ҫ��һЩ������
%    a����1,1����ʾ��x1      �������ĵĵؾ� X �����ꣻ
%    b����2,1����ʾ��y1      �������ĵĵؾ� Y �����ꣻ
%    c����3,1����ʾ��r_cone  ���������õ�Բ׶�����İ뾶��
%              �����ƽ�س��������ڲ��漰����ֵ����������ֵΪ0�����뺯�����㣻
%    d����4,1����ʾ��r_cone_Height ���������õ�Բ׶�������ĵĸ߶ȣ����߶�ֵ����
%              �����ƽ�س��������ڲ��漰����ֵ����������ֵΪ0�����뺯�����㣻
% 5��TYPE    ������ȡֵ��
%    a��TYPE == 1������ƽ�س�������ʱ�����߳���ϢΪ0������򵥵������
%    b��TYPE == 2������Բ׶��������ʱ��Ҫһ���ķ�������õ���Ҫ����Ϣ��
%
% ������ݣ�
% 1��H_area_ref      ���� H_area ���Ӧ�����۸߳�ͼ H_area_ref��
% 2��H_error         ���洦����������۸߳�ͼ����
%
% ����汾��ֹ����
% 2015.01.29. 11:28 a.m.

%%
% --------------------------------------------------------------------
%                    ������ H_area ���Ӧ�����۸߳�ͼ
%                   ������洦����������۸߳�ͼ�����
% --------------------------------------------------------------------
[num_y,num_x] = size(H_area);
x1 = Parameter_calculate_H_error(1,1);
y1 = Parameter_calculate_H_error(2,1);
r_cone = Parameter_calculate_H_error(3,1);
r_cone_Height = Parameter_calculate_H_error(4,1);


% ********************************************************************
%                               ƽ�س���ʱ
% ********************************************************************
if TYPE == 1    % ƽ�س���
    % ��ʱ H_area_ref == 0 ����˲���Ҫ�ٽ��м��㣬����ֱ�ӵõ��������
    H_area_ref = 0.*zeros(num_y,num_x);
    H_error = H_area - H_area_ref;
end

% ********************************************************************
%                               Բ׶����ʱ
% ********************************************************************
if TYPE == 2    % Բ׶����
    % ��ʱ H_area_ref ��Ҫ�����㣬�Ա��� H_area ���������Ӧ 
    % ���ȼ���ÿ��ĵ���б�ࣨ ����ڳ�������(x1,y1) ��
    R_target_all = sqrt( ((X_area - x1).^2) + ((Y_area - y1).^2) );
    % �������á��߼�1Ѱ�á��Ĺ��ܣ��������� H_area ���Ӧ�����۸߳�ͼ
    L = (R_target_all <= r_cone);       % ��ֵ���ұߣ����й�ϵ�Ƚϣ������߼������
                                        % ������ R_target_all ά����С��ͬ��
                                        % ��0��1���߼����飻1��ʾ���桱
                                        % �ڴ� L ������ȡ 1 ��λ�ö�Ӧ�� R_target_all
                                        % ����Ԫ��С�ڵ��� r_cone ��

    H_area_ref = zeros(num_y,num_x);    % ����������۸߳���Ϣ������
                                        % ��ʼֵ��Ϊ0��
    % ��������� H_area ���Ӧ�����۸߳�ͼ H_area_ref��
    for kk = 1:num_y
        for ll = 1:num_x
            if L(kk,ll) == 0
                continue;
            else
                H_area_ref(kk,ll) = (r_cone - R_target_all(kk,ll))*(r_cone_Height/r_cone);
            end      
        end
    end
    % ����������������Ǿ͵õ��� H_area_ref��
    % �������� H_area �� H_area_ref ������洦����������۸߳�ͼ�����
    H_error = H_area - H_area_ref;
    
    % ���ˣ����������
end

end