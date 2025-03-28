# 输入参数
total_cost = 500.0
original_users = 15
original_months = 3
user16_months = 2
actual_payment_original = 31.94
actual_payment_user16 = 20.8
print("【基础参数】")
print(f"总费用：{total_cost}元")
print(f"原15人每人使用月份：{original_months}个月")
print(f"第16人使用月份：{user16_months}个月")
print(f"原15人实际支付：{actual_payment_original}元/人")
print(f"第16人实际支付：{actual_payment_user16}元\n")
# 计算原总使用月份
original_total_months = original_users * original_months + 1 * user16_months
print("【使用月份计算】")
print(f"原始总使用月份 = {original_users}×{original_months} + 1×{user16_months} = {original_total_months}个月")
# 新人加入后的总使用月份
new_total_months = original_total_months + 3  # 新人使用3个月
print(f"新人加入后总使用月份 = {original_total_months} + 3 = {new_total_months}个月\n")A
# 调整后的每月费用
new_monthly_cost = total_cost / new_total_months
print("【费用单价计算】")
print(f"调整后每月费用 = {total_cost} / {new_total_months} = {new_monthly_cost:.2f}元/月\n")
# 计算每个原用户应支付的正确金额
correct_payment_original = original_months * new_monthly_cost
overpayment_original = actual_payment_original - correct_payment_original
correct_payment_user16 = user16_months * new_monthly_cost
overpayment_user16 = actual_payment_user16 - correct_payment_user16
print("【原用户多付款计算】")
print(f"原15人：")
print(f"  - 实际支付：{actual_payment_original}元")
print(f"  - 调整后应付：{original_months}×{new_monthly_cost:.2f} = {correct_payment_original:.2f}元")
print(f"  - 每人多付：{actual_payment_original} - {correct_payment_original:.2f} = {overpayment_original:.2f}元\n")
print(f"第16人：")
print(f"  - 实际支付：{actual_payment_user16}元")
print(f"  - 调整后应付：{user16_months}×{new_monthly_cost:.2f} = {correct_payment_user16:.2f}元")
print(f"  - 多付金额：{actual_payment_user16} - {correct_payment_user16:.2f} = {overpayment_user16:.2f}元\n")
# 新人需要补偿的总金额
total_refund = original_users * overpayment_original + overpayment_user16
# 输出结果
print("【最终补偿方案】")
print(f"新加入者应补偿：")
print(f"- 前15人每人：{overpayment_original:.2f}元")
print(f"- 第16人：{overpayment_user16:.2f}元")
print(f"总计：{total_refund:.2f}元")